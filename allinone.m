close all; clear all; clearvars; clc;
% the navigation file
navfile='7odm3400.14n';
outputfile='eph.dat';
% the observation file
obsfile='7odm3400.14o';

%% read the navigation file
% rinexe(navfile,outputfile);
% Eph = get_eph(outputfile);

fidn = fopen(navfile);
head_lines = 0;

while 1  % We skip header
   head_lines = head_lines+1;
   line = fgetl(fidn);
   answer = findstr(line,'END OF HEADER');
   if ~isempty(answer), break;	end;
end;

head_lines
noeph = -1;
while 1
   noeph = noeph+1;
   line = fgetl(fidn);
   if line == -1, break;  end
end;
noeph = noeph/8 %because at every instance there are 8 lines
frewind(fidn);
for i = 1:head_lines, line = fgetl(fidn); end;

% Set aside memory for the input
svprn	 = zeros(1,noeph);
weekno	 = zeros(1,noeph);
t0c	 = zeros(1,noeph);
tgd	 = zeros(1,noeph);
aodc	 = zeros(1,noeph);
toe	 = zeros(1,noeph);
af2	 = zeros(1,noeph);
af1	 = zeros(1,noeph);
af0	 = zeros(1,noeph);
aode	 = zeros(1,noeph);
deltan	 = zeros(1,noeph);
M0	 = zeros(1,noeph);
ecc	 = zeros(1,noeph);
roota	 = zeros(1,noeph);
toe	 = zeros(1,noeph);
cic	 = zeros(1,noeph);
crc	 = zeros(1,noeph);
cis	 = zeros(1,noeph);
crs	 = zeros(1,noeph);
cuc	 = zeros(1,noeph);
cus	 = zeros(1,noeph);
Omega0	 = zeros(1,noeph);
omega	 = zeros(1,noeph);
i0	 = zeros(1,noeph);
Omegadot = zeros(1,noeph);
idot	 = zeros(1,noeph);
accuracy = zeros(1,noeph);
health	 = zeros(1,noeph);
fit	 = zeros(1,noeph);

for i = 1:noeph
   line = fgetl(fidn);	  %
   svprn(i) = str2num(line(1:2));
   year = line(3:6);
   month = line(7:9);
   day = line(10:12);
   hour = line(13:15);
   minute = line(16:18);
   second = line(19:22);
   af0(i) = str2num(line(23:41));
   af1(i) = str2num(line(42:60));
   af2(i) = str2num(line(61:79));
   line = fgetl(fidn);	  %
   IODE = line(4:22);
   crs(i) = str2num(line(23:41));
   deltan(i) = str2num(line(42:60));
   M0(i) = str2num(line(61:79));
   line = fgetl(fidn);	  %
   cuc(i) = str2num(line(4:22));
   ecc(i) = str2num(line(23:41));
   cus(i) = str2num(line(42:60));
   roota(i) = str2num(line(61:79));
   line=fgetl(fidn);
   toe(i) = str2num(line(4:22));
   cic(i) = str2num(line(23:41));
   Omega0(i) = str2num(line(42:60));
   cis(i) = str2num(line(61:79));
   line = fgetl(fidn);	    %
   i0(i) =  str2num(line(4:22));
   crc(i) = str2num(line(23:41));
   omega(i) = str2num(line(42:60));
   Omegadot(i) = str2num(line(61:79));
   line = fgetl(fidn);	    %
   idot(i) = str2num(line(4:22));
   codes = str2num(line(23:41));
   weekno = str2num(line(42:60));
   L2flag = str2num(line(61:79));
   line = fgetl(fidn);	    %
   svaccur = str2num(line(4:22));
   svhealth = str2num(line(23:41));
   tgd(i) = str2num(line(42:60));
   iodc = line(61:79);
   line = fgetl(fidn);	    %
   tom(i) = str2num(line(4:22));
%    spare = line(23:41);
%    spare = line(42:60);
%    spare = line(61:79);
end
status = fclose(fidn)

%  Description of variable eph.
eph(1,:)  = svprn;
eph(2,:)  = af2;
eph(3,:)  = M0;
eph(4,:)  = roota;
eph(5,:)  = deltan;
eph(6,:)  = ecc;
eph(7,:)  = omega;
eph(8,:)  = cuc;
eph(9,:)  = cus;
eph(10,:) = crc;
eph(11,:) = crs;
eph(12,:) = i0;
eph(13,:) = idot;
eph(14,:) = cic;
eph(15,:) = cis;
eph(16,:) = Omega0;
eph(17,:) = Omegadot;
eph(18,:) = toe;
eph(19,:) = af0;
eph(20,:) = af1;
eph(21,:) = toe;

fidu = fopen(outputfile,'w');
count = fwrite(fidu,[eph],'double');
fclose all

%% get ephemeries values from output file
fido = fopen(outputfile);
[eph, count] = fread(fido, Inf, 'double');
noeph = count/21;
eph = reshape(eph, 21, noeph);
