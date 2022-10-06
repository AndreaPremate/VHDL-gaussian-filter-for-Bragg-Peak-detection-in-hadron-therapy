clear all;
close all;
clc;

%% caricamento immagine ritagliata in scala di grigi
DIM = 256;
im = imread('image.png');
im = im2gray(im);
im = im(29:726 ,82:779);
im= imresize(im, [DIM DIM]);
figure(1), imshow(im);

%% aggiunta di rumore gaussiano
noise = uint8(100*randn(DIM, DIM));  
im = im + noise;
figure(2), imshow(im);

% print per esportazione in vhdl
fprintf('(');
for ii = 1:DIM
    fprintf('(');
    for jj = 1:DIM
        binVal = dec2bin(im(ii,jj),8);
        fprintf('"%s"',binVal);
        if jj ~= DIM
            fprintf(',');
        end
    end
    fprintf(')');
    if ii ~= DIM
        fprintf(',\n');
    end
end
fprintf(')');
%% filtro gaussiano
GaussianMask = fspecial('gaussian', [5 5], 5)   
imfil = imfilter(im, GaussianMask);
figure(3), imshow(imfil);

%% binarizzazione
imbw = imbinarize(imfil, 0.5);     
figure(4), imshow(imbw);

imbwnofilt = imbinarize(im, 0.5);
figure(5), imshow(imbwnofilt);

%% plus: estrazione componente connessa maggiore
% biggest = bwareafilt(imbw,1,'largest');
% figure(5), imshow(biggest);
% imbw = biggest;  % per calcolo valori di interesse solo su largest conn comp
                   
%% estrazione valori di interesse
BraggPeak = max(max(imfil));
[x,y] = find(imfil==BraggPeak, 1);    % riga e colonna del picco

max_width = max(sum(imbw, 2));   % larghezza
max_height = max(sum(imbw, 1));  % altezza

%% valori senza aggiunta di rumore
BraggPeak2 = max(max(im));
[x2,y2] = find(im==BraggPeak, 1);    % riga e colonna del picco

max_width2 = max(sum(imbwnofilt, 2));   % larghezza
max_height2 = max(sum(imbwnofilt, 1));  % altezza
