# Plano — Design

Personal finance tracker for income and expenses. Every record is **private to
its owner by default** and requires no group. Groups, shared visibility, and
bill splitting are an optional social layer added on top of the personal
tracker.

Status: v2 — personal-first MVP scope (Phase 0 of roadmap).

---

## 1. Product scope

### In scope (MVP — personal finance)

- Accounts, authentication, and a per-user default currency.
- Create, edit, delete, and list incomes and expenses.
- Assign each transaction to a personal category (income or expense).
- Monthly dashboard: total income, total expenses, net, recent activity, and a
  per-category breakdown.
- Filter transactions by kind, month, and category.
- Strong, policy-enforced privacy: a transaction is only ever visible to the
  user who created it.

### Next (social layer, after the personal MVP)

- Create groups and manage memberships (owner/member roles).
- Mark a transaction as visible to a whole group.
- Share a specific bill with selected group members and split its amount
  (equal-split default, per-member amounts editable).
- Split bookkeeping: each share has a status (`:pending` / `:settled`).

### Explicitly out of scope (future)

- Budgets, recurring transactions, advanced reports, export
- Settlement balancing (who owes whom), notifications, email invitations
- Friends/relationships outside groups
- Multi-currency conversion, per-transaction multi-currency totals

---

## 2. Domains

### `Plano.Accounts` (exists)

- `User` — owned by AshAuthentication (password strategy already installed).
- Add a **personal currency setting** (`currency`, default `:USD`) used as the
  currency for newly created transactions.
- Changing the currency affects only future transactions; existing records keep
  the currency they were created with. Aggregates are grouped by currency so
  totals never mix units.

### `Plano.Finance` (new — personal core)

- `Category`
  - Fields: `user_id`, `name`, `kind` (`:income` | `:expense`), `color`
    (hex string, optional).
  - Unique index on `{user_id, kind, name}`.
  - Actions: create, read, update, destroy — all owner-scoped.
  - Categories are personal; they are never shared or visible to a group.
  - No hierarchy (sub-categories) in MVP.

- `Transaction`
  - Fields: `kind` (`:income` | `:expense`), `description`, `notes`
    (optional), `amount` (`Money` via `AshMoney`), `date`, `category_id`
    (nullable), `created_by_user_id`.
  - Validation: `category_id` must reference a category owned by the same user,
    and the category's `kind` must match the transaction's `kind`.
  - Currency: taken from the actor's `currency` setting at create time.
  - Actions:
    - `create` — author = actor; category validated against the actor.
    - `update` / `destroy` / `read` — creator only (owner-scoped policies).
  - No `group_id` or `visibility` field yet. These are added in a later phase
    as nullable columns, so the personal model stays minimal now.

### `Plano.Social` (later — not part of the personal MVP)

- `Group` — `name`, `created_by_user_id`, `created_at`.
  - Actions: create (creator becomes owner), update/destroy (owner only),
    read (members only).
- `Membership` — join resource.
  - Fields: `group_id`, `user_id`, `role` (`:owner` | `:member`, default
    `:member`).
  - Unique index on `{group_id, user_id}`.
  - `Group.create` inserts the first membership as owner in the same
    transaction. Validation: the last owner cannot be demoted or removed.
  - Actions: create/update role/destroy — owner-only via policy; read for
    members of the group.

### Sharing (later)

- `Transaction` gains `group_id` (nullable) and `visibility`
  (`:private` | `:group` | `:shared`, default `:private`).
  - When `visibility == :group`, `group_id` is required.
  - When `visibility == :shared`, `group_id` is required; splitting happens
    inside a group.
- `TransactionShare`
  - Fields: `transaction_id`, `member_user_id` (must be a member of the
    transaction's group), `amount` (`Money`), `status`
    (`:pending` | `:settled`, default `:pending`), `settled_at` (nullable).
  - Unique index on `{transaction_id, member_user_id}`.
  - Validations:
    - Sum of shares == `transaction.amount` (enforced when sharing/creating).
    - Equal split is the default when only members are provided.
    - No share for the transaction's creator unless explicitly included
      (the creator's share defaults to the remainder).
  - Action `mark_settled` — an actor may settle only their own share.

---

## 3. Authorization (privacy-as-policy)

**Decision D1 (approved):** no Ash `multitenancy` attribute isolation. Every
record starts private; access is expressed entirely as **Ash policies**. The
personal MVP therefore has no group/tenant requirement.

### Personal MVP

- `Category`: read/update/destroy only when `user_id == actor.id`; create sets
  `user_id` from the actor.
- `Transaction`: read/update/destroy only when
  `created_by_user_id == actor.id`; create sets the author from the actor.
- `category_id` ownership and kind match are validated server-side in a
  change/preparation.
- No UI gating duplicates authorization; filters are presentation aids only.

### Social layer (later)

Policy matrix (applies to `Transaction` and (read) `TransactionShare`):

| Visibility | Who can read | Who can update/destroy |
|---|---|---|
| `:private` | creator | creator |
| `:group` | creator + all members of `group_id` | creator or group owner |
| `:shared` | creator + members holding a `TransactionShare` | creator (+ group owner per above) |

`Membership` policies:
- Owner of the group ⇒ everything on its memberships (create/update/destroy).
- Read: members of the group can read who else is in it (needed for share UI).

Additional guarantees for the social layer:
- `group_id` validation on create/update: actor must be a member of that group.
- `TransactionShare.member_user_id` validation: target must be a member of the
  transaction's group.
- All policy checks happen server-side.

---

## 4. Data & API namespaces

Current phase (personal core):

```
lib/plano/finance/category.ex
lib/plano/finance/transaction.ex
lib/plano/finance.ex                # domain module
```

Later phases (social + sharing):

```
lib/plano/social/group.ex
lib/plano/social/membership.ex
lib/plano/social.ex                 # domain module
lib/plano/finance/transaction_share.ex
```

Extensions: `AshPostgres.DataLayer`, `AshAuthentication` (existing),
`AshMoney` on `amount` fields, `AshAdmin` (dev only).

---

## 5. LiveView surface

### Personal MVP (Phase 2)

- `/` dashboard — month selector, total income, total expenses, net, recent
  transactions, and per-category breakdown. Only the actor's rows are ever
  loaded.
- `/transactions` — list with `all | income | expense` tabs plus month and
  category filters.
- `/transactions/new` and `/transactions/:id/edit` — kind, description, notes,
  amount (Money input), date, category picker.
- `/categories` — create, rename, recolor, delete personal categories.
- `/settings` — default currency (affects new transactions only).

### Social layer (later)

- `/groups` — list my groups; create new; group detail (members, roles, naming)
  with owner-only actions.
- Transaction form gains a group picker and visibility selector.
- When `:shared`: member multi-select with equal-split default and per-member
  editable amounts (AshPhoenix nested forms).
- `/transactions` gains `shared-with-me` and `group` filters.

### Privacy behavior

- Filters in UIs are presentation aids only; enforcement lives in policies.
- Aggregates (totals) are computed on the server with policy-aware reads. One
  user's private rows never influence another user's view.

---

## 6. Decisions

- **D1** — Personal-first, policy-based privacy with no Ash multitenancy.
- **D2** — Categories are personal, flat (no hierarchy), and carry a color.
- **D3** — Money is stored as `Money`; the user has one default currency and
  there is no conversion in MVP. Totals are grouped by currency.
- **D4** — The social concept is `Group` (not `Family`); families are one use
  case of a group.
- **D5** — Splits are per-member amounts, editable after an equal-split
  default.
- **D6** — `group_id`, `visibility`, and `TransactionShare` are introduced only
  in the social phases; the personal MVP schema stays minimal.
