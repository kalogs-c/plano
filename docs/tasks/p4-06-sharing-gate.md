# P4-06 — Sharing phase gate

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 4 — Sharing & splits
**Depends on:** P4-04, P4-05
**Parallel with:** —

## Goal

Close Phase 4 with adversarial privacy testing and a green build.

## Deliverables

- Leak-path tests:
  - `exists()` policy paths cannot leak private/group/shared records
  - non-members cannot read groups, transactions, or shares
  - removed group members immediately lose visibility
  - share holders cannot read other shares or the full transaction beyond
    their authorized view
- Sum/settlement edge cases:
  - rounding/remainder behavior
  - currency mismatches
  - double settlement
  - settling a share after leaving the group
- Policy chart check against design §3
- `mix precommit` green
- Update board statuses and unlock Phase 5

## Files owned

- `test/plano/finance/sharing_policy_test.exs`
- `test/plano_web/live/sharing_flow_test.exs`
- `docs/roadmap.md` (checkpoint)
- `docs/tasks/README.md` (status updates)

## Acceptance criteria

- [ ] All leak-path tests pass
- [ ] Policy chart matches the design matrix
- [ ] `mix precommit` passes
- [ ] Phase 5 tasks are `Available`

## Verification

```bash
mix precommit
mix ash.generate_policy_charts
```

## Notes

- Fix root causes; do not add permissive policy bypasses.
