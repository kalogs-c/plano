# P4-03 — Share slice + settlement

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 4 — Sharing & splits
**Depends on:** P4-01
**Parallel with:** P4-02

## Goal

Finalize `TransactionShare` semantics: access rules, status transitions, and
settlement.

## Deliverables

- Policies:
  - read: transaction creator + the share's own member
  - update/destroy: transaction creator (only before settlement, if desired)
  - `mark_settled`: only the share's own member
- Validations:
  - `member_user_id` must belong to the transaction's group
  - `amount` must be positive and use the transaction currency
  - status can only move `:pending → :settled` (or allow revert explicitly;
    document the choice)
  - `settled_at` is set when status becomes `:settled` and cleared on revert
- `mark_settled` action:
  - actor must own the share
  - creator/owner cannot settle on someone else's behalf
- Tests:
  - only own share can be settled
  - creator/owner cannot settle another member's share
  - non-member targets rejected at creation
  - currency mismatch rejected
  - settled_at set/cleared correctly
  - read visibility for creator and member only

## Files owned

- `lib/plano/finance/transaction_share.ex`
- `test/plano/finance/transaction_share_test.exs`

## Acceptance criteria

- [ ] Settlement is restricted to the share's own member
- [ ] Status transitions are consistent
- [ ] Currency/group validations enforced
- [ ] Tests pass

## Verification

```bash
mix test test/plano/finance/transaction_share_test.exs
```

## Notes

- Do not edit `transaction.ex`; coordinate with P4-02.
- Do not run `mix ash.codegen`.
