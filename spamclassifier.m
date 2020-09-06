% We will use support vector machines to 
% build a spam classifer. 
% I will train a classifier to classify whether 
% a given email is spam (which we will call y = 1) 
% or not spam (which we will call y = 0). 
% I will adapt my spam classifier from 
% the second part of the sixth exercise 
% from Andrew Ng’s Machine Learning Course on Coursera.

% Preprocess emails

%Read the sample file and process
file_contents = readFile('emailSample1.txt');
word_indices  = processEmail(file_contents);

% Extract Features
features = emailFeatures(word_indices);

% Print Stats
fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));

% Load the Spam Email dataset
load('spamTrain.mat');
C = 0.1;

% Train SVM with linear kernel
[mdl,FitInfo] = fitclinear(X,y)

% Accuracy of training set
p = predict(mdl, X); 
fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

% Load the test dataset
load('spamTest.mat');

% Accuracy of test set
p = predict(mdl, Xtest); 
fprintf('Test Accuracy: %f\n', mean(double(p == ytest)) * 100);


% Use the SVM to classify emails
% Add your own email text file name here
eml = 'emailSample1.txt';
file_contents = readFile(eml);
word_indices = processEmail(file_contents);

features = emailFeatures(word_indices);
if predict(mdl,features')==1
    disp('This email is probably spam.')
else
    disp('This email is probably not spam.')
end




