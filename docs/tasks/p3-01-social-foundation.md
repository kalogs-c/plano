# P3-01 — Social foundation

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 3 — Groups
**Depends on:** P2-07
**Parallel with:** —

## Goal

Create the `Plano.Social` domain with `Group` and `Membership`, including a
baseline that lets both slice tasks work in parallel. Generate and apply the
migration here.

## Deliverables

- Create `Plano.Social` domain and register it in `config/config.exs`
  (`ash_domains`).
- Create `Plano.Social.Group`:
  - `name` (string, required)
  - `created_by_user_id` (uuid, required)
  - relationships: creator (`Plano.Accounts.User`), `memberships` (has many),
    `members` (many-to-many through memberships)
  - baseline `:create`, `:read`, `:update`, `:destroy` actions
- Create `Plano.Social.Membership`:
  - `group_id` (uuid, required)
  - `user_id` (uuid, required)
  - `role` (`:owner | :member`, default `:member`)
  - unique index on `{group_id, user_id}`
  - relationships: group, user
  - baseline `:create`, `:read`, `:update`, `:destroy` actions
- Baseline authorizers and simple policies so the resources are usable:
  - group members can read their groups
  - creators/owners can update/destroy groups
  - group members can read memberships
  - owner-only membership management
- Interfaces that P3-02/P3-03 will refine:
  - action names stay `:create`, `:read`, `:update`, `:destroy`
  - `Membership.role` values stay `:owner` and `:member`
  - Group creation will use `manage_relationship(:memberships, ...)`
- Run codegen and migration; update resource snapshots.

## Files owned

- `lib/plano/social.ex`
- `lib/plano/social/group.ex`
- `lib/plano/social/membership.ex`
- `config/config.exs`
- `priv/repo/migrations/*` (new migration)
- `priv/resource_snapshots/repo/groups/*`
- `priv/resource_snapshots/repo/memberships/*`

## Shared contracts

Publish before merging:

- Attribute names and types
- Relationship names (`:memberships`, `:members`, `:creator`, `:group`, `:user`)
- Action names and role values

## Acceptance criteria

- [ ] `mix compile` succeeds
- [ ] `mix ash.setup` applies the migration
- [ ] `mix ash.codegen --check` reports no pending changes
- [ ] AshAdmin lists `Group` and `Membership`
- [ ] Unique membership constraint exists in the database

## Verification

```bash
mix compile
mix ash.codegen --check
mix ash.setup
```

## Notes

- Only this task runs `mix ash.codegen` for Phase 3.
- All schema-affecting fields/indexes must land here; slices stay schema-free.
