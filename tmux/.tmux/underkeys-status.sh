#!/usr/bin/env bash
set -euo pipefail

underkeys="$HOME/.tmux/plugins/tmux-underkeys/scripts/underkeys"

# underkeys emits tmux formatting escapes around each session name. Split the
# rendered output into entries, remove formatting, and drop entries whose
# visible name starts with PI- (regardless of which character is underlined).
"$underkeys" status "$@" |
  perl -0pe '
    my $marker = "\x23[default] ";
    my @segments = split /\Q$marker\E/;
    $_ = join "", map {
      my $plain = $_;
      $plain =~ s/\x23\[[^]]*\]//g;
      $plain =~ /^PI-/ ? "" : $_ . $marker
    } @segments;
  '
