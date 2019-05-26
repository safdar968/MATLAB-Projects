close all
clear all
clc

% these lines are for world map
latlim = [23.6 23.68]; % latitude limits
lonlim = [58.13 58.25]; % longitude limits
worldmap(latlim,lonlim)

% these lines for geoshow
fprintf('Loading Map of Oman ......');

% loading these 2 files here which actully load 4 files
LandArea=geoshow('OMN_adm1.shp');
RoadNetwork=geoshow('oman_highway.shp');

% now our boundaries
lat = [23.669343,23.627181,23.603746,23.622149,23.669343];
lon = [58.169617, 58.238348,58.205730,58.175517,58.169617];

% for boundary we need a line
Data=geoshow(lat,lon,'displaytype','line');
set(Data,'color',[0 0.8 0],'linewidth',1)

%% plot of Dispatching Hub
d_lat = 23.638638;
d_lon = 58.203335;
hub_Data=geoshow(d_lat,d_lon,'displaytype','point');
set(hub_Data,'color',[0 1 0],'Marker','o','MarkerSize',6, 'MarkerFaceColor',[1,0,0.5])
hold on % mean we are  still plotting on same plot

%% plot of customer locations
c_lat = [23.626776, 23.620957, 23.651618];
c_lon = [58.220088, 58.190391, 58.194428];
labels = ["point1","point2","point3"]; % names

% for customer i used different method
% because we needed text on plot

% this line puts a mini triangle at 3 points
plotm(c_lat,c_lon,'^','MarkerSize',3,'LineWidth',1,'MarkerEdgeColor',[1,0,0])

% this line puts test at three points
textm(c_lat(),c_lon,labels)
hold off % we finished plotting


% hub location
p1 = [d_lat, d_lon];

%loop over all customer points
for i=1:length(c_lat)
    % Find distance between two points by drone
    fprintf('\n\n######################################################\n')
    fprintf('calculations for customer#%d and Hub', i)
    p2 = [c_lat(i),c_lon(i)];
    
    dist_by_drone = drondist(p1, p2);
    speed = 65; % Km/h
    time_by_drone = dist_by_drone / speed * 60;
    fprintf('\nDistance by Drone: %.3f km\n',dist_by_drone)
    fprintf('Driving Time by Drone: %.3f minutes\n',time_by_drone)

    % Find distance between two points by car

    dist_by_car = drivedist(p1,p2);
    speed = 35; % Km/h
    time_by_car = dist_by_car / speed * 60;
    fprintf('\nDistance by Car: %.3f km\n',dist_by_car)
    fprintf('Driving Time by Car: %.3f  minutes\n',time_by_car)
end
