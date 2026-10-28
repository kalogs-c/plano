# Plano — Roadmap

The execution harness. Each phase ends with a check that must pass before the
next begins. Keep checkboxes in sync with reality.

- [x] Phase 0 — design freeze (`docs/design.md` v2, personal-first)
- [ ] Phase 1 — Personal finance core
- [ ] Phase 2 — Personal finance UI
- [ ] Phase 3 — Groups
- [ ] Phase 4 — Sharing & splits
- [ ] Phase 5 — Hardening

## Phase 1 — Personal finance core

- [ ] Add `currency` to `Plano.Accounts.User` (default `:USD`) per design §2
- [ ] Create `Plano.Finance` domain and `Category` resource per design §2
  - [ ] Owner-scoped policies; unique `{user_id, kind, name}`
  - [ ] `color` optional, validated as a hex string
- [ ] Create `Transaction` resource with `kind`, `description`, `notes`,
      `amount` (AshMoney), `date`, `category_id`, `created_by_user_id`
  - [ ] Set currency from the actor's `currency` on create
  - [ ] Validate category ownership and kind match against the transaction
  - [ ] Owner-scoped policies for read/update/destroy
- [ ] `mix ash.codegen` + migrations; up `mix ash.setup`
- [ ] AshAdmin sanity check (dev) — create category and transaction
- [ ] Tests: transaction CRUD, category CRUD, cross-user isolation, currency
      set from actor, category ownership/kind rejection
- [ ] Policy tests: a user cannot read or modify another user's categories or
      transactions

## Phase 2 — Personal finance UI

- [ ] `/` dashboard: month selector, income/expense/net totals, recent
      transactions, per-category breakdown
- [ ] `/transactions` list with `all | income | expense` tabs and month /
      category filters
- [ ] `/transactions/new` + edit form with Money input, date, category picker
- [ ] `/categories` management (create, rename, recolor, delete)
- [ ] `/settings` default currency (affects new transactions only)
- [ ] AshPhoenix form integration (follow `ash_phoenix/best_practices`)
- [ ] LiveView tests for create/edit/delete and filters
- [ ] run `mix precommit`

## Phase 3 — Groups

- [ ] Create `Plano.Social` domain, `Group` and `Membership` resources per
      design §2
- [ ] `Group.create` seeds creator as owner (`:owner` role membership inside
      the same transaction)
- [ ] Policies: owner-only CRUD on memberships; group read for members
- [ ] Validation: last-owner cannot be demoted/removed
- [ ] `mix ash.codegen` + migrations; up `mix ash.setup`
- [ ] `/groups` UI: create, list, detail, member management
- [ ] AshAdmin sanity check (dev) — create group, add member
- [ ] Tests: create group, add member, role change, owner guard rails
- [ ] Policy tests: non-members cannot read groups or manage memberships

## Phase 4 — Sharing & splits

- [ ] Add nullable `group_id` + `visibility` (`:private | :group | :shared`)
      to `Transaction`, with required-group validation for `:group` / `:shared`
- [ ] Add `TransactionShare` per design §2 with unique
      `{transaction_id, member_user_id}`
- [ ] `share` action (atomic): sets visibility, upserts shares, enforces
      `sum(amount) == transaction.amount`
- [ ] Equal-split default when only members are provided (no per-member amounts)
- [ ] Split editor flow: allow per-member adjustment after equal default
- [ ] `mark_settled` action — only the share's own member
- [ ] Add `shared-with-me` and `group` filters to `/transactions`
- [ ] Tests: sum mismatch rejected; leaking through `exists()` policy paths;
      settling only own share; non-group-member shares rejected
- [ ] run `mix precommit`

## Phase 5 — Hardening

- [ ] Full test suite green (`mix precommit` from any dir)
- [ ] Seed script for demo user + categories + transactions (dev only)
- [ ] Verify `mix ash.generate_policy_charts` matches design §3 matrix
- [ ] Tag MVP version in git (v0.1.0)

## Future (parked, not MVP)

- budgets, recurring transactions, advanced reports, export
- categories hierarchy / tags
- settlement balances (simplified who-owes-whom), notifications
- email invitation flow for group owners
- multi-currency conversion
