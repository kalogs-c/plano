# P4-05 — Shared/group views

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 4 — Sharing & splits
**Depends on:** P4-02, P4-03
**Parallel with:** P4-04

## Goal

Expose shared and group transactions in the list and settlement views.

## Deliverables

- `/transactions` tabs extended to:
  - `mine`
  - `shared-with-me` (shares where I am the member)
  - `group` (group-visible transactions in my groups)
- Group filter for the `group` tab
- Share status list for a transaction:
  - member, amount, status, settled date
  - "Mark settled" button only on my own pending share
- Creator view: see all shares and their statuses
- Empty states for each tab
- Actor-scoped reads only

## Files owned

- `lib/plano_web/live/transactions_live/index.ex`
- `lib/plano_web/live/transactions_live/show.ex` (new, if a detail view is used)
- `test/plano_web/live/transactions_live_test.exs`
- `lib/plano_web/components/finance_components.ex` (share status components;
  coordinate with P4-04)

## Acceptance criteria

- [ ] Tabs return the correct authorized sets
- [ ] Members can settle only their own share
- [ ] Creators see all share statuses
- [ ] Another user's private transactions never appear
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/transactions_live_test.exs
```

## Notes

- Do not edit the router unless a `/transactions/:id` route is required; if so,
  coordinate and update P4-01's shell first.
- Reuse the P2-01 list components where possible.
