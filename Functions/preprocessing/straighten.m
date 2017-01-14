function [ out ] = straighten( in )
%STRAIGHTEN Slant correction is performed on input digit.
% uses variance and covariance of x and y axes to evaluate slant

moments = im_moments(in, 'central');

% properties of im_moments
variance_x = moments(1);
variance_y = moments(3);
covariance_xy = moments(2);

% computes the orientation of the object (angle of the eigenvetor
% associated with the largest eigenvalue towars the axis closest to this
% eigenvector
theta = 1/2 * atan( 2*covariance_xy / (variance_x - variance_y));

% define the rotation opposite to that angle
tform = maketform('affine', [1 0 0; sin(0.5*pi-theta) cos(0.5*pi-theta) 0; 0 0 1]);

temp = imtransform(in, tform);

out = temp;
end

