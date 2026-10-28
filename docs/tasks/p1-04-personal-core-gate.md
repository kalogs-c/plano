# P1-04 — Personal core phase gate

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 1 — Personal finance core
**Depends on:** P1-02, P1-03
**Parallel with:** —

## Goal

Close Phase 1 with an end-to-end privacy sweep and a green build.

## Deliverables

- Shared test fixtures (if not already created) for users, categories, and
  transactions
- Cross-user privacy tests spanning both resources:
  - user A cannot list/read user B's categories
  - user A cannot list/read user B's transactions
  - user A cannot update/destroy user B's records
- AshAdmin (dev) smoke check: create category + transaction for a user
- `mix precommit` green
- Update roadmap/board checkpoints

## Files owned

- `test/support/fixtures/finance_fixtures.ex`
- `test/plano/finance/privacy_test.exs`
- `docs/roadmap.md` (checkpoint only)
- `docs/tasks/README.md` (status updates)

## Acceptance criteria

- [ ] Privacy tests demonstrate complete cross-user isolation
- [ ] `mix precommit` passes
- [ ] Phase 2 tasks are marked `Available` on the board

## Verification

```bash
mix precommit
```

## Notes

- Fix issues found in P1-02/P1-03 rather than weakening tests.
