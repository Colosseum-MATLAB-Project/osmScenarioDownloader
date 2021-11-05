% Project Name: Open Street Map (OSM) outdoor scenario downloader demo
%               
% File Name: osmDownloaderDemo.m
%
% Author: Miead Tehrani-Moayyed
% Work address: Wireless Networks and System Lab  
% Northeastern University, 360 Huntington Ave. Boston, MA 02115
% email: tehranimoayyed.m@northeastern.edu
% Last revision: 1-Nov-2021
%
% This file demonstrate the function of osmDownloader.m through two
% scenarios including an urban scenario, Northeastern University campus and
% a dense urban scenario, Downtown Boston. 
% The scenarios will be downloaded in the local storage and visualize
% through site viewer
%
% ------------- BEGIN CODE --------------

% Northeastern campus scenario, urban scenario
osmDownloader('Latitude', 42.34025,...
              'Longitude', -71.08848,...
              'Range',500,...
              'osmFileName', 'NUcampus.osm')

viewer1 = siteviewer('Buildings','NUcampus.osm','Basemap','satellite');

% Downtown Boston scenario, dense urban scenario
osmDownloader('Latitude', 42.356562,...
              'Longitude', -71.05592,...
              'Range',500,...
              'osmFileName', 'downtownBoston.osm')

viewer2 = siteviewer('Buildings','downtownBoston.osm','Basemap','satellite');

% Town of Mt Washington, rural scenario
osmDownloader('Latitude', 42.091927,...
              'Longitude', -73.454912,...
              'Range',500,...
              'osmFileName', 'TownOfMtWashington.osm')

viewer3 = siteviewer('Buildings','TownOfMtWashington.osm','Basemap','topographic');