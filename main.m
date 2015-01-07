close all; clear all; clearvars; clc;
% the navigation file
navfile='7odm3400.14n';
outputfile='eph.dat';
% the observation file
obsfile='7odm3400.14o';

%% read the navigation file
rinexe(navfile,outputfile);
Eph = get_eph(outputfile);
