# P5-02 — Policy audit + docs check

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 5 — Hardening
**Depends on:** P4-06
**Parallel with:** P5-01

## Goal

Verify that the implemented authorization matches the design and that the docs
are accurate.

## Deliverables

- Run and review `mix ash.generate_policy_charts`
- Compare every resource/action against `docs/design.md` §3 and §6
- Update the policy matrix in docs if implementation intentionally diverged
- Verify roadmap/task board checkboxes reflect reality
- Check README links and setup instructions
- Write a short audit note in the task PR (gaps found, fixes, follow-ups)

## Files owned

- `docs/design.md`
- `docs/roadmap.md`
- `docs/tasks/README.md`
- `README.md`

## Acceptance criteria

- [ ] Policy charts reviewed for `User`, `Category`, `Transaction`,
      `TransactionShare`, `Group`, `Membership`
- [ ] No undocumented policy differences
- [ ] All docs links resolve
- [ ] Roadmap matches the shipped state

## Verification

```bash
mix ash.generate_policy_charts
```

## Notes

- If a real security gap is found, open/fix it before P5-03.
