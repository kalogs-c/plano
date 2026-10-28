# P2-04 — Transaction create/edit form

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 2 — Personal finance UI
**Depends on:** P2-01
**Parallel with:** P2-02, P2-03, P2-05, P2-06

## Goal

Implement `/transactions/new` and `/transactions/:id/edit`.

## Deliverables

- Form fields: kind, description, notes, amount, date, category
- Money input using the shared component; display the actor's currency
- Category options filtered by the selected kind
- Server-side validation errors rendered inline
- Create redirects to `/transactions` with a flash
- Edit loads only the actor's transaction; unauthorized IDs redirect/404
- Delete is handled by the list task; no delete here

## Files owned

- `lib/plano_web/live/transactions_live/form.ex`
- `test/plano_web/live/transaction_form_test.exs`

## Acceptance criteria

- [ ] Create income and expense successfully
- [ ] Amount is stored with the actor's currency
- [ ] Invalid amount/date/description show errors
- [ ] Category kind mismatch is rejected server-side
- [ ] Editing another user's transaction is impossible
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/transaction_form_test.exs
```

## Notes

- Do not edit the router or layouts.
- Use AshPhoenix form helpers and the shared money/category components.
