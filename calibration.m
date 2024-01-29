function [Pixels, Resolution] = calibration(File,threshold,reference_size)

% This function calibrates the pixel images to physical units (here, mm)

%info = imfinfo(File); %gather info of video (.tif) file
%num_images = numel(info); %number of pictures in multi-tif file

% Selects the first image to filter the background and detects the position of the chip
image=imread(File,1); %Reads the first frame image

% Convert Image to black and white
blackandwhite=imbinarize(image,'adaptive','ForegroundPolarity','dark','Sensitivity',threshold); 
%isolate only first layer of 3D matrix
blackandwhite = blackandwhite(:,:,1); 

% edgeimage=edge(blackandwhite,'Canny'); %find edge of the white regions
% filteredimage=bwareaopen(edgeimage,PixelFilter); % Reduce noise in the image

imshow(blackandwhite); title('Black and White')
% imshow(filteredimage) ; title('Filtered')

%get image size
[~,Cols] = size(blackandwhite); 
% Initialize variables for starting nd ending edge of the relaxation chamber flange
res = [0 0];

%1st For loop looking for the leftmost edge of the flange
for ii = 1:Cols
    if blackandwhite(5,ii) == 0
        res(1) = ii;
        break
    end
end

%2nd For loop looking for the right most edge of the flange
for ii = fliplr(1:Cols)
    if blackandwhite(5,ii) == 0
        res(2) = ii;
        break
    end
end

% reference_size = 59.563 for old relaxation chamber
%reference_size = 34 mm  for new relaxation chamber
Resolution = (reference_size/(res(2)-res(1)+1)); %mm/pixel   
Pixels = res(2)-res(1)+1;
