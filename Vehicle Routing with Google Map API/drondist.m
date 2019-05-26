function d1km=drondist(latlon1,latlon2)

% --Inputs:
%   latlon1: latlon of origin point [lat lon]
%   latlon2: latlon of destination point [lat lon]
%
% --Outputs:
%   d1km: distance calculated by Haversine formula
%   d2km: distance calculated based on Pythagoran theorem
%
%--------------------------------------------------------------------------
radius=6371; % radius of earht

% converion to radians
lat1=latlon1(1)*pi/180;
lat2=latlon2(1)*pi/180;
lon1=latlon1(2)*pi/180;
lon2=latlon2(2)*pi/180;

deltaLat=lat2-lat1;
deltaLon=lon2-lon1;

a=sin((deltaLat)/2)^2 + cos(lat1)*cos(lat2) * sin(deltaLon/2)^2;
c=2*atan2(sqrt(a),sqrt(1-a));
d1km=radius*c;    %Haversine distance

% drone vertical height part 
d1km = d1km + (0.025*2); % adding drone vertical height of 25m

% removed this
% x=deltaLon*cos((lat1+lat2)/2);
% y=deltaLat;
% d2km=radius*sqrt(x*x + y*y); %Pythagoran distance
% d2km = d2km + (0.025*2); % adding drone vertical height of 25m
end