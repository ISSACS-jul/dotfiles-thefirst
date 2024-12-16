#!/usr/bin/perl

use warnings;
use strict;

=head1 NAME

cursorconf.pl

=head1 VERSION

version 0.3

=head1 DESCRIPTION

Update existing configuration files for xcursorgen.

Appends multiples of 32, assuming 32px is the default size.


=head1 SYNOPSIS

perl cursorconf.pl *.cursor

=head1 METHODS

=cut

# Sizes are multiples of the original 32px SVG
my @sizes = (1.5, 2, 2.25, 3);

=head2 readfile 

Arguments: filename
Returns: array of lines

Copies file contents to memory, returned as an array

=cut

sub readfile {
	my @lines;
	my $arg = shift;
	
	open (my $f, '<', $arg) or die "Could not read file $arg";
	print "Reading configuration from $arg.\n";

	while (my $line = <$f>) {
		push(@lines, $line)
	}
	return @lines
}

=head2 appendconf

Arguments: filename, array of file contents

Output size, x hotspot, y hotspot, and filename to xcursorgen config file.

=cut

sub appendconf {
	my $arg = shift;
	my @lines = @{$_[0]};

	open (my $of, '>>', $arg) or die "Could not open file for writing $arg";
	print "Appending configuration to $arg.\n";
	
	foreach my $mult (@sizes) {
		for my $line (@lines) {
        	my @elems = split ' ', $line;
			# Round up values to next integer (ceil)
        	my $size = int($elems[0] * $mult + 0.99);
        	my $x = int($elems[1] * $mult + 0.99);
        	my $y = int($elems[2] * $mult + 0.99);
        	my $fn = $elems[3];
        	print $of "$size $x $y $size/$fn\n";
    	}	
	}
	close $of; 
}


=head2 main

Process all command line arguments

=cut

foreach my $arg(@ARGV) {
	my @lines = readfile($arg);

	# Append the additional configuration lines for each size to the file
    appendconf($arg, \@lines);

	# Reread the input file to verify changes
	@lines = readfile($arg);
	
	print "Verifying Changes...\n";
	foreach(@lines){
		print $_;
	}
}

1;
