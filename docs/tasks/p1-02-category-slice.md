# P1-02 — Category slice

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 1 — Personal finance core
**Depends on:** P1-01
**Parallel with:** P1-03

## Goal

Make `Plano.Finance.Category` fully usable and private: actions, owner-scoped
policies, validations, and tests.

## Deliverables

- Actions:
  - `create` — sets `user_id` from the actor
  - `read`
  - `update` — cannot move a category to another user
  - `destroy`
- Optional `code_interface` for `list`, `get`, `create`, `update`, `destroy`
- `Ash.Policy.Authorizer` policies:
  - read/update/destroy only when `user_id == actor.id`
  - create requires an actor; `user_id` is forced from the actor
  - no actor ⇒ forbidden
- Validation: `kind` must be `:income` or `:expense`
- Validation: `color` is a 6-digit hex string when present
- Tests:
  - create category
  - update/rename/recolor
  - delete
  - another user cannot read/update/delete it
  - duplicate `{user_id, kind, name}` rejected
  - invalid color rejected

## Files owned

- `lib/plano/finance/category.ex`
- `test/plano/finance/category_test.exs`
- optionally `test/support/fixtures/finance_fixtures.ex` (coordinate with P1-03
  before creating shared fixtures)

## Shared contracts

- Action names: `:create`, `:read`, `:update`, `:destroy`
- `user_id` is never accepted from user input

## Acceptance criteria

- [ ] Category CRUD works through the domain
- [ ] Cross-user reads return not-found/forbidden
- [ ] Unique constraint is enforced at the database level
- [ ] Tests pass

## Verification

```bash
mix test test/plano/finance/category_test.exs
mix format --check-formatted
```

## Notes

- Do not run `mix ash.codegen`; all schema changes belong to P1-01.
- Coordinate fixtures with P1-03 to avoid merge conflicts.
