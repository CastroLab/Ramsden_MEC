function histogram = computeHistogramFromImage(vocabulary,im)
% COMPUTEHISTOGRAMFROMIMAGE Compute histogram of visual words for an image
%   HISTOGRAM = COMPUTEHISTOGRAMFROMIMAGE(VOCABULARY,IM) compute the
%   histogram of visual words for image IM given the visual word
%   vocaublary VOCABULARY. To do so the function calls in sequence
%   COMPUTEFEATURES(), QUANTIZEFEATURES(), and COMPUTEHISTOGRAM().
%
%   See also: COMPUTEVOCABULARYFROMIMAGELIST().

% Author: Andrea Vedaldi


if isstr(im)
  if exist(im, 'file')
    fullPath = im ;
  else
    fullPath = fullfile('data','images',[im '.jpg']) ;
  end
  im = imread(im) ;
  im = imageprocessing(im);
  
end

% Extract histograms using SIFT/PHOW features
width = size(im,2) ;
height= size(im,1) ;
[keypoints, descriptors] = computeFeatures(im) ;
words = quantizeDescriptors(vocabulary, descriptors) ;
histogram = computeHistogram(width, height, keypoints, words) ;

% Extracts histograms based on local binary patterns
% F = vl_lbp(im, 3) ;
% histogram = permute(F,[3 1 2]);
% histogram = reshape(histogram,[],1,1);