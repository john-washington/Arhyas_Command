


# Source - https://stackoverflow.com/a
# Posted by harvey
# Retrieved 2026-01-12, License - CC BY-SA 3.0

#!/usr/bin/env perl

use strict;

sub osascript($) { system 'osascript', map { ('-e', $_) } split(/\n/, $_[0]); }

sub dialog {
  my ($text, $default) = @_;
  osascript(qq{
        tell app "System Events"
            text returned of (display dialog "$text" default answer "$default" buttons {"OK"} default button 1 with title "$(basename $0)")
        end tell
  });
}

my $result = dialog("Life, the universe and everything?", "42");
