# P5-01 — Demo seeds

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 5 — Hardening
**Depends on:** P4-06
**Parallel with:** P5-02

## Goal

Create a repeatable dev seed that demonstrates the full product.

## Deliverables

- Idempotent seed script (`priv/repo/seeds.exs`) that:
  - creates demo users (e.g. `alice@example.com`, `bob@example.com`,
    `carol@example.com`) with a known password
  - creates personal categories and transactions for each
  - creates a demo group with Alice as owner and Bob/Carol as members
  - creates a group-visible transaction
  - creates a shared transaction with an equal split and one settled share
- Safe to run repeatedly without duplicate errors
- Dev-only guard (refuse to run in production)
- Document credentials in the task/PR, not in production docs

## Files owned

- `priv/repo/seeds.exs`
- optionally `priv/repo/seed_helpers.ex`

## Acceptance criteria

- [ ] `mix ash.reset` (or `mix setup`) seeds successfully from scratch
- [ ] Running seeds twice does not crash or duplicate
- [ ] Seeds demonstrate personal + group + shared flows
- [ ] Refuses to run in `:prod`

## Verification

```bash
MIX_ENV=test mix ash.reset
MIX_ENV=test mix run priv/repo/seeds.exs
MIX_ENV=test mix run priv/repo/seeds.exs
```

## Notes

- Do not add seed data to production deploys.
