# P2-02 — Dashboard

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 2 — Personal finance UI
**Depends on:** P2-01
**Parallel with:** P2-03, P2-04, P2-05, P2-06

## Goal

Implement the `/` dashboard for the signed-in user's authorized transactions.

## Deliverables

- Month selector (default: current month)
- Summary cards:
  - total income
  - total expenses
  - net
  - grouped by currency if multiple currencies exist
- Recent transactions list (latest N) using the shared transaction row
- Per-category breakdown for the selected month:
  - category name/color
  - total per category
  - empty/uncategorized bucket
- Empty state when there are no transactions
- Policy-aware reads only (always pass `actor: current_user`)

## Files owned

- `lib/plano_web/live/dashboard_live.ex`
- `test/plano_web/live/dashboard_live_test.exs`

## Acceptance criteria

- [ ] Totals are correct for income/expense/no data
- [ ] Changing month updates all sections
- [ ] Another user's transactions never appear in totals or lists
- [ ] Empty state renders
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/dashboard_live_test.exs
```

## Notes

- Do not edit the router or layouts; use the P2-01 routes/components.
- Compute aggregates server-side with actor-scoped reads.
