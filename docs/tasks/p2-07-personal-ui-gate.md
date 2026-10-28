# P2-07 — Personal UI phase gate

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 2 — Personal finance UI
**Depends on:** P2-02, P2-03, P2-04, P2-05, P2-06
**Parallel with:** —

## Goal

Close Phase 2 with consistent UX, passing LiveView tests, and a green build.

## Deliverables

- Cross-page LiveView test sweep:
  - authenticated happy paths
  - unauthenticated redirects
  - cross-user isolation on every page
- Responsive/visual pass on mobile and desktop
- Consistent empty, loading, and error states
- Accessibility pass: labels, focus states, keyboard navigation, contrast
- `mix precommit` green
- Update board statuses and unlock Phase 3

## Files owned

- `test/plano_web/live/**` (coordination fixes only)
- `docs/roadmap.md` (checkpoint)
- `docs/tasks/README.md` (status updates)

## Acceptance criteria

- [ ] Every personal page has at least one happy-path and one isolation test
- [ ] No layout breakage at 375px / 768px / 1280px
- [ ] `mix precommit` passes
- [ ] Phase 3 tasks are `Available`

## Verification

```bash
mix precommit
```

## Notes

- Prefer fixing shared components over per-page overrides.
