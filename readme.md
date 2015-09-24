##readme.md file for run_analysis.R

This script makes use of data files from the Human Activity Recognition Using Smartphones Dataset, version 1.0 (Anguita et al. 2012) available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The script returns a tidy data set (tidy_data.txt) that includes the average value for each subject*activity combination for every variable retained.

#Specific files needed to run the script:
activity_labels.txt,features.txt,subject_test.txt,subject_train.txt,X_test.txt,X_train.txt,y_test.txt,y_train.txt

#Rationale underpinning inclusion/exclusion of variables
Variable names from features.txt were searched using grep(), and all variables ending in -mean() or -std() (with or without a dimensional suffix) were retained. Note that, in line with this rationale, variables ending in meanFreq() were not included. All other variables were not included in our analysis.

#Script mechanics
run_analysis.R combines test and training data (subject, activity, and response variables) from the source dataset, and names all the retained columns with the variable names supplied by the authors of the dataset (found in features.txt). Numeric activity codes are replaced with their textual description supplied by the authors of the dataset (found in activity_labels.txt). The script then calculates and returns the average value for each subject in each activity, and saves this reduced dataset as a .txt file.

##Literature cited
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012