#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use Time::HiRes qw(sleep);

#print "Please enter target address: ";
#my $target_addr = <STDIN>;


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

my $mypasswd = dialog("Please enter administrative password:", "xxx");


#chomp $mypasswd;

# Execute the first command
#system("./arhyas_command_mac.sh", $mypasswd);
    
    

# Main execution
#if ($mypasswd) {
    # Using the simpler approach that mimics bash behavior
    #run_simple_version($mypasswd);
    # Direct system call similar to bash
    system("./dependency_check.sh", $mypasswd);
        
#} else {
#    die "No mypasswd provided!\n";
#}
