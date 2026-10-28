# P3-07 — Groups phase gate

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 3 — Groups
**Depends on:** P3-05, P3-06
**Parallel with:** —

## Goal

Close Phase 3 with policy coverage, cross-user isolation, and a green build.

## Deliverables

- Policy test sweep:
  - non-members cannot read groups or memberships
  - non-owners cannot mutate groups or memberships
  - last-owner guard covered through the UI and domain
- Cross-user LiveView tests for list/detail
- `mix precommit` green
- Update board statuses and unlock Phase 4

## Files owned

- `test/plano/social/policy_test.exs`
- `test/plano_web/live/groups_live_test.exs` (gate cases only)
- `docs/roadmap.md` (checkpoint)
- `docs/tasks/README.md` (status updates)

## Acceptance criteria

- [ ] Policy matrix for groups/memberships is fully tested
- [ ] `mix precommit` passes
- [ ] Phase 4 tasks are `Available`

## Verification

```bash
mix precommit
```

## Notes

- Fix gaps in P3-02/P3-03 rather than adding permissive bypasses.
