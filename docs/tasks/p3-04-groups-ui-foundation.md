# P3-04 — Groups UI foundation

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 3 — Groups
**Depends on:** P3-01
**Parallel with:** P3-02, P3-03

## Goal

Add the group routes, navigation, and shell LiveViews so the two group UI tasks
can run in parallel.

## Deliverables

- Authenticated routes:
  - `/groups` → `GroupsLive.Index`
  - `/groups/:id` → `GroupsLive.Show`
- Nav entry for Groups
- Shell LiveViews that compile and render a basic header/empty state
- Shared group components if needed (member row, role badge)
- Tests for authentication redirect and shell rendering

## Files owned

- `lib/plano_web/router.ex`
- `lib/plano_web/components/layouts.ex`
- `lib/plano_web/live/groups_live/index.ex`
- `lib/plano_web/live/groups_live/show.ex`
- `test/plano_web/live/groups_live_test.exs`

## Acceptance criteria

- [ ] Routes compile and are reachable when signed in
- [ ] Unauthenticated access redirects to `/sign-in`
- [ ] Nav shows Groups
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/groups_live_test.exs
```

## Notes

- This task may start after P3-01; no need to wait for the backend slices.
- Only this task edits `router.ex` in Phase 3.
