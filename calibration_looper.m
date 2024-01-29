%clear workspace and command window, close all figures
clear; clc; close all
threshold = 0.4; %value for binarizing images
reference_size = 34;
%PixelFilter = 100; %for cleaning up images, removes spots less than 100 pixels
Folder = uigetdir; %opens up the folder selection dialogue box and you select which folder
Folder = strcat(Folder, '/'); %add a '/'
filelist = dir(fullfile(Folder, '*top*.tif')); %get all .tif file names in video folder
Resolution = zeros(length(filelist),1);
Pixels = zeros(length(filelist),1);
%loop through all files in Folder
for j=1:length(filelist)
    FileName = filelist(j).name; %isolate file name only
    File = strcat(Folder,FileName); %construct the full path for each file
    [Pixels(j), Resolution(j)] = calibration(File,threshold,reference_size);
    close all
end