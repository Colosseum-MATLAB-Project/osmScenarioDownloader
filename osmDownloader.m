function osmDownloader(varargin)
% Project Name: Open Street Map (OSM) outdoor scenario downloader 
%               
% File Name: osmDownloader.m
%
% Author: Miead Tehrani-Moayyed
% Work address: Wireless Networks and System Lab  
% Northeastern University, 360 Huntington Ave. Boston, MA 02115
% email: tehranimoayyed.m@northeastern.edu
% Last revision: 1-Nov-2021
%
% osmDownloader Download Open Street Map as an osm file
%
% This function export an osm map from openstreetmap.org website and save it in
% your local storage to create RF scenarios for wireless propagation prediction
%
% Properties:
%   Latitude    - Scenario origin latitude coordinates
%   Longitude   - Scenario origin longitude coordinates
%   Range       - Scenario range from the origin in meters
%   osmFileName - the file name for saving the osm file
%
%   % Example
%
%   % Example 1: Northeastern University campus, an urban scenario
%   osmDownloader('Latitude', 42.34025,...
%             'Longitude', -71.08848,...
%             'Range',1000,...
%             'osmFileName', 'NUcampus.osm')
%
%   viewer = siteviewer('Buildings','NUcampus.osm','Basemap','satellite');
%
%   % Example 2: Downtown Boston, a dense urban scenario
%   osmDownloader('Latitude', 42.356562,...
%              'Longitude', -71.05592,...
%              'Range',500,...
%              'osmFileName', 'downtownBoston.osm')
%
%   viewer = siteviewer('Buildings','downtownBoston.osm','Basemap','satellite');
%
% ------------- BEGIN CODE --------------

p = inputParser;
validScalarNum = @(x) isnumeric(x) && isscalar(x);
validScalarPosNum = @(x) isnumeric(x) && isscalar(x) && (x > 0);
addOptional(p,'Latitude', 42.34025, validScalarNum)  % NU campus location as default
addOptional(p,'Longitude', -71.08848, validScalarNum)   
addOptional(p,'Range',500, validScalarPosNum)          % 500 meters range as default
addParameter(p,'osmFileName', 'scenario.osm', @ischar)

parse(p,varargin{:});

scenarioLat = p.Results.Latitude;
scenarioLon = p.Results.Longitude;
range = p.Results.Range;
scenarioFileName = p.Results.osmFileName;

% Convert input distance to earth degrees (Lat, Lon are given in degrees)
distUnits = 'm';
arclen = rad2deg(range/earthRadius(distUnits));
[lat1,~] = reckon(scenarioLat, scenarioLon,arclen,0);
[lat2,~] = reckon(scenarioLat, scenarioLon,arclen,180);
[~,lon1] = reckon(scenarioLat, scenarioLon,arclen,90);
[~,lon2] = reckon(scenarioLat, scenarioLon,arclen,270);

url = sprintf('https://www.openstreetmap.org/api/0.6/map?bbox=%0.4f%%2C%0.4f%%2C%0.4f%%2C%0.4f',lon2,lat2,lon1,lat1);
urlwrite(url,scenarioFileName);
end
