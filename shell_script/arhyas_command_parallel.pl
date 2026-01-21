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

my $target_addr = dialog("Please enter target address:", "42");




chomp $target_addr;

for my $i (1..2000) {
    say "Round $i";
    
    # take care of the target first
    # traceroute may not show the target, so do the rest secondly
    # ./arhyas_msg.sh "$1" && traceroute "$1" | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}
    
    # Execute the first command
    system("./arhyas_msg.sh", $target_addr);
    
    # Execute traceroute and pipe through tracelist.sh and arhyas_msg.sh
    # Using open3 to handle the pipeline properly
    my $pid = open(my $traceroute_fh, "-|", "traceroute", $target_addr);
    if ($pid) {
        # Parent process - read traceroute output
        while (my $line = <$traceroute_fh>) {
            chomp $line;
            # Process through tracelist.sh (assuming it processes each line)
            # We'll simulate xargs -I {} ./arhyas_msg.sh {}
            # First, let's get the output from tracelist.sh
            my $tracelist_pid = open(my $tracelist_fh, "-|", "./tracelist.sh");
            if ($tracelist_pid) {
                print $tracelist_fh "$line\n";
                close($tracelist_fh);
                waitpid($tracelist_pid, 0);
                
                # Now read tracelist.sh output and execute arhyas_msg.sh for each
                # Actually, we need to pipe traceroute output to tracelist.sh
                # Let's do it differently
            }
        }
        close($traceroute_fh);
        waitpid($pid, 0);
    }
    
    # Alternative approach: Use backticks to capture output and process
    my $traceroute_output = `traceroute $target_addr`;
    my @traceroute_lines = split(/\n/, $traceroute_output);
    
    # Process through tracelist.sh for each line
    foreach my $line (@traceroute_lines) {
        # Pipe the line to tracelist.sh and capture output
        open(my $tracelist_pipe, "|-", "./tracelist.sh");
        print $tracelist_pipe "$line\n";
        close($tracelist_pipe);
        
        # Actually, tracelist.sh might output multiple addresses
        # Let's capture tracelist.sh output and process each
        my $tracelist_output = `echo "$line" | ./tracelist.sh`;
        my @addresses = split(/\s+/, $tracelist_output);
        
        foreach my $address (@addresses) {
            next if $address eq '';
            system("./arhyas_msg.sh", $address);
        }
    }
    
    # Wait for any background processes
    my $child_pid = wait();
    
    # Generate random sleep between 0 and 1199 seconds
    my $sec = int(rand(1200));
    say "Round $i scheduled, sleeping $sec seconds...";
    sleep($sec);
}

# Alternative simpler implementation using system calls similar to bash
sub run_simple_version {
    my $target = shift;
    
    for my $i (1..2000) {
        say "Round $i";
        
        # Direct system call similar to bash
        system("./arhyas_msg.sh $target && traceroute $target | ./tracelist.sh | xargs -I {} ./arhyas_msg.sh {}");
        
        # Generate random sleep
        my $sec = int(rand(1200));
        say "Round $i scheduled, sleeping $sec seconds...";
        sleep($sec);
    }
}

# Main execution
if ($target_addr) {
    # Using the simpler approach that mimics bash behavior
    run_simple_version($target_addr);
} else {
    die "No target address provided!\n";
}
