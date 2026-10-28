# P2-05 — Categories management UI

**Status:** Blocked
**Owner:** _unassigned_
**Size:** S
**Phase:** 2 — Personal finance UI
**Depends on:** P2-01
**Parallel with:** P2-02, P2-03, P2-04, P2-06

## Goal

Implement `/categories` for personal category management.

## Deliverables

- List categories grouped by kind with color swatches
- Create form (name, kind, color)
- Inline rename/recolor
- Delete with confirmation
- Guard: deleting a category used by transactions either:
  - is blocked with a clear message, or
  - clears `category_id` on affected transactions (choose one and document)
- Empty state

## Files owned

- `lib/plano_web/live/categories_live.ex`
- `test/plano_web/live/categories_live_test.exs`

## Acceptance criteria

- [ ] Create, rename, recolor, delete work
- [ ] Duplicate name/kind shows a friendly error
- [ ] Another user's categories are never visible
- [ ] Used-category delete behavior matches the documented choice
- [ ] Tests pass

## Verification

```bash
mix test test/plano_web/live/categories_live_test.exs
```

## Notes

- Do not edit the router or layouts.
- Default palette suggestion: 8 accessible colors.
