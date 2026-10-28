# P1-03 — Transaction slice

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 1 — Personal finance core
**Depends on:** P1-01
**Parallel with:** P1-02

## Goal

Make `Plano.Finance.Transaction` fully usable and private: actions,
owner-scoped policies, currency-on-create, category ownership validation, and
tests.

## Deliverables

- Actions:
  - `create` — author from actor; currency from actor's `currency`
  - `read`
  - `update`
  - `destroy`
- Optional `code_interface` for `list`, `get`, `create`, `update`, `destroy`
- `Ash.Policy.Authorizer` policies:
  - read/update/destroy only when `created_by_user_id == actor.id`
  - create requires an actor; author is forced from the actor
  - no actor ⇒ forbidden
- Money handling:
  - `amount` is `AshMoney.Types.Money`
  - on create, set the amount's currency from `actor.currency`
  - form input may provide a bare decimal/string amount
- Validation when `category_id` is present:
  - category exists
  - category belongs to the same user
  - category `kind` matches transaction `kind`
- Tests:
  - create income and expense
  - currency is taken from the actor
  - update/destroy
  - another user cannot read/update/delete
  - category owned by another user rejected
  - category kind mismatch rejected
  - nil category accepted

## Files owned

- `lib/plano/finance/transaction.ex`
- `test/plano/finance/transaction_test.exs`
- optionally `test/support/fixtures/finance_fixtures.ex` (coordinate with P1-02
  before creating shared fixtures)

## Shared contracts

- Action names: `:create`, `:read`, `:update`, `:destroy`
- `created_by_user_id` is never accepted from user input
- Category validation must be reusable/testable from the UI layer later

## Acceptance criteria

- [ ] Transaction CRUD works through the domain
- [ ] Currency is always set from the actor on create
- [ ] Cross-user reads return not-found/forbidden
- [ ] Category ownership and kind mismatches are rejected
- [ ] Tests pass

## Verification

```bash
mix test test/plano/finance/transaction_test.exs
mix format --check-formatted
```

## Notes

- Do not run `mix ash.codegen`; all schema changes belong to P1-01.
- Coordinate fixtures with P1-02 to avoid merge conflicts.
