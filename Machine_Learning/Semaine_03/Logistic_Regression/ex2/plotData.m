function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%
% find indexes where y is equal to 0 or y equal to 1
y0 = (y==0);
y1 = (y ==1);

plot(X(y1,1),X(y1,2),'k+',"markerfacecolor","b","MarkerSize",8)
plot(X(y0,1),X(y0,2),'ko',"markerfacecolor","y","MarkerSize",8)


% =========================================================================



hold off;

end
