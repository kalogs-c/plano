# P3-02 — Group slice

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 3 — Groups
**Depends on:** P3-01
**Parallel with:** P3-03, P3-04

## Goal

Finalize `Group` behavior: creator-as-owner seeding, owner-only management, and
tests.

## Deliverables

- `Group.create`:
  - sets `created_by_user_id` from the actor
  - creates an `:owner` membership for the creator in the same transaction
  - rejects unauthenticated creation
- Group policies:
  - read: members only
  - update/destroy: group owner only (creator is owner via seeding)
  - create: any authenticated user
- `Group` optional `code_interface` for list/get/create/update/destroy
- Tests:
  - create group seeds exactly one owner membership
  - creator can read/update/destroy
  - non-member cannot read/update/destroy
  - member (non-owner) cannot update/destroy
  - failed membership creation rolls back the group

## Files owned

- `lib/plano/social/group.ex`
- `test/plano/social/group_test.exs`
- `test/support/fixtures/social_fixtures.ex` (coordinate with P3-03 before
  creating)

## Acceptance criteria

- [ ] Group creation is atomic with owner membership
- [ ] Only owners can update/destroy
- [ ] Non-members see forbidden/not-found
- [ ] Tests pass

## Verification

```bash
mix test test/plano/social/group_test.exs
```

## Notes

- P3-01 provides baseline actions/policies; refine rather than replace the
  public interface.
- Do not run `mix ash.codegen`.
- Coordinate the shared fixtures file with P3-03.
