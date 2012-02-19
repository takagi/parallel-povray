#! /opt/local/bin/perl

#  This file is a part of parallel-povray project.
#  Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)

use List::Util qw( min );


## Utilities

sub len {
    $n = @_
}

sub process {
    my $fn = $_[0];
    my $pid = fork;
    die "Cannot fork: $!" unless defined $pid;
    return unless $pid;
    &$fn();
    wait();
    exit();
}

sub take_every {
    my ($xs, $n, $i) = @_;
    my $cnt = 0;
    my @ret = ();
    foreach $x (@$xs) {
        push( @ret, $x ) if $cnt % $n - $i == 0;
        $cnt++;
    }
    return @ret;
}


## Read from command line arguments

sub get_files {
    my @files = ();
    foreach $x (@_) {
        push( @files, $x ) if $x =~ /.pov$/;
    }
    return @files;
}

sub get_options {
    my @options = ();
    foreach $x (@_) {
        push( @options, $x ) if $x !~ /.pov$/;
    }
    return @options;
}

sub get_number_option {
    foreach $x (@_) {
        return $1 if $x =~ /^-n(\d+)/;
    }
    return 1;
}

sub get_confirm {
    foreach $x (@_) {
        return 1 if $x eq '--confirm';
    }
    return 0;
}

sub remove_number_option {
    my @ret = ();
    foreach $x (@_) {
        push( @ret, $x ) if $x !~ /^-n/;
    }
    return @ret;
}


## print sub routines

sub print_number {
    print "Number  : $_[0]\n";
}

sub print_files {
    print "Files   :\n";
    foreach $x (@_) {
        print $x . "\n"
    }
}

sub print_options {
    $option_string = join( ' ', @_ );
    print "Options : ${option_string}\n";
}

sub print_usage {
    print <<END;
Usage:

    parallel-povray -nN [--confirm] [option...] file...

    -nN         How many processes to use. N is an integer number (eg. 2)
    --confirm   Show interpreted arguments and povray commands that
                  parallel-povray publishes without running them
    files       Arguments that end with string ".pov" (eg. *.pov)
    options     Any other arguments which will be passed to povray unchanged
                  (eg. -D +W1920 +H1440)
END
}
    

## Make Povray command

sub make_povray_command {
    my ($files, $options, $n, $i) = @_;
    my $file_string = join( ' ', take_every( $files, $n, $i ) );
    my $option_string = join( ' ', @$options );
    return "for x in ${file_string}; do povray ${option_string} \$x; done";
}


## main

if ( len( @ARGV ) == 0 ) {
    print_usage();
    exit();
}

my $n = get_number_option( @ARGV );
my @options = get_options( remove_number_option( @ARGV ) );
my @files = get_files( remove_number_option( @ARGV ) );
my $confirm = get_confirm( @ARGV );

$n = min( $n, len( @files ) );

if ( $confirm ) {
    print_number( $n );
    print_options( @options );
    print_files( @files );
    print "Commands:\n";
    for ($i = 0; $i < $n; $i++) {
        print make_povray_command( \@files, \@options, $n, $i ) . "\n";
    }
    exit();
}

for ($i = 0; $i < $n; $i++) {
    process( sub { system( make_povray_command( \@files, \@options, $n, $i ) ); } );
}
wait();
