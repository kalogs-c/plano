# Plano — Roadmap

Phase-level execution plan. Granular, pickable tasks live in
[`docs/tasks/README.md`](tasks/README.md); that board is the source of truth for
status. Each phase ends with a gate that must pass before the next begins.

| Phase | Goal | Tasks | Gate |
|---|---|---|---|
| 0 | Design freeze v2, personal-first | — | Done |
| 1 | Personal finance core | P1-01 … P1-04 | Privacy sweep + `mix precommit` |
| 2 | Personal finance UI | P2-01 … P2-07 | LiveView tests + `mix precommit` |
| 3 | Groups | P3-01 … P3-07 | Policy tests + `mix precommit` |
| 4 | Sharing & splits | P4-01 … P4-06 | Leak-path tests + `mix precommit` |
| 5 | Hardening | P5-01 … P5-03 | Release gate + `v0.1.0` |

## Phase 0 — Design freeze

- [x] `docs/design.md` v2 (personal-first, groups later)
- [x] Two-person task board with per-task files

## Phase 1 — Personal finance core

Add the per-user currency and the owner-scoped `Category` and `Transaction`
resources. No groups yet; everything is private.

- [ ] [P1-01](tasks/p1-01-finance-foundation.md) — foundation + migration
- [ ] [P1-02](tasks/p1-02-category-slice.md) — category slice
- [ ] [P1-03](tasks/p1-03-transaction-slice.md) — transaction slice
- [ ] [P1-04](tasks/p1-04-personal-core-gate.md) — phase gate

**Gate:** cross-user privacy tests for both resources pass; `mix precommit`
green.

## Phase 2 — Personal finance UI

Ship a usable personal tracker: dashboard, transaction list/form, categories,
and settings.

- [ ] [P2-01](tasks/p2-01-ui-foundation.md) — routes, nav, shared components
- [ ] [P2-02](tasks/p2-02-dashboard.md) — dashboard
- [ ] [P2-03](tasks/p2-03-transactions-list.md) — list + filters
- [ ] [P2-04](tasks/p2-04-transaction-form.md) — create/edit form
- [ ] [P2-05](tasks/p2-05-categories-ui.md) — categories UI
- [ ] [P2-06](tasks/p2-06-settings-currency.md) — settings/currency
- [ ] [P2-07](tasks/p2-07-personal-ui-gate.md) — phase gate

**Gate:** every personal page has happy-path + isolation tests; responsive and
accessible pass; `mix precommit` green.

## Phase 3 — Groups

Add the social foundation: groups, memberships, and owner rules.

- [ ] [P3-01](tasks/p3-01-social-foundation.md) — social foundation + migration
- [ ] [P3-02](tasks/p3-02-group-slice.md) — group slice
- [ ] [P3-03](tasks/p3-03-membership-slice.md) — membership slice
- [ ] [P3-04](tasks/p3-04-groups-ui-foundation.md) — groups UI foundation
- [ ] [P3-05](tasks/p3-05-groups-list-create.md) — list + create
- [ ] [P3-06](tasks/p3-06-group-detail-members.md) — detail + members
- [ ] [P3-07](tasks/p3-07-groups-gate.md) — phase gate

**Gate:** non-members/non-owners denied; last-owner guard tested; `mix precommit`
green.

## Phase 4 — Sharing & splits

Make transactions group-visible or shared with selected members, with
per-member splits and settlement.

- [ ] [P4-01](tasks/p4-01-sharing-foundation.md) — sharing foundation + migration
- [ ] [P4-02](tasks/p4-02-transaction-visibility-share.md) — visibility + share
- [ ] [P4-03](tasks/p4-03-share-slice.md) — shares + settlement
- [ ] [P4-04](tasks/p4-04-sharing-form.md) — sharing form + split editor
- [ ] [P4-05](tasks/p4-05-shared-group-views.md) — shared/group views
- [ ] [P4-06](tasks/p4-06-sharing-gate.md) — phase gate

**Gate:** leak-path tests pass; split sums enforced; only own share can be
settled; `mix precommit` green.

## Phase 5 — Hardening

- [ ] [P5-01](tasks/p5-01-demo-seeds.md) — demo seeds
- [ ] [P5-02](tasks/p5-02-policy-audit.md) — policy audit + docs
- [ ] [P5-03](tasks/p5-03-release-gate.md) — release `v0.1.0`

**Gate:** full `mix precommit` from a clean checkout; `mix setup` from scratch;
no secrets; tagged `v0.1.0`.

## Future (parked, not MVP)

- budgets, recurring transactions, advanced reports, export
- category hierarchy / tags
- settlement balances (simplified who-owes-whom), notifications
- email invitation flow for group owners
- friends/relationships outside groups
- multi-currency conversion
