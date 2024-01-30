function Pixels = calibration_dia(File,threshold)

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
[~, Cols] = size(blackandwhite);

%Initialize range where the jet diameter is measured
res = zeros(2,650);
pixel=zeros(1,650);

%This image is vertically oriented here
%This chunk sorts through the following rows and parse through to find edges of the diameter of the jet
%We start from row 151 to avoid capturing the relaxation chamber flange
for jj = 151:800
    for ii = 1:Cols
        if blackandwhite(jj,ii) == 0
            res(1,jj-150) = ii;
            break
        end
    end
    for ii = fliplr(1:Cols)
        if blackandwhite(jj,ii) == 0
            res(2,jj-150) = ii;
            break
        end
    end
    pixel(jj-150) = res(2,jj-150)-res(1,jj-150)+1;    
end
% Resolution = (59.563/(res(2)-res(1)+1)); %mm/pixel
pixel1 = pixel;
pixel = pixel(pixel>9);
pixel1(pixel1<=9) = min(pixel);
Pixels = mean(pixel1);
