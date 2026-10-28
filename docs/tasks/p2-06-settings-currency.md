# P2-06 — Settings / currency UI

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 2 — Personal finance UI
**Depends on:** P2-01
**Parallel with:** P2-02, P2-03, P2-04, P2-05

## Goal

Implement `/settings` with the user's default currency.

## Deliverables

- Display current email (read-only)
- Currency selector (ISO-4217 list, at least USD/EUR/GBP/BRL)
- Help text: changing currency affects new transactions only; existing records
  keep their currency and totals are grouped by currency
- Save action with success/error flash
- Account actions section (optional): link to change password via existing auth

## Files owned

- `lib/plano_web/live/settings_live.ex`
- `test/plano_web/live/settings_live_test.exs`

## Acceptance criteria

- [ ] Currency updates persist
- [ ] New transactions use the new currency
- [ ] Existing transactions are unchanged
- [ ] Invalid currency is rejected
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/settings_live_test.exs
```

## Notes

- Do not edit the router or layouts.
- Use the existing `Plano.Accounts.User` update action or add a dedicated
  `update_currency` action if policies require it.
