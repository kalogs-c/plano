# P1-01 — Personal finance foundation

**Status:** Available
**Owner:** _unassigned_
**Size:** M
**Phase:** 1 — Personal finance core
**Depends on:** —
**Parallel with:** —

## Goal

Create the schema foundation for the personal finance MVP: a per-user currency,
the `Plano.Finance` domain, and the `Category` and `Transaction` resources with
their attributes, relationships, and indexes. Generate and apply the migration
in this task.

No actions or policies yet — those land in P1-02 and P1-03. This task must
publish stable field names so the slices can work in parallel.

## Deliverables

- Add `currency` to `Plano.Accounts.User`:
  - default `:USD`
  - ISO-4217 validated
  - public attribute so it can be read/updated by settings later
- Create `Plano.Finance` domain and register it in `config/config.exs`
  (`ash_domains`).
- Create `Plano.Finance.Category`:
  - `user_id` (uuid, required)
  - `name` (string, required)
  - `kind` (`:income | :expense`, required)
  - `color` (string, optional, hex format validation)
  - unique index on `{user_id, kind, name}`
  - relationships: belongs to `Plano.Accounts.User`
- Create `Plano.Finance.Transaction`:
  - `kind` (`:income | :expense`, required)
  - `description` (string, required)
  - `notes` (string, optional)
  - `amount` (`:money`, required)
  - `date` (date, required)
  - `category_id` (uuid, optional)
  - `created_by_user_id` (uuid, required)
  - relationships: belongs to `Plano.Finance.Category` (optional) and
    `Plano.Accounts.User` as `:created_by`
  - index on `{created_by_user_id, date}`
- Do **not** add `group_id`, `visibility`, or `TransactionShare` yet.
- Run codegen and migration; update the resource snapshots.

## Files owned

- `lib/plano/accounts/user.ex`
- `lib/plano/finance.ex`
- `lib/plano/finance/category.ex`
- `lib/plano/finance/transaction.ex`
- `config/config.exs`
- `priv/repo/migrations/*` (new migration)
- `priv/resource_snapshots/repo/users/*`
- `priv/resource_snapshots/repo/categories/*`
- `priv/resource_snapshots/repo/transactions/*`

## Shared contracts

Publish in the PR description before merging:

- Exact attribute names and types
- Relationship names
- Enum/one-of values for `kind` and `currency`
- How `amount` uses `AshMoney.Types.Money`

## Acceptance criteria

- [ ] `mix compile` succeeds
- [ ] `mix ash.setup` applies the new migration cleanly
- [ ] `mix ash.codegen` reports no pending changes after the migration
- [ ] AshAdmin (dev) lists `Category` and `Transaction`
- [ ] Currency defaults to USD for new users
- [ ] Category unique constraint exists at the database level

## Verification

```bash
mix compile
mix ash.codegen --check
mix ash.setup
```

## Notes

- All schema-affecting attributes, enums, constraints, and indexes must land
  here. Later slice tasks should not need another migration.
- Only this task runs `mix ash.codegen` for Phase 1.
