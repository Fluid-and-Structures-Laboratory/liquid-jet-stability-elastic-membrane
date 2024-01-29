function Pixels = calibration_dia(File,threshold)

%info = imfinfo(File); %gather info of video (.tif) file
%num_images = numel(info); %number of pictures in multi-tif file
% Selects the first image to filter the background and detects the position of the chip
image=imread(File,1); %Reads the first frame image

blackandwhite=imbinarize(image,'adaptive','ForegroundPolarity','dark','Sensitivity',threshold); % Convert Image to black and white
blackandwhite = blackandwhite(:,:,1); %isolate only first layer of 3D matrix
% edgeimage=edge(blackandwhite,'Canny'); %find edge of the white regions
% filteredimage=bwareaopen(edgeimage,PixelFilter); % Reduce noise in the image

imshow(blackandwhite); title('Black and White')
% imshow(filteredimage) ; title('Filtered')

[~, Cols] = size(blackandwhite); %get image size
res = zeros(2,650);
pixel=zeros(1,650);
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
