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

function git() {
    if [[ "$(pwd)" == "/mnt/c/obsidian/notes" ]]; then
        git.exe "$@"
    else
        command git "$@"
    fi
}

