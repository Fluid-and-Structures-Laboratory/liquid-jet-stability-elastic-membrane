%clear workspace and command window, close all figures
clear; clc; close all

threshold = 0.55; %value for binarizing images
PixelFilter = 10; %for cleaning up images, removes spots less than 100 pixels

Folder = uigetdir; %opens up the folder selection dialogue box and you select which folder
Folder = strcat(Folder, '/'); %add a '/'
filelist = dir(fullfile(Folder, '*.tif')); %get all .tif file names in video folder
mean_breakup = zeros(length(filelist),1);
breakup_stdv = zeros(length(filelist),1);
percent_discard = zeros(length(filelist),1);
for jj=1:length(filelist)
    FileName = filelist(jj).name; %isolate file name only
    File = strcat(Folder,FileName); %construct the full path for each file
    
    %Call breakup analyzer
    [breakup_length, mean_breakup(jj), breakup_stdv(jj), percent_discard(jj), t] = jet_breakup(File, threshold);
%     save(string(jj),'breakup_length','t')
%     Fs = 8000;
%     T = 1/Fs;
%     L = length(breakup_length);
%     Y = fft(breakup_length);
%     P2 = abs(Y/L);
%     P1 = P2(1:L/2+1);
%     P1(2:end-1) = 2*P1(2:end-1);
%     f = Fs*(0:(L/2))/L;
%     graph_title = strcat('Single-Sided Amplitude Spectrum of',FileName);
%     subplot(2,1,1)
%     plot(t,transpose(breakup_length))
%     grid on
%     title(FileName)
%     xlabel('Time, t [s]')
%     ylabel('Breakup length, z [pixels]')
%     subplot(2,1,2)
%     plot(f,P1) 
%     title(graph_title)
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')

end
%save('BeCu.mat')
