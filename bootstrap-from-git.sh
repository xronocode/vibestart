#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Bootstrap VIBE into the current or target repository by fetching vibestart from git.

Usage:
  bootstrap-from-git.sh --repo <git-url-or-path> --ref <tag-or-branch> (--core | --deep) [--target <path>] [--force] [--dry-run]

Options:
  --repo    Git URL or local git repository path containing vibestart.
  --ref     Git tag or branch to fetch. Defaults to v4.0.0-beta.1.
  --core    Bootstrap the core profile.
  --deep    Bootstrap the deep profile.
  --target  Target repository path. Defaults to the current directory.
  --force   Allow overwrite of existing VIBE surfaces in the target.
  --dry-run Show what would be installed without writing files.
  --keep-clone  Keep the temporary fetched vibestart checkout for inspection.
  -h, --help    Show this help message.

Environment:
  VIBESTART_REPO_URL may be used instead of --repo.
EOF
}

die() {
  printf '%s\n' "$1" >&2
  exit 1
}

repo_url="${VIBESTART_REPO_URL:-}"
ref="v4.0.0-beta.1"
target="."
profile=""
force=0
dry_run=0
keep_clone=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      [[ $# -ge 2 ]] || die "--repo requires a value."
      repo_url="$2"
      shift 2
      ;;
    --ref)
      [[ $# -ge 2 ]] || die "--ref requires a value."
      ref="$2"
      shift 2
      ;;
    --target)
      [[ $# -ge 2 ]] || die "--target requires a value."
      target="$2"
      shift 2
      ;;
    --core)
      profile="core"
      shift
      ;;
    --deep)
      profile="deep"
      shift
      ;;
    --force)
      force=1
      shift
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    --keep-clone)
      keep_clone=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac
done

[[ -n "$repo_url" ]] || die "A git source is required. Use --repo <git-url-or-path> or set VIBESTART_REPO_URL."
[[ -n "$profile" ]] || die "Explicit profile selection is required. Use --core or --deep."

tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/vibestart-fetch.XXXXXX")"
clone_dir="$tmpdir/repo"

cleanup() {
  if [[ "$keep_clone" -eq 0 ]]; then
    rm -rf "$tmpdir"
  fi
}
trap cleanup EXIT

printf 'Fetching vibestart from git source: %s\n' "$repo_url"
printf 'Using ref: %s\n' "$ref"

git clone --depth 1 --branch "$ref" "$repo_url" "$clone_dir" >/dev/null 2>&1 \
  || die "Failed to fetch vibestart from git source '$repo_url' at ref '$ref'."

cmd=(python3 "$clone_dir/vibestart" "--$profile" "--target" "$target")
if [[ "$force" -eq 1 ]]; then
  cmd+=("--force")
fi
if [[ "$dry_run" -eq 1 ]]; then
  cmd+=("--dry-run")
fi

"${cmd[@]}"
