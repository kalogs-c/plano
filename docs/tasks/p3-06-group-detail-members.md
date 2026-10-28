# P3-06 — Group detail + members

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 3 — Groups
**Depends on:** P3-02, P3-03, P3-04
**Parallel with:** P3-05

## Goal

Implement `/groups/:id` with member and role management for owners.

## Deliverables

- Group header: name, role, created by
- Members list with role badges
- Owner-only controls:
  - add existing user by email (resolve to user id)
  - change member role
  - remove member
  - rename group
  - delete group with confirmation (redirect to `/groups`)
- Last-owner guard surfaced as a friendly error
- Non-members get not-found/forbidden
- Non-owners see a read-only members list

## Files owned

- `lib/plano_web/live/groups_live/show.ex`
- `test/plano_web/live/groups_live_test.exs` (detail/member cases; coordinate
  with P3-05)

## Acceptance criteria

- [ ] Owners can add/change/remove members
- [ ] Last-owner operations show an error
- [ ] Non-members cannot open the page
- [ ] Non-owners cannot see management controls
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/groups_live_test.exs
```

## Notes

- Do not edit the router or layouts.
- Adding non-existent users / invitations is out of scope.
- Coordinate test file ownership with P3-05; separate describe blocks are fine.
