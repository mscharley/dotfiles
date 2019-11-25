#!/usr/bin/env perl

use warnings;
use strict;

use Cwd qw(realpath);
use File::Basename;
use File::Compare;
use File::Path qw(make_path);

if (-e $ENV{"HOME"} . '/.zshrc.local') {
  print("\x1b[31m");
  print("Detected a pre-XDG installation! The following update is potentially destructive and makes no attempt at a migration.\n");
  print("\n");
  print("More information: https://github.com/mscharley/dotfiles/pull/2\n");
  print("\n");
  print("To revert your last pull, press Ctrl-C to quit and then run `git reset --hard HEAD\@{1}`.\n");
  print("Press any other key to continue...\n");
  print("\x1b[0m");

  getc();
}

sub get_filename {
  my ($file) = (@_, $_);
  $file =~ s/\.(?:example)$//;
  $file =~ s!%!/!g;
  return $file;
}

sub replace_file {
  my ($src_file, $target_file) = @_;
  system("rm", "-rf", $target_file);
  link_file($src_file, $target_file)
}

sub link_file {
  my ($src, $target) = @_;
  make_path(dirname($target));
  my $is_example = $src =~ /\.example$/;

  if ($is_example && -d $src) {
    my $example_folder = $src;
    print("creating folder $target\n");
    make_path($target);

    my @example_files = glob($src . '/{*,.??*}');
    for (@example_files) {
      next if m!/.gitkeep$!;

      my $example_target = $_ =~ s/^\Q${example_folder}\E/${target}/r;

      print("copying $example_target\n");
      system('cp', '-v', $_, $example_target);
    }
  }
  elsif ($is_example) {
    print("copying $target\n");
    system('cp', '-v', $src, $target);
  }
  else {
    print("linking $target\n");
    system('ln', '-vs', realpath($src), $target);
  }
}

my $replace_all = 0;
sub process_files {
  my ($files, $src_prefix, $prefix) = @_;
  for (@$files) {
    my $is_example = /\.example$/;
    my $target_file = get_filename();
    my $target = $target_file =~ s/^\Q${src_prefix}\E/${prefix}/r;

    if ($is_example && -e $target) {
      # Do nothing if an example was already installed.
      print("exists $target\n");
    }
    elsif (!$is_example && -l $target) {
      if (readlink($target) eq realpath($_)) {
        print("identical $target\n");
      }
      else {
        print("replace link $target_file\n");
        replace_file($_, $target);
      }
    }
    elsif (-e $target) {
      if (compare($target, $_) == 0) {
        print("identical $target\n");
      }
      elsif ($replace_all) {
        print("replace $target\n");
        replace_file($_, $target);
      }
      else {
        print("overwrite $target? [ynaq] ");
        chomp(my $in = <STDIN>);

        if ($in eq 'a') {
          $replace_all = 1;
          replace_file($_, $target);
        }
        elsif ($in eq 'y') { replace_file($_, $target) }
        elsif ($in eq 'q') { exit(1) }
        else { print("skipping $target\n") }
      }
    }
    else {
      link_file($_, $target);
    }
  }
}

my $xdgConfig = $ENV{"XDG_CONFIG_HOME"} || $ENV{"HOME"} . "/.config";
my $xdgBin = $ENV{"XDG_BIN_HOME"} || $ENV{"HOME"} . "/.local/bin";
my $xdgData = $ENV{"XDG_DATA_HOME"} || $ENV{"HOME"} . "/.local/share";

my @files = glob('home/{*,.??*}');
my @xdgConfig = glob('xdg-config/{*,.??*}');
my @xdgBin = glob('xdg-bin/{*,.??*}');
my @xdgData = glob('xdg-data/{*,.??*}');
process_files(\@files, 'home/', $ENV{"HOME"} . "/.");
process_files(\@xdgConfig, 'xdg-config', $xdgConfig);
process_files(\@xdgBin, 'xdg-bin', $xdgBin);
process_files(\@xdgData, 'xdg-data', $xdgData);

my $uname = `uname -s`;
chomp($uname);
my @imports = glob('imports/' . $uname . '/*');

for my $import (@imports) {
  if (-x $import) {
    system($import);
  }
}
