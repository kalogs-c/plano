# P2-01 — Personal UI foundation

**Status:** Blocked
**Owner:** _unassigned_
**Size:** M
**Phase:** 2 — Personal finance UI
**Depends on:** P1-04
**Parallel with:** —

## Goal

Lay down the authenticated LiveView surface so page tasks can run in parallel
without touching the router or layouts.

## Deliverables

- Authenticated `live_session` routes in `router.ex`:
  - `/` → `DashboardLive`
  - `/transactions` → `TransactionsLive.Index`
  - `/transactions/new` → `TransactionsLive.Form`
  - `/transactions/:id/edit` → `TransactionsLive.Form`
  - `/categories` → `CategoriesLive`
  - `/settings` → `SettingsLive`
  - all use `on_mount {PlanoWeb.LiveUserAuth, :live_user_required}`
- Replace the placeholder `PageController` home route with the dashboard.
- Empty but compiling LiveView modules in separate files (one per page).
- App navigation in `Layouts.app`: Dashboard, Transactions, Categories,
  Settings, sign-out, current user email.
- Shared `PlanoWeb.FinanceComponents` module:
  - money formatting
  - money input
  - month picker/selector
  - kind tabs/selector
  - category picker
  - transaction row
  - empty state
- A small `PlanoWeb.Live.Helpers` or equivalent for common assigns/actor access
  if useful.

## Files owned

- `lib/plano_web/router.ex`
- `lib/plano_web/components/layouts.ex`
- `lib/plano_web/components/finance_components.ex`
- `lib/plano_web/live/dashboard_live.ex`
- `lib/plano_web/live/transactions_live/index.ex`
- `lib/plano_web/live/transactions_live/form.ex`
- `lib/plano_web/live/categories_live.ex`
- `lib/plano_web/live/settings_live.ex`
- `lib/plano_web/controllers/page_controller.ex` (remove if unused)
- `lib/plano_web/controllers/page_html.ex` + `page_html/` (remove if unused)

## Shared contracts

Publish before merging:

- Component names/attrs in `FinanceComponents`
- Assign names used by each LiveView (`:current_user`, `:month`, etc.)
- Route helpers and paths

## Acceptance criteria

- [ ] All routes compile and render placeholder pages
- [ ] Unauthenticated access redirects to `/sign-in`
- [ ] Nav highlights the active section
- [ ] Shared components compile and have moduledocs/examples
- [ ] Tests for redirect + placeholder rendering pass

## Verification

```bash
mix compile --warnings-as-errors
mix test test/plano_web/live
```

## Notes

- Do not implement page logic here; keep each LiveView a shell.
- This task is the only one in Phase 2 that edits `router.ex` and
  `layouts.ex`.
