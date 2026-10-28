# P4-01 — Sharing foundation

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 4 — Sharing & splits
**Depends on:** P3-07
**Parallel with:** —

## Goal

Add the schema for group-visible and shared transactions, including
`TransactionShare`, with a baseline that lets P4-02 and P4-03 run in parallel.
Generate and apply the migration here.

## Deliverables

- Extend `Plano.Finance.Transaction`:
  - `group_id` (uuid, nullable)
  - `visibility` (`:private | :group | :shared`, default `:private`, required)
  - relationship: belongs to `Plano.Social.Group` (optional)
  - index on `{group_id, visibility}`
- Create `Plano.Finance.TransactionShare`:
  - `transaction_id` (uuid, required)
  - `member_user_id` (uuid, required)
  - `amount` (`:money`, required)
  - `status` (`:pending | :settled`, default `:pending`, required)
  - `settled_at` (utc_datetime_usec, nullable)
  - unique index on `{transaction_id, member_user_id}`
  - relationships: transaction, member user
- Baseline actions/policies on `TransactionShare` so the share action in P4-02
  can manage shares (refined in P4-03):
  - `:create`, `:read`, `:update`
  - read allowed to the transaction creator and the share's own member
- Keep `Transaction` actions/policies unchanged; P4-02 owns them.
- Run codegen and migration; update resource snapshots.

## Files owned

- `lib/plano/finance/transaction.ex` (schema fields/relationship only)
- `lib/plano/finance/transaction_share.ex`
- `priv/repo/migrations/*` (new migration)
- `priv/resource_snapshots/repo/transactions/*`
- `priv/resource_snapshots/repo/transaction_shares/*`

## Shared contracts

Publish before merging:

- `visibility` values
- `TransactionShare` action names and status values
- The intended `share` action shape on `Transaction` (arguments: member ids +
  optional amounts)

## Acceptance criteria

- [ ] `mix compile` succeeds
- [ ] `mix ash.setup` applies the migration
- [ ] `mix ash.codegen --check` reports no pending changes
- [ ] Unique share constraint exists in the database
- [ ] Existing personal transactions still work unchanged

## Verification

```bash
mix compile
mix ash.codegen --check
mix ash.setup
```

## Notes

- Only this task runs `mix ash.codegen` for Phase 4.
- All schema-affecting fields/indexes land here.
