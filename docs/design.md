# Plano — Design

Multi-tenant (per family) personal finance tracker. Incomes and expenses are
**private by default**; users may make records visible to their whole family
or share a specific bill with selected members to split its value.

Status: v1 — MVP scope (Phase 0 of roadmap).

---

## 1. Product scope

### In scope (MVP)

- Multi-family environment: a user may belong to one or more families.
- Create incomes and expenses privately.
- Mark a transaction as visible to the whole family.
- Share a transaction with selected family members and split its amount
  (equal-split default, per-member amounts editable).
- Split bookkeeping: each share has a status (`:pending` / `:settled`).
- Strong, policy-enforced privacy: nothing leaks outside its authorized audience.

### Explicitly out of scope (future)

- Categories / tags, budgets, reports, recurring transactions
- Settlement balancing (who owes whom), notifications, email invitations
- Multi-currency (per-member or per-transaction)
- Family owners adding users who don't exist yet

---

## 2. Domains

### `Plano.Accounts` (exists)

- `User` — owned by AshAuthentication (password strategy already installed).
- Single-currency MVP: each user has a **personal currency setting**
  (`Accounts.User` field, e.g. `currency`, default `:USD`) applied to new
  transactions. Note: MVP does **not** convert between currencies; shared
  transactions and family views assume one currency per family context.

### `Plano.Family` (new)

- `Family` — belongs to AshPostgres.
  - Fields: `name`, `default_currency` (Money's currency atom, inherited from
    creator at creation; family ctor/renew later), `created_by_user_id`.
  - Actions: `create` (current user becomes owner), `update`/`destroy`
    (owner only, guarded by policy), `read` (members only).
- `Membership` — join resource.
  - Fields: `family_id`, `user_id`, `role` (`:owner` | `:member`, default `:member`).
  - Constraints: unique index on `{family_id, user_id}`; exactly one owner per
    family is guaranteed by: `Family.create` inserts the first membership as
    owner; role changes limited by policy + validation ("cannot demote last owner").
  - Actions: create/register/update role/destroy — owner-only via policy.
  - Accepting a shared transaction requires membership, not a specific role.

### `Plano.Finance` (new)

- `Transaction`
  - Fields: `kind` (`:income` | `:expense`), `description`, `amount`
    (`Money` — Presents an `AshMoney` type; dual-write integer+currency under
    the hood via AshMoney extension), `date`, `visibility`
    (`:private` | `:family` | `:shared`, default `:private`), `family_id`
    (nil for purely personal records — see decision D1), `created_by_user_id`.
  - Attributes must satisfy: when `visibility == :family`, `family_id` is
    required; when `:shared`, `family_id` is required too (sharing happens
    inside a family; you can split with anyone in that family).
  - Actions:
    - `create` — author = actor; `family_id` (if set) must be one the actor
      belongs to (validated in change/preparation).
    - `update` / `destroy` — creator, or family owner (for `:family` /
      `:shared` records).
    - `read` — see §3 policies.
    - `share` action — sets `visibility: :shared` + upserts shares in one
      atomic change (see below).
- `TransactionShare`
  - Fields: `transaction_id`, `member_user_id` (must be a member of the
    transaction's family), `amount` (`Money`), `status`
    (`:pending` | `:settled`, default `:pending`), `settled_at` (nullable).
  - Unique index on `{transaction_id, member_user_id}`.
  - Validations:
    - Sum of shares == `transaction.amount` (enforced when sharing/creating;
      equal split is the default computed automatically if no amounts given).
    - No share for the transaction's creator unless the creator is explicitly
      included (creator's share defaults to remainder).
  - Action `mark_settled` — actor may settle only their own share.
    Neither creator nor owner may settle on behalf of another member in MVP.

---

## 3. Authorization (privacy-as-policy)

**Decision D1 (approved):** no Ash `multitenancy` attribute isolation.
Every record starts private; access is expressed entirely as **Ash policies**.
`family_id` is nullable so that personal records can exist without a family.

**Decision D2 (approved):** splits are **per-member amounts** (editable after
equal-split default). **Decision D3 (approved):** one currency for all in MVP,
stored as `Money` so the model is multi-currency-ready later.

Policy matrix (applies to `Transaction` and (read) `TransactionShare`):

| Visibility | Who can read | Who can update/destroy |
|---|---|---|
| `:private` | creator | creator |
| `:family` | creator + all members of `family_id` | creator or family owner |
| `:shared` | creator + members holding a `TransactionShare` | creator (+ owner per above) |

Concrete policy skeleton (implement in Phase 2, not yet enforced):

```elixir
policies do
  # creator bypass for everything they own
  always()
    |> expr(...)
  policy action_type(:read) do
    authorize_if expr(visibility == :private and created_by_user_id == ^actor(:id))
    authorize_if expr(visibility == :family and family_id in ^actor(:family))
    # ^ requires an actor aggregate/relationship "family" (list of family_ids)
    authorize_if exists(shares, member_user_id == ^actor(:id))
  end
  policy action_type([:update, :destroy]) do
    authorize_if expr(created_by_user_id == ^actor(:id))
    authorize_if expr(visibility != :private and
                      exists(family, exists(memberships, user_id == ^actor(:id) and role == :owner)))
  end
  policy update_only(actor_attribute_changed(:visibility)) do
    # changing to :shared requires TransactionShare authorization too
  end
end
```

`Membership` policies:
- Owner of family ⇒ everything on its memberships (create/update/destroy).
- Read: members of the family can read who else is in it (needed for share UI).

Other guarantees:
- `family_id` validation on create/update: actor must be member of that family.
- `TransactionShare.member_user_id` validation: target must be a member of the
  transaction's family.
- All policy checks happen server-side; no UI gating duplicates authorization.

---

## 4. Data & API namespaces

Directories to create in Phase 1/2:

```
lib/plano/family/family.ex
lib/plano/family/membership.ex
lib/plano/family.ex                # domain module
lib/plano/finance/transaction.ex
lib/plano/finance/transaction_share.ex
lib/plano/finance.ex               # domain module
```

Extensions: `AshPostgres.DataLayer`, `AshAuthentication` (existing),
`AshMoney` on `amount` fields, `AshAdmin` (dev only).

---

## 5. LiveView surface (Phase 4)

- `/families` — list my families; create new; family detail (members, roles,
  naming) with owner-only actions.
- `/transactions` — main list; filter tabs `mine | shared-with-me | family`.
- `/transactions/new` and `/transactions/:id/edit` —
  - kind, description, amount (Money), date, visibility selector
  - when targeting a family: family picker (my families)
  - when `:shared`: member multi-select with equal-split default; per-member
    editable amounts (AshPhoenix nested forms).
- `/` dashboard — recent transactions across the authorized scopes, per
  policy; only rows the current actor can see ever reach the client.

### Privacy behavior

- Filters in UIs are presentation aids only; enforcement lives in policies.
- Aggregates (totals) computed on server with policy-aware reads. Private rows
  don't influence any other member's view.
