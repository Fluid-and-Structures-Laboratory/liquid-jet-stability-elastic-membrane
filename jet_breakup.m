function [breakup_length, mean_breakup, stdv_breakup, percent_discard, t] = jet_breakup(File, threshold)

% info = imfinfo(File); %gather info of video (.tif) file
%num_images = numel(info); %number of pictures in multi-tif file
num_images = 500;
breakup_length = zeros(500,1);

for jj = 1:500
    [image, cmap] =imread(File,jj); %Reads the first frame image

    blackandwhite=imbinarize(image,'adaptive','ForegroundPolarity','dark','Sensitivity',threshold); % Convert Image to black and white
    blackandwhite = blackandwhite(:,:,1); %isolate only first layer of 3D matrix
    blackandwhite = ~blackandwhite;
    % edgeimage=edge(blackandwhite,'Canny'); %find edge of the white regions
    % filteredimage=bwareaopen(edgeimage,PixelFilter); % Reduce noise in the image

    %imshow(blackandwhite); title('Black and White')
    % imshow(filteredimage) ; title('Filtered')
    % 
    [Rows, Col ] = size(blackandwhite); %get image size
    
    for ii = 1:Col
        if sum(blackandwhite(:, ii))==0
            breakup_length(jj) = ii;
            break
        end
    end
    X = breakup_length(jj)*ones(1,Rows);
    Y = (1:Rows);
    figure(1)
    imshow(image,cmap)
    hold on
    plot(X,Y, ':', 'LineWidth',2,'MarkerSize',20, 'Color', 'red')
    hold off
    F(jj) = getframe(gcf);
    drawnow
    
%     figure(2)
%     imshow(transpose(image))
%     hold on
%     plot(breakup_length(jj)*ones(1, Col),(1:Col),'o','r')
%     hold off
%     G(jj) = getframe(gcf);
%     drawnow
    
end
t = linspace(0,num_images/8000,num_images);
breakup_length = breakup_length(breakup_length~=0);
t = t(breakup_length~=0);
mean_breakup = mean(breakup_length);
stdv_breakup = std(breakup_length);
percent_discard = (1-(length(breakup_length))/num_images)*100;

writerObj = VideoWriter('C:\Users\Emazuddin Alif\OneDrive - University of Tennessee\Research-LAPTOP-OPTCM86V\Jet stability\Experiment videos\20A\real_img_w_breakup.avi');
writerObj.FrameRate = 100;

open(writerObj);
for i = 1:length(F)
    frame = F(i);
    writeVideo(writerObj, frame);
end

close(writerObj);
% plot(t,transpose(breakup_length))
% grid on
% title('Video 5')
% xlabel('Time, t [s]')
% ylabel('Breakup length, z [pixels]')
