#!/usr/bin/env bash

# authors:
#   Nurudin Imsirovic <github.com/NurudinImsirovic>
#
# file:
#   root-dotfiles-symlinks.sh
#
# summary:
#   Quick and dirty bash script to create soft symlinks
#   for the root user dotfiles that point to a non-root
#   users directory.
#
# requirements:
#   This script must be run by a non-root user through
#   'sudo'
#
# created:
#   2026-01-28 07:41 PM
#
# updated:
#   2026-01-28 08:17 PM

if [ $EUID -ne 0 ]; then
  echo "Error: Run this script with sudo as a regular user."
  exit 1
fi

for filepath in $(find /home/$SUDO_USER/.* -maxdepth 0 -type f); do
  sympath=/root/$(basename $filepath)

  # unlink previously created symbolic links
  if [ -h $sympath ]; then
    unlink $sympath
  fi

  # only make soft symbolic links to files (strict)
  if [ -r $filepath ] && [ -f $filepath ]; then
    # file already exists - not a symlink so skipping
    if [ -f $sympath ] && [ ! -h $sympath ]; then
      printf "Warning: %s (regular file --- skipping)\n" $sympath
      continue
    fi

    ln -s $filepath $sympath
    printf "Symlink: %s --> File: %s\n" $sympath $filepath
  fi
done

echo "Done."
