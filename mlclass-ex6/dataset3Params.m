function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and
%   sigma. You should complete this function to return the optimal C and
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example,
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using
%        mean(double(predictions ~= yval))
%


test_parameters = [0.01, 0.03, 0.1, 0.3, 1.0, 3.0, 10.0, 30.0];

x1 = X(:, 1);
x2 = X(:, 2);

test_results = [];

for test_C=test_parameters
  for test_sigma=test_parameters
    model = svmTrain(X, y, test_C, @(x1, x2) gaussianKernel(x1, x2, test_sigma));
    predictions = svmPredict(model, Xval);
    computed_error = mean(double(predictions ~= yval));
    test_results = [test_results; test_C, test_sigma, computed_error];
  end
end

[best_result, best_result_index] = min(test_results(:, 3));
best_result = test_results(best_result_index, :);
C = best_result(1);
sigma = best_result(2);



% =========================================================================

end
