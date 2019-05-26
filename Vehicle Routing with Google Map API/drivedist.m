function d = drivedist(latlon1,latlon2)
% Google Maps API requires building a URL with approriate search terms
base_url = 'https://maps.googleapis.com/maps/api/directions/json?';
% Add starting location (lat1/lon1) to URL
origin = [num2str(latlon1(1)) ',' num2str(latlon1(2))];
base_url = [base_url 'origin=' origin '&destination='];
% Last part of the URL is your personal key. For security, saved this in a
% text file. 
keystr = ['&key=' fileread('my_key.txt')];


% Add destination to URL. Finish URL with key
destination = [num2str(latlon2(1)) ',' num2str(latlon2(2))];

% this is complete
myurl = [base_url destination keystr]
% Send request to Google Maps and unpack the json file returned
dists = jsondecode(urlread(myurl));
% Was the query successfully completed?
if isequal(dists.status,'OK')
    % Yes. Good. Extract the distance value (which is in meters) and
    % convert to km
    % the value is in meter so converted it on Km
    d = dists.routes(1).legs(1).distance.value/1000;
else
    % Nope. If it's a random glitch, let's just make that one value
    % something -ve and hope for the best
    d = -1;
end
end
