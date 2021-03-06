% amount of training digits per class
training_size = 600;
% amount of test digits per class
test_size = 400;
% image size
d_size = 50;

prwaitbar off;

%% Pipeline
tic

%% Preprocessing
% preprocess training and test sets and flatten the cell arrays
% create corresponding label cell arrays
[training, training_labels] = preprocess(prnist(0:9,1:training_size), d_size);
training_size = size(training_labels,1)/10;

% Test from leftover main testset
[test, test_labels] = preprocess(prnist(0:9, training_size+1:training_size+test_size), d_size);
test_size = size(test_labels,1)/10;

%% Feature Extraction
% extract HOG features for both training and test sets
training_hog = hog(training);
test_hog = hog(test);

%% Training
% build classifier with SVM for HOG feature
% classifier_hog = fitcecoc(training_hog, training_labels);
% build classifier with knn
 classifier_hog = fitcknn(training_hog, training_labels);
% build classifier with logistic regression
% classifier_hog = mnrfit(training_hog, training_labels);
toc

%% Testing
% make class predictions using the test HOG features
predicted_labels_hog = predict(classifier_hog, test_hog);

%% display results for hog
confusion_matrix_hog = confusionmat(test_labels, predicted_labels_hog);
helperDisplayConfusionMatrix(confusion_matrix_hog);

preditcted_strings_hog = cellstr(predicted_labels_hog);

test_strings = cellstr(test_labels);
true_hog = sum(strcmp(test_strings,preditcted_strings_hog));
false_hog = test_size*10 - true_hog;

disp(fprintf( 'Total hog %d, correct: %d, err: %d\n, accuracy: %d\n', test_size*10, true_hog, false_hog, (true_hog/test_size*10)));

%% shows every half a second the digit that got classified wrong.
% for i = 1:test_size*10
%     if(strcmp(test_labels(i, :), predicted_labels(i, :)) == 0)
%         imshow(test(:,:,i));
%         title(predicted_labels(i, :));
%         pause(0.5);
%     end
% end

%% handwritten
% test with handwritting data
% [test, test_labels] = hand_writing_image_seperation(50);

% Training on handwritten 
% [test, test_labels] = preprocess(prnist(0:9,1:test_size), d_size);
% training = handTraining;
% training_labels = handLabels;
% training_size = size(training_labels,1)/10;

%% Test handwritten vs handwritten random selection
%r = randperm(250,50);
%x = [1:250];
%rn = setdiff(x,r);
%training = handTraining(:,:,r);
%training_labels = handLabels(r,:);
%test = handTraining(:,:,rn);
%test_labels = handLabels(rn,:);

%training_size = size(training_labels,1)/10;
%test_size = size(test_labels,1)/10;

%% get results for getSymmetry
%extract pixels features for both training and test sets
%training_getSymmetry = getSymmetry(training);
%test_getSymmetry = getSymmetry(test);

% build classifier with SVM for getSymmetry feature
% classifier_getSymmetry = fitcecoc(training_getSymmetry, training_labels);

%predicted_labels_getSymmetry=predict(classifier_getSymmetry, test_getSymmetry);

%confusion_matrix_getSymmetry = confusionmat(test_labels, predicted_labels_getSymmetry);
%helperDisplayConfusionMatrix(confusion_matrix_getSymmetry);

%preditcted_strings_getSymmetry = cellstr(predicted_labels_getSymmetry);
%true_getSymmetry = sum(strcmp(test_strings,preditcted_strings_getSymmetry));
%false_getSymmetry = test_size*10 - true_getSymmetry;

%disp(fprintf( 'Total getSymmetry %d, correct: %d, err: %d\n', test_size*10, true_getSymmetry, false_getSymmetry));