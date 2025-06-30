#!/usr/bin/env bash

# Authors:
#   Nurudin Imsirovic <imshvc>
#
# File:
#   apply.sh
#
# Summary:
#   Copy dotfiles to $home_path
#
# Created:
#   2025-02-07 11:44 AM
#
# Updated:
#   2025-06-30 08:15 AM

# Cygwin is not supported
if [[ "$(uname -s)" =~ ^CYGWIN_NT.* ]]; then
  echo "fail: cygwin is not supported"
  exit 1
fi

# No location given - defaults to $HOME
home_path=$HOME

# Check argument values
if [ $# != 0 ]; then
  new_path=$1

  # Check is path valid
  resolved_path=$(realpath -e "$new_path" 2>/dev/null)

  if [ $? != 0 ]; then
    echo "fail: invalid output path: $new_path"
    exit 2
  else
    home_path=$resolved_path
  fi
fi

# Detect MSYS2
is_msys2=0
if [[ "$(uname -s)" =~ ^MSYS_NT.* ]]; then
  is_msys2=1

  # Workaround if user not set
  if [ "$USER" = "" ]; then
    USER=$USERNAME
  fi
fi

mkdir -p "$home_path/.local/share/nano-syntax-highlighting" >&/dev/null

# Deprecation Notice: Scripts and binaries coexist at ~/bin

cp ".bash_aliases" "$home_path" >&/dev/null
cp ".bash_config" "$home_path" >&/dev/null
cp ".bash_exports" "$home_path" >&/dev/null
cp ".bash_functions" "$home_path" >&/dev/null
cp ".bash_login" "$home_path" >&/dev/null
cp ".bash_logout" "$home_path" >&/dev/null
cp ".bash_profile" "$home_path" >&/dev/null
cp ".bashrc" "$home_path" >&/dev/null
cp ".gitconfig" "$home_path" >&/dev/null
cp ".hushlogin" "$home_path" >&/dev/null
cp ".nanorc" "$home_path" >&/dev/null
cp ".npmrc" "$home_path" >&/dev/null
cp ".pathlst" "$home_path" >&/dev/null
cp ".profile" "$home_path" >&/dev/null
cp ".wgetrc" "$home_path" >&/dev/null

# Bash history
if [ ! -f "$home_path/.bash_history" ]; then
  touch "$home_path/.bash_history"
fi

# Improved syntax highlighting for GNU nano.
if [ -f "nano-syntax-highlighting.zip" ]; then
  unzip -qq -o "nano-syntax-highlighting.zip" -d "$home_path/.local/share/nano-syntax-highlighting" 2>&1 >/dev/null
fi

# This script runs on MSYS2 and must
# be last to overwrite prior files.
if [ $is_msys2 = 1 ]; then
  if [ -f "msys2/apply.sh" ]; then
    # pass: found
    pushd "msys2" 2>&1 >/dev/null

    chmod +x "apply.sh"
    ./apply.sh "$home_path"

    popd 2>&1 >/dev/null
  else
    echo "fail: msys2/apply.sh not found"
  fi
fi

echo "imshvc/dotfiles... done"
exit 0
