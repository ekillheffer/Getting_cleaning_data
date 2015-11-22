# Getting_cleaning_data

This repo completes course project 2 for Getting and Cleaning Data Coursera course. See codebook.md for further detail

#  The script run_analysis.R completes the following 5 steps:

1. Reads the test group data, the training group data, the activity list, and the subject data files
2. Combines the test and training groups into one data set
3. Cleans and and labels features (measurements), and selects only those related to mean and standard deviation
4. Labels the activities and assigns names to activities in data set
5. Creates a tidy dataset with average of measurements for each subject/activity combination

#  Transformations performed in code:

- train and test data is merged with rbind
- train and test labels are merged with rbind
- train and test subject data are merged with rbind
- mean and std columns are extracted by searching for those labels in measurement names
- labels are cleaned and applied, so variables are in the following format:
      "tbodyaccmeanx" 
      "tbodyaccmeany" 
      "tbodyaccmeanz" 
      "tbodyaccstdx"  
      "tbodyaccstdy"  
      "tbodyaccstdz" 
- averages by subject and activity are calculated using group_by and summarize_each functions from dplyr package
