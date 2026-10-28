# P2-03 — Transactions list + filters

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 2 — Personal finance UI
**Depends on:** P2-01
**Parallel with:** P2-02, P2-04, P2-05, P2-06

## Goal

Implement `/transactions` with kind tabs and month/category filters.

## Deliverables

- Tabs: `all | income | expense`
- Month filter (including "all months")
- Category filter (income and expense categories)
- Sortable by date, newest first
- Row actions: edit, delete (with confirmation)
- Empty state and result count
- Reads always use `actor: current_user`

## Files owned

- `lib/plano_web/live/transactions_live/index.ex`
- `test/plano_web/live/transactions_live_test.exs`

## Acceptance criteria

- [ ] Each filter narrows results correctly
- [ ] Filters compose (kind + month + category)
- [ ] Delete removes only the actor's transaction
- [ ] Another user's transactions are never listed
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/transactions_live_test.exs
```

## Notes

- Do not edit the router or layouts.
- Reuse `FinanceComponents` for rows, tabs, month picker, and empty states.
