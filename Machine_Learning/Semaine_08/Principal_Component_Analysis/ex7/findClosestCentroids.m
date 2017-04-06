function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

fprintf("size of X : %d %d\n", size(X,1),size(X,2));

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

for i = 1:size(X,1)
	% Initialize square of distance between i-th observation and centroid 1
	dist = (X(i,:)-centroids(1,:))*(X(i,:)-centroids(1,:))';
	idx(i)=1;
	for j = 2:K
		dist1 = (X(i,:)-centroids(j,:))*(X(i,:)-centroids(j,:))';
		% fprintf("i,j, dist, dist1 : %d %d %f %f\n", i,j,dist,dist1);
		if dist1 < dist 
			idx(i) = j;
			dist = dist1;
		end
	end

end






% =============================================================

end

