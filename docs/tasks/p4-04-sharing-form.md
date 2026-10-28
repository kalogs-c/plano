# P4-04 — Sharing form + split editor

**Status:** Blocked
**Owner:** _unassigned_
**Size:** L
**Phase:** 4 — Sharing & splits
**Depends on:** P4-02, P4-03
**Parallel with:** P4-05

## Goal

Extend the transaction form with group/visibility controls and a split editor.

## Deliverables

- Visibility selector: `private | group | shared`
- Group picker: only groups the actor belongs to
- Member multi-select for `:shared`:
  - defaults to all other group members
  - equal-split default shown immediately
  - per-member amount adjustment
  - live remaining/over-allocated indicator
- Group visibility: no per-member splits, just `visibility: :group`
- Validation errors from the `share` action rendered inline
- Editing a shared transaction loads existing splits
- Switching back to private warns that shares will be removed
- Tests:
  - create group-visible transaction
  - create shared transaction with equal split
  - adjust per-member amounts
  - sum mismatch shows an error
  - switch back to private clears shares

## Files owned

- `lib/plano_web/live/transactions_live/form.ex`
- `test/plano_web/live/transaction_form_test.exs`
- `lib/plano_web/components/finance_components.ex` (new sharing components;
  coordinate with P2-01 owner if that module is still changing)

## Acceptance criteria

- [ ] Visibility/group/split controls work end-to-end
- [ ] Split editor matches the domain validation
- [ ] Errors are clear and actionable
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/transaction_form_test.exs
```

## Notes

- Do not edit the router or layouts.
- Money math must use `Money`; do not use floats in the LiveView.
