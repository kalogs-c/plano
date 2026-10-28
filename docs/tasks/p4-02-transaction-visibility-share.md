# P4-02 — Transaction visibility + share action

**Status:** Blocked
**Owner:** _unassigned_
**Size:** L
**Phase:** 4 — Sharing & splits
**Depends on:** P4-01
**Parallel with:** P4-03

## Goal

Implement group/shared visibility policies and the atomic `share` action on
`Transaction`.

## Deliverables

- Policies per design §3:
  - `:private` — creator only
  - `:group` — creator + members of `group_id`
  - `:shared` — creator + members holding a `TransactionShare`
  - update/destroy — creator, or group owner for `:group`/`:shared`
  - list/read never leak a transaction to an unauthorized actor
- Validation:
  - `group_id` is required when `visibility` is `:group` or `:shared`
  - on create/update, the actor must be a member of `group_id`
  - changing visibility to `:private` clears `group_id` and shares
- `share` action on `Transaction`:
  - atomic: sets `visibility: :shared`, `group_id`, and upserts shares
  - arguments: member ids with optional per-member amounts
  - equal-split default when amounts are omitted
  - creator's share defaults to the remainder when explicitly included
  - rejects targets who are not group members
  - enforces `sum(shares) == transaction.amount`
  - rejects empty member lists
- Tests:
  - private stays private
  - group visibility visible to all group members, invisible to non-members
  - shared visibility visible only to creator + share holders
  - group owner can update/destroy group/shared records
  - share equal split, custom split, sum mismatch, non-member target, empty list
  - transitioning back to private clears shares/group

## Files owned

- `lib/plano/finance/transaction.ex`
- `test/plano/finance/transaction_visibility_test.exs`
- `test/plano/finance/share_action_test.exs`

## Acceptance criteria

- [ ] Policy matrix from design §3 is enforced server-side
- [ ] `share` is atomic and validates the sum
- [ ] Equal split works for money amounts (no rounding drift)
- [ ] No visibility path leaks records
- [ ] Tests pass

## Verification

```bash
mix test test/plano/finance/transaction_visibility_test.exs
mix test test/plano/finance/share_action_test.exs
```

## Notes

- Do not edit `transaction_share.ex`; coordinate with P4-03.
- Do not run `mix ash.codegen`.
- Use `Money` arithmetic; split remainders deterministically (e.g. first
  members absorb the cents) and document the rule.
