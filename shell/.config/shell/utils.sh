function get_bq_schema() {
    project=$1
    dataset=$2
    table=$3
    bq show --format=prettyjson "${project}:$dataset.$table" | jq ".schema.fields"
}

function get_bq_load_log() {
    job_id=$1
    bq --format=prettyjson show -j $job_id
}

function switch_to_worktree() {
  local selected
  selected=$(git worktree list | fzf | awk '{print $1}')
  [[ -n "$selected" ]] && cd "$selected"
}

op-work() (
  unsetopt xtrace

  : "${OP_KEYCHAIN_SERVICE:?Set OP_KEYCHAIN_SERVICE}"
  : "${OP_KEYCHAIN_PATH:?Set OP_KEYCHAIN_PATH}"

  local token
  token=$(/usr/bin/security find-generic-password \
    -s "$OP_KEYCHAIN_SERVICE" \
    -w "$OP_KEYCHAIN_PATH") || return

  if [[ -z "$token" ]]; then
    print -u2 'Keychain returned an empty 1Password service account token'
    return 1
  fi

  OP_SERVICE_ACCOUNT_TOKEN="$token" /opt/homebrew/bin/op "$@"
)

function 1p2env() {
  setopt localoptions
  unsetopt xtrace

  if (( $# != 2 )); then
    print -u2 'Usage: 1p2env ENV_VAR op://vault/item/field'
    return 1
  fi
  if [[ ! $1 =~ '^[A-Za-z_][A-Za-z0-9_]*$' || $1 == _1p2env_* ]]; then
    print -u2 'Invalid environment variable name (prefix _1p2env_ is reserved)'
    return 1
  fi

  local _1p2env_value
  _1p2env_value=$(op-work read "$2") || return
  if [[ -z "$_1p2env_value" ]]; then
    print -u2 '1Password returned an empty secret'
    return 1
  fi

  typeset -gx "$1=$_1p2env_value"
}

function git() {
    if [[ "$(pwd)" == "/mnt/c/obsidian/notes" ]]; then
        git.exe "$@"
    else
        command git "$@"
    fi
}
