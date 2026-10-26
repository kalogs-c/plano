# Plano — Roadmap

The execution harness. Each phase ends with a check that must pass before the
next begins. Keep checkboxes in sync with reality.

- [x] Phase 0 — design freeze (`docs/design.md` v1)
- [ ] Phase 1 — Family domain
- [ ] Phase 2 — Finance core
- [ ] Phase 3 — Sharing & splits
- [ ] Phase 4 — LiveViews
- [ ] Phase 5 — Hardening

## Phase 1 — Family domain

- [ ] Create `Plano.Family` domain, `Family` and `Membership` resources per
      `docs/design.md` §2
- [ ] `Family.create` action seeds creator as owner (`:owner` role membership
      inside the same transaction)
- [ ] Policies: owner-only CRUD on memberships; family read for members
- [ ] Validation: last-owner cannot be demoted/removed
- [ ] `mix ash.codegen` + migrations; up `mix ash.setup`
- [ ] AshAdmin sanity check (dev) — create family, add member
- [ ] Tests: create family, add member, role change, owner guard rails
- [ ] Policy tests: non-members can't read families or manage memberships

## Phase 2 — Finance core (no sharing yet)

- [ ] `Plano.Finance` domain: `Transaction` with Money amount + currency from
      actor's `currency` field on create
- [ ] Actions: create (private only in this phase), update, destroy, read
- [ ] Policies from design §3 (private branch exercised end-to-end: no
      accidental leaks for other users)
- [ ] family_id validation (actor must be member when set) — key phase despite
      visibility still defaulting private
- [ ] `mix ash.codegen` + migrations
- [ ] Tests: private visibility hides from other users including family members

## Phase 3 — Sharing & splits

- [ ] Introduce `visibility: :family` policy branch; locked to family_id
- [ ] Introduce `visibility: :shared` + `TransactionShare` resource per design
- [ ] `share` action (atomic): sets visibility, upserts shares, enforces
      sum(amount) == transaction.amount
- [ ] Equal-split default when only members are provided (no per-member amounts)
- [ ] Split editor flow: allow per-member adjustment after equal default
- [ ] `mark_settled` action — only the share's own member
- [ ] Tests: sum mismatch rejected; leaking through exists() policy paths;
      settling only own share; non-family-member shares rejected

## Phase 4 — LiveViews

- [ ] `/families` (create, list, member management UI)
- [ ] `/transactions` list with `mine | shared-with-me | family` tabs
- [ ] `/transactions/new` + edit form w/ Money input, visibility selector,
      family picker, nested shares UI when `:shared`
- [ ] `/` dashboard with recent authorized transactions
- [ ] AshPhoenix form integration (follow `ash_phoenix/best_practices`)
- [ ] run `mix precommit`

## Phase 5 — Hardening

- [ ] Full test suite green (`mix precommit` from any dir)
- [ ] Seed script for demo family + members (dev only)
- [ ] Verify `mix ash.generate_policy_charts` matches design §3 matrix
- [ ] Tag MVP version in git (v0.1.0)

## Future (parked, not MVP)

- categories/tags, recurring transactions, budgets, reports
- settlement balances (Simplified who-owes-whom), notifications
- email invitation flow for family owners
- multi-currency conversion
