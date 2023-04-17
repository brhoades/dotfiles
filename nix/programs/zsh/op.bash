function opbash_signin() {
  op whoami >> /dev/null 2>&1
  if [[ $? -ne 0 ]]
  then
    eval $(op signin --account my)
  fi
}

function opbash_get_names() {
  op item list --format=json | jq -r '.[].title' | sort | uniq
}

function opbash_get_entry() {
  json=$(op item get --format=json "$1")
  username=$(echo $json | jq -r '.fields[]|select(.purpose=="USERNAME")|.value')
  password=$(echo $json | jq -r '.fields[]|select(.purpose=="PASSWORD")|.value')
  echo "item: $1\nuser: $username\npassword: $password"
  echo -n "$password" | wl-copy
  echo "copied password to clipboard"
}

function oppw() {
  opbash_signin

  if [[ $# -ne 0 ]]; then
    query=$(printf '%q ' "${argv[@]}")
    opname=$(opbash_get_names | fzf --query="$query")
  else
    opname=$(opbash_get_names | fzf)
  fi

  if [[ -z "$opname" ]]; then
    echo "Failed to query"
  else 
    opbash_get_entry "$opname"
  fi
}
