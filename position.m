close all; clear all; clearvars; clc;
% the navigation file
navfile='7odm3400.14n';
outputfile='eph.dat';
% the observation file
obsfile='7odm3400.14o';

%% read the navigation file %%
rinexe(navfile,outputfile);
Eph = get_eph(outputfile);

%% read the observation file %%
fido = fopen(obsfile,'rt'); %rt is reading permission and t for text mode
%%% analyze observation file header %%
[Obs_types1, ant_delta1, ifound_types1, eof11] = anheader(obsfile);
NoObs_types1 = size(Obs_types1,2)/2;
Pos = [];
liney=skip_header(fido);
for q=1:27
[ obsnew1,time1,sats1,linex1 ] = readdata(fido,liney);
liney=linex1;
i = fobs_typ(Obs_types1,'P2');
pos = recpo_ls(obsnew1(:,i),sats1,time1,Eph);
Pos = [Pos pos];
scatter3(Pos(1,q),Pos(2,q),Pos(3,q),'fill');
hold on;
end

status=fclose(fido);

me = mean(Pos,2); % mean of each row
% scatter3(Pos(1,1),Pos(2,1),Pos(3,1))
% hold on;
% scatter3(Pos(1,2),Pos(2,2),Pos(3,2))
