clc;
clear all;
close all;
% Import data from text file
%    filename: D:\STUDY\Sweden\capacity19\Trafficcsv.csv
%make sure you are giving the correct file location

% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 8);
%Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["No", "Time", "TCPDelta", "Var4", "Var5", "Var6", "Size", "Var8"];
opts.SelectedVariableNames = ["No", "Time", "TCPDelta", "Size"];
opts.VariableTypes = ["double", "double", "double", "string", "string", "string", "double", "string"];
% Specify file level properties
opts.ImportErrorRule = "omitrow";
opts.MissingRule = "omitrow";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, ["Var4", "Var5", "Var6", "Var8"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var4", "Var5", "Var6", "Var8"], "EmptyFieldRule", "auto");

% Import the data
Trafficcsv = readtable("D:\STUDY\Sweden\capacity20\RONALDHO'NI-Analysis on Real Traffic Data\Trafficcsv.csv", opts);


% Clear temporary variables
clear opts

%getting packet number,Time and Packet size from data
packetnum_p = Trafficcsv{:,1};
time_p = Trafficcsv{:,2};
delta_p = Trafficcsv{:,3};
packetsize_p = Trafficcsv{:,4};
% now creating a table having packetSize 60
packetsize_p60 =Trafficcsv(Trafficcsv.Size==60,1:4);
packetnum_60 = packetsize_p60{:,1};
time_60 = packetsize_p60{:,2};
delta_60 = packetsize_p60{:,3};
packetsize_60 = packetsize_p60{:,4};
%ploting time to check it obeys possion process rules
figure, plot(time_60)
title('Time series of packetsize 60')
figure, plot(delta_60)
%b1=[-1,1];
%diffT60=conv(time_60,b1,'valid');
%figure, plot(diffT60)
t60=find(delta_60<=0);
delta_60(t60)=1;
%packetsize_pT60=packetsize_60(2:end);
transT60=packetsize_60./delta_60;
mu_trans60=mean(transT60); %rate in MBps
var_trans60=var(transT60);
figure,bar(transT60,'k'),
title('Traffic rate (packet size 60 rate)')
xlabel('micro s')
ylabel('Traffic rate')

% now creating a table having packetSize 1514
packetsize_p1514 = Trafficcsv(Trafficcsv.Size==1514,1:4);
packetnum_1514 = packetsize_p1514{:,1};
time_1514 = packetsize_p1514{:,2};
delta_1514 = packetsize_p1514{:,3};
packetsize_1514 = packetsize_p1514{:,4};
figure, plot(time_1514)
title('Time series of packetsize 1514')
figure, plot(delta_1514)
%b2=[-1,1];
%diffT1514=conv(time_1514,b2,'valid');
%figure, plot(diffT1514)
t1514=find(delta_1514<=0);
delta_1514(t1514)=1;
%packetsize_pT1514=packetsize_1514(2:end);
transT1514=packetsize_1514./delta_1514;
mu_trans1514=mean(transT1514); %rate in MBps
var_trans1514=var(transT1514);
figure,bar(transT1514,'k'),
title('Traffic rate (packet size 1514 rate)')
xlabel('micro s')
ylabel('Traffic rate')

