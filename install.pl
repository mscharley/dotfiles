#!/usr/bin/env perl

use warnings;
use strict;

use Cwd qw(realpath);
use File::Basename;
use File::Compare;
use File::Path qw(make_path);

sub get_filename {
  my ($file) = (@_, $_);
  $file =~ s/\.(?:example)$//;
  $file =~ s!%!/!g;
  return $file;
}

sub replace_file {
  my $target = get_filename();
  system("rm", "-rf", $ENV{'HOME'} . '/.' . $target);
  link_file()
}

sub link_file {
  my $target_file = get_filename();
  my $target = $ENV{"HOME"} . '/.' . $target_file;
  make_path(dirname($target));
  my $is_example = /\.example$/;

  if ($is_example && -d $_) {
    print("creating folder ~/.$target_file\n");
    make_path($target);
  }
  elsif ($is_example) {
    print("copying ~/.$target_file\n");
    system('cp', '-v', $_, $target);
  }
  else {
    print("linking ~/.$target_file\n");
    system('ln', '-vs', realpath($_), $target);
  }
}

my @files = glob('*');
my $replace_all = 0;

for (@files) {
  # Skip metafiles and Windows-specific files.
  next if /^imports$|^Dockerfile$|\.md$|\.ps1$/ || (-x && ! -d);

  my $is_example = /\.example$/;
  my $target_file = get_filename();
  my $target = $ENV{"HOME"} . '/.' . $target_file;

  if ($is_example && -f $target) {
    # Do nothing if an example was already installed.
    print("exists ~/.$target_file\n");
  }
  elsif (!$is_example && -l $target) {
    if (readlink($target) eq realpath($_)) {
      print("identical ~/.$target_file\n");
    }
    else {
      print("replace link ~/.$target_file\n");
      replace_file();
    }
  }
  elsif (-e $target) {
    if (compare($target, $_) == 0) {
      print("identical ~/.$target_file\n");
    }
    elsif ($replace_all) {
      print("replace ~/.$target_file\n");
      replace_file();
    }
    else {
      print("overwrite ~/.$target_file? [ynaq] ");
      chomp(my $in = <STDIN>);

      if ($in eq 'a') {
        $replace_all = 1;
        replace_file();
      }
      elsif ($in eq 'y') { replace_file() }
      elsif ($in eq 'q') { exit(1) }
      else { print("skipping ~/.$target_file\n") }
    }
  }
  else {
    link_file();
  }
}

my $uname = `uname -s`;
chomp($uname);
my @imports = glob('imports/' . $uname . '/*');

for my $import (@imports) {
  if (-x $import) {
    system($import);
  }
}
