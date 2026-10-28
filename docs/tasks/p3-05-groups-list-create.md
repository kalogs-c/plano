# P3-05 — Groups list + create

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 3 — Groups
**Depends on:** P3-02, P3-03, P3-04
**Parallel with:** P3-06

## Goal

Implement the `/groups` list and create flow.

## Deliverables

- List groups the signed-in user belongs to
- Show role badge and member count
- Create group form (name only)
- On create: redirect to the new group's detail page
- Empty state with call to action
- Actor-scoped reads only

## Files owned

- `lib/plano_web/live/groups_live/index.ex`
- `test/plano_web/live/groups_live_test.exs` (list/create cases; coordinate
  with P3-06 if it adds to the same file)

## Acceptance criteria

- [ ] Only my groups appear
- [ ] Creating a group seeds me as owner and redirects to detail
- [ ] Name validation errors render
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/groups_live_test.exs
```

## Notes

- Do not edit the router or layouts.
- Coordinate test file ownership with P3-06; separate describe blocks are fine.
