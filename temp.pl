#!/usr/bin/perl

use strict;
use warnings;
use Switch;

open(CRFILE,'<','cr_output');
open(DEPSFILE,'>','deps');

my $target_num = 0;
my $ignore_path = 5;
my $build_section = 0;
my $mvfs_section = 0;
my $variables_section = 0;
my @target = "";
my @deps = "";
my @dep1 = "";
my @build_script = "";
my @variables = "";
my $depobj = "";
my @array = "";
my $j = 0;

while(<CRFILE>) {

        chomp($_);
        next if ($_ eq "----------------------------");
        my @line_array = split(/ /,$_);

        switch($line_array[0]) {
                case "Target" {
                        $target[$target_num] = $line_array[1];
                        @deps = $target[$target_num];
                        @variables = $target[$target_num];
                        @build_script = $target[$target_num];
                        $target_num++;
                        }

                case "MVFS" {
                        $build_section = 0;
                        $variables_section = 0;
                        $mvfs_section = 1;
                }

                case "Variables" {
                        $build_section = 0;
                        $variables_section = 1;
                        $mvfs_section = 0;
                }

                case "Build" {
                        $build_section = 1;
                        $variables_section = 0;
                        $mvfs_section = 0;
                }

        if ($mvfs_section eq 1) {
                my @deps = split (/\@\@/,$_);
                my @deps1 = split (/\//,$deps[0]);
                my $ignore_path1 = $ignore_path - 1;
                for (my $i=$ignore_path1; $i<=$#deps1; $i++) {
                        $depobj = $depobj."/".$deps1[$i];
                }
                $depobj =~ s/^\///;
                $array[$j] = "Target is $target[$target_num -1] $depobj\n";
                $j++;
                #print ( "$depobj\n" );
                $depobj="";

        }



        }
}
my @array1 = reverse @array;
print @array1;
print DEPSFILE @array1;
close(CRFILE);
close(DEPSFILE);
