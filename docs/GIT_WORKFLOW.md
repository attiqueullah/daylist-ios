# Git workflow

Applies to every change, by people and by coding agents.

## Branches
- `main` is always buildable: 0 errors, 0 SwiftLint warnings, all tests green. Nobody commits to it directly.
- One short-lived branch per stage or task, cut from an up-to-date `main`:
  - `m1/stage-2-design-system` (milestone work: `m<N>/stage-<n>-<slug>`)
  - `feat/<slug>`, `fix/<slug>`, `chore/<slug>`, `docs/<slug>` (everything else)
- Delete the branch after it is merged.

## Commits
Conventional Commits: `type(scope): imperative summary`, 72 characters or fewer, no trailing full stop.
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `style`, `perf`, `build`, `chore`.
- Scope is the area: `design-system`, `home`, `router`, `l10n`, `lint`, `project`.
- Body (optional) explains why, not what. Reference the QA case (`TC-002`) when relevant.
- One logical change per commit. Never mix a refactor with a feature.
- Commits made by an agent end with the `Co-Authored-By` and `Claude-Session` trailers.
- Never commit: secrets, tokens, `xcuserdata/`, `DerivedData/`, `.DS_Store`.
- Do not rewrite history that is already on GitHub (no force-push to `main`; use `--force-with-lease` only on your own branch).

## A stage, start to finish
1. `git switch main && git pull --ff-only`
2. `git switch -c m1/stage-2-design-system`
3. Work in small commits. Build, lint and test before handing over.
4. Attique reviews in Xcode and approves.
5. `git push -u origin m1/stage-2-design-system`, then open a pull request (template in `.github/`).
6. Squash-merge. The squashed commit on `main` is titled `M1 Stage 2: Design system`, so `main` keeps one commit per stage.
7. `git switch main && git pull --ff-only`, delete the branch, then tag when the stage is done.

## Tags
Annotated tags on `main`: `m1-stage-<n>` after each stage, `v0.<milestone>.0` when a milestone passes QA (for example `v0.1.0` for M1). Push with `git push origin <tag>`.

## Hooks
Enable once per clone: `git config core.hooksPath .githooks`.
`commit-msg` rejects messages that are not Conventional Commits (merge and revert commits are allowed).

## Recommended GitHub settings (repo owner)
Settings ▸ Branches ▸ rule for `main`: require a pull request, block force pushes, block deletion. Settings ▸ General: allow squash merging only, and delete head branches on merge.
