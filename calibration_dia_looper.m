%clear workspace and command window, close all figures
clear; clc; close all
threshold = 0.25; %value for binarizing images
%PixelFilter = 100; %for cleaning up images, removes spots less than 100 pixels
Folder = uigetdir; %opens up the folder selection dialogue box and you select which folder
Folder = strcat(Folder, '/'); %add a '/'
filelist = dir(fullfile(Folder, '*_dia*.tif')); %get all .tif file names in video folder
%Resolution = zeros(length(filelist),1);
Pixels = zeros(length(filelist),1);
%loop through all files in Folder
for j=1:length(filelist)
    FileName = filelist(j).name; %isolate file name only
    File = strcat(Folder,FileName); %construct the full path for each file
    Pixels(j) = calibration_dia(File,threshold);
    close all
end