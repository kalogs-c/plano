# P3-03 — Membership slice

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 3 — Groups
**Depends on:** P3-01
**Parallel with:** P3-02, P3-04

## Goal

Finalize `Membership` behavior: owner-only management and the last-owner guard.

## Deliverables

- Membership policies:
  - read: members of the same group
  - create/update/destroy: group owner only
  - a user may not grant themselves membership
- Guard rails:
  - the last `:owner` of a group cannot be demoted to `:member`
  - the last `:owner` cannot be removed
  - removing/demoting an owner allowed when another owner remains
- Prevent duplicate membership (database constraint + friendly error)
- Tests:
  - owner adds an existing user by id
  - owner changes a member's role
  - owner removes a member
  - non-owner member cannot manage memberships
  - last-owner demotion/removal rejected
  - duplicate membership rejected

## Files owned

- `lib/plano/social/membership.ex`
- `test/plano/social/membership_test.exs`
- `test/support/fixtures/social_fixtures.ex` (coordinate with P3-02 before
  creating)

## Acceptance criteria

- [ ] Owner-only management is enforced by policy
- [ ] Last-owner guard works for update and destroy
- [ ] Duplicate membership is rejected cleanly
- [ ] Tests pass

## Verification

```bash
mix test test/plano/social/membership_test.exs
```

## Notes

- Do not run `mix ash.codegen`.
- Coordinate the shared fixtures file with P3-02.
- Adding users who do not exist is out of scope; target an existing user id.
