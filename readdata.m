function [ obsnew,time,sats,linex ] = readdata(fidxxx,linez)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% fprintf('\nreaddata started from :');
linez;
%% start read time
% if ((size(deblank(linez),2)==68) && (isempty(findstr('G',linez))==0) && (strcmp(linez(29),'0') == 1))
  if ((isempty(findstr('G',linez))==0) && (strcmp(linez(29),'0') == 1))
    year=linez(2:3);
    month=linez(5:6);
    day=linez(8:9);
    hour=linez(11:12);
    minute=linez(14:15);
%     second=linez(17:26)
    second=linez(17:18);
    number_of_sat_vehicles=linez(31:32);
end
%%% end read time

%%% start calcuate time
h = str2num(hour)+str2num(minute)/60+str2num(second)/3600;
jd = julday(str2num(year)+2000, str2num(month), str2num(day), h);
[week, sec_of_week] = gps_time(jd);
jd;
time = sec_of_week; % function output
%%% end calculate time


%% start read gps sats
x=findstr('G',linez);
    for i=1:numel(x)
    prn1(1,i)=str2num(linez(x(1,i)+1:(x(1,i)+2)));
    end
linez=fgetl(fidxxx);

x1=findstr('G',linez);
 for i=1:numel(x1)
    prn2(1,i)=str2num(linez(x1(1,i)+1:(x1(1,i)+2)));
 end
prn=[prn1 prn2];
sats = prn(:); % function output
%% end read gps sats




% %% start reading data %% %

no_of_gps_sats=numel(sats);
obs=zeros(11,5); % 11 GPS satellites and 5 types of observations
% 7 Observation Types are Obs_types1=L1L2C1P2P1S1S2
% no_of_observation_types=size(Obs_types1,2)/2=7
% We care about 5 types of GPS observations L1L2C1P1P2 only
% and there are no P1 observations in the observation file
% so we set the no_of_observation_types=4 (L1L2C1P2)
no_of_observation_types=4;

% Obsloop=zeros(no_of_gps_sats,no_of_observation_types);
Obsloop=zeros(18,no_of_observation_types);
% 18 because the last 3 of 21 are s type sats, reading them is problematic
for u = 1:18
      linez = fgetl(fidxxx);
      for k = 1:no_of_observation_types
         Obsloop(u,k) = str2num(linez(2+16*(k-1):16*k-2)); 
         
      end
      linez=fgetl(fidxxx);
end

gps_rows=[1 3 4 5 6 9 11 12 13 14 16];
for i=1:numel(gps_rows)
    a3=Obsloop(gps_rows(1,i),:);
    obsnew(i,:)=a3; % function output
end
linex=fgetl(fidxxx);
linex=fgetl(fidxxx);
linex=fgetl(fidxxx);
linex=fgetl(fidxxx);
linex=fgetl(fidxxx);
linex=fgetl(fidxxx);
linex=fgetl(fidxxx);
end % function end

