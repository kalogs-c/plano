# P5-03 — Release gate v0.1.0

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 5 — Hardening
**Depends on:** P5-01, P5-02
**Parallel with:** —

## Goal

Cut the MVP release.

## Deliverables

- Full `mix precommit` from a clean checkout
- Verify `mix setup` works from scratch against a fresh database
- Confirm no debug-only credentials or secrets are committed
- Update README with MVP feature list
- Update `mix.exs` version if needed and tag `v0.1.0`
- Final board pass: every task `Done`, roadmap Phase 5 checked

## Files owned

- `mix.exs`
- `README.md`
- `docs/roadmap.md`
- `docs/tasks/README.md`

## Acceptance criteria

- [ ] `mix precommit` green
- [ ] `mix setup` green from scratch
- [ ] No secrets in git
- [ ] `v0.1.0` tagged
- [ ] Board and roadmap fully in sync

## Verification

```bash
mix precommit
mix setup
git tag v0.1.0
```

## Notes

- Tag only after the other developer reviews the final PR.
