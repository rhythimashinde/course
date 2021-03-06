%% k(10) fold validation data split
d_size=50;
true_hog=0;
true_hog_average=0;
accuracy=zeros(1,10);
d='svc'; %classifier
r=randperm(1000); 
rn=num2cell(reshape(r, 100, 10), 1);

for i=1:10
  rx=cell2mat(rn(i));
  [training, training_labels] = preprocess(prnist(0:9,rx), d_size); 
  [test, test_labels] = preprocess(prnist(0:9,setdiff(1:1000,rx)), d_size); 
  training_size = size(training_labels,1)/10;
  test_size = size(test_labels,1)/10;

    % Feature Extraction
    % extract HOG features for both training and test sets
    training_hog = hog(training);
    test_hog = hog(test);

    % Training
    % build classifier for HOG feature
     classifier_hog = classifier(d,training_hog, training_labels);
    
    toc

    % Testing
    % make class predictions using the test HOG features
     predicted_labels_hog = predict(classifier_hog, test_hog);
     
    % calculate and/or display results
     confusion_matrix_hog = confusionmat(test_labels, predicted_labels_hog);
    % helperDisplayConfusionMatrix(confusion_matrix_hog);
     
     preditcted_strings_hog = cellstr(predicted_labels_hog);
    
     test_strings = cellstr(test_labels);
     true_hog_prev = true_hog;
     
     true_hog = sum(strcmp(test_strings,preditcted_strings_hog));
     false_hog = test_size*10 - true_hog;
     e=true_hog/test_size*10;
     
     true_hog_average = true_hog_average + true_hog_prev;
     
     %get the accuracy for each test run
     accuracy(i)=true_hog/test_size;
     
     %print full results
     %disp(fprintf( 'Total %d, correct: %d, err: %d\n, accuracy: %d\n', test_size*10, true_hog, false_hog, e));
     
end

%get the average accuracy of all runs
%average_accuray= true_hog_average/test_size
