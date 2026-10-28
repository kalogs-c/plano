# Plano — Task Board

One file per task, grouped by phase. This board is the source of truth for what
can be picked next. Update **both** this board and the task file when you start
or finish work.

Task files live next to this file as `p<phase>-<nn>-<slug>.md`.

## Status legend

| Status | Meaning |
|---|---|
| `Available` | Ready to pick; all dependencies are done |
| `In progress` | Someone is working on it |
| `Blocked` | Waiting on dependencies |
| `Done` | Merged, tests passing, accepted |

## How we work in parallel

1. Only pick tasks marked `Available`.
2. Claim it: set `In progress` here and in the task file, add your name.
3. One branch per task: `p<phase>-<nn>-<slug>`.
4. The other developer reviews before merge.
5. Touch only the files listed in the task. If you need a shared/hot file,
   coordinate first.
6. **Only foundation tasks run `mix ash.codegen`.** This avoids migration
   numbering and resource-snapshot conflicts.
7. Run the task's targeted tests before opening a PR. `mix precommit` is the
   gate at the end of each phase.
8. Foundations must publish stable action names/code interfaces so UI tasks can
   build against them.

### Hot files (coordinate before editing)

- `config/config.exs`
- `lib/plano_web/router.ex`
- `lib/plano_web/components/layouts.ex`
- `lib/plano/finance.ex`
- `lib/plano/social.ex`
- shared formatter/components modules introduced by foundation tasks

## Pick order (parallel rounds)

| Round | Tasks |
|---|---|
| 1 | [P1-01](p1-01-finance-foundation.md) |
| 2 | [P1-02](p1-02-category-slice.md) ∥ [P1-03](p1-03-transaction-slice.md) |
| 3 | [P1-04](p1-04-personal-core-gate.md) |
| 4 | [P2-01](p2-01-ui-foundation.md) |
| 5 | [P2-02](p2-02-dashboard.md) + [P2-05](p2-05-categories-ui.md) ∥ [P2-03](p2-03-transactions-list.md) + [P2-04](p2-04-transaction-form.md) + [P2-06](p2-06-settings-currency.md) |
| 6 | [P2-07](p2-07-personal-ui-gate.md) |
| 7 | [P3-01](p3-01-social-foundation.md) |
| 8 | [P3-02](p3-02-group-slice.md) + [P3-03](p3-03-membership-slice.md) ∥ [P3-04](p3-04-groups-ui-foundation.md) |
| 9 | [P3-05](p3-05-groups-list-create.md) ∥ [P3-06](p3-06-group-detail-members.md) |
| 10 | [P3-07](p3-07-groups-gate.md) |
| 11 | [P4-01](p4-01-sharing-foundation.md) |
| 12 | [P4-02](p4-02-transaction-visibility-share.md) ∥ [P4-03](p4-03-share-slice.md) |
| 13 | [P4-04](p4-04-sharing-form.md) ∥ [P4-05](p4-05-shared-group-views.md) |
| 14 | [P4-06](p4-06-sharing-gate.md) |
| 15 | [P5-01](p5-01-demo-seeds.md) ∥ [P5-02](p5-02-policy-audit.md) |
| 16 | [P5-03](p5-03-release-gate.md) |

## Phase 1 — Personal finance core

| Task | Title | Size | Depends on | Status |
|---|---|---|---|---|
| [P1-01](p1-01-finance-foundation.md) | Personal finance foundation | M | — | Available |
| [P1-02](p1-02-category-slice.md) | Category slice | S | P1-01 | Blocked |
| [P1-03](p1-03-transaction-slice.md) | Transaction slice | M | P1-01 | Blocked |
| [P1-04](p1-04-personal-core-gate.md) | Personal core phase gate | S | P1-02, P1-03 | Blocked |

## Phase 2 — Personal finance UI

| Task | Title | Size | Depends on | Status |
|---|---|---|---|---|
| [P2-01](p2-01-ui-foundation.md) | Personal UI foundation | M | P1-04 | Blocked |
| [P2-02](p2-02-dashboard.md) | Dashboard | M | P2-01 | Blocked |
| [P2-03](p2-03-transactions-list.md) | Transactions list + filters | M | P2-01 | Blocked |
| [P2-04](p2-04-transaction-form.md) | Transaction create/edit form | M | P2-01 | Blocked |
| [P2-05](p2-05-categories-ui.md) | Categories management UI | S | P2-01 | Blocked |
| [P2-06](p2-06-settings-currency.md) | Settings / currency UI | S | P2-01 | Blocked |
| [P2-07](p2-07-personal-ui-gate.md) | Personal UI phase gate | S | P2-02…P2-06 | Blocked |

## Phase 3 — Groups

| Task | Title | Size | Depends on | Status |
|---|---|---|---|---|
| [P3-01](p3-01-social-foundation.md) | Social foundation | M | P2-07 | Blocked |
| [P3-02](p3-02-group-slice.md) | Group slice | M | P3-01 | Blocked |
| [P3-03](p3-03-membership-slice.md) | Membership slice | M | P3-01 | Blocked |
| [P3-04](p3-04-groups-ui-foundation.md) | Groups UI foundation | S | P3-01 | Blocked |
| [P3-05](p3-05-groups-list-create.md) | Groups list + create | S | P3-02, P3-03, P3-04 | Blocked |
| [P3-06](p3-06-group-detail-members.md) | Group detail + members | M | P3-02, P3-03, P3-04 | Blocked |
| [P3-07](p3-07-groups-gate.md) | Groups phase gate | S | P3-05, P3-06 | Blocked |

## Phase 4 — Sharing & splits

| Task | Title | Size | Depends on | Status |
|---|---|---|---|---|
| [P4-01](p4-01-sharing-foundation.md) | Sharing foundation | M | P3-07 | Blocked |
| [P4-02](p4-02-transaction-visibility-share.md) | Transaction visibility + share action | L | P4-01 | Blocked |
| [P4-03](p4-03-share-slice.md) | Share slice + settlement | M | P4-01 | Blocked |
| [P4-04](p4-04-sharing-form.md) | Sharing form + split editor | L | P4-02, P4-03 | Blocked |
| [P4-05](p4-05-shared-group-views.md) | Shared/group views | M | P4-02, P4-03 | Blocked |
| [P4-06](p4-06-sharing-gate.md) | Sharing phase gate | M | P4-04, P4-05 | Blocked |

## Phase 5 — Hardening

| Task | Title | Size | Depends on | Status |
|---|---|---|---|---|
| [P5-01](p5-01-demo-seeds.md) | Demo seeds | S | P4-06 | Blocked |
| [P5-02](p5-02-policy-audit.md) | Policy audit + docs check | S | P4-06 | Blocked |
| [P5-03](p5-03-release-gate.md) | Release gate v0.1.0 | S | P5-01, P5-02 | Blocked |

## Definition of done

Every task must:

- [ ] Implement exactly the deliverables in its task file
- [ ] Include or update tests for the new behavior
- [ ] Pass its listed targeted test command
- [ ] Keep `mix format` clean
- [ ] Avoid touching files not listed (or coordinate first)
- [ ] Be reviewed by the other developer
- [ ] Update its status to `Done` here and in the task file
