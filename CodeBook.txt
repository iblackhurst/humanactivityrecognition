Code Book for Cleaning the Human Activity Using Smartphones Data Sets
========

The variables in the data set created from this script are created using a subset of the
variables available in the UCI Machine Learning Repository Human Activity Recognition
data set. 

The data for both the training and test sets were combined into one data set. The focus of this
analysis were the features measuring the means and standard deviations. The appropriate activity
names were attached to each observation (e.g. walking, walking upstairs, etc.), and the variables
were appropriately labeled as well.

The final data set created takes each combination of subject and activity, and then averages the
relevant features for that combination. As there are six activities, and 30 subjects, there are 
180 observations in the data set. Each variable is the average of either a mean or standard
deviation measurement for all the experiments for a particular subject and activity combination.

For more information, see the following source.

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain 
Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on 
Artificial Neural Networks, Computational Intelligence and Machine Learning, 
ESANN 2013. Bruges, Belgium 24-26 April 2013.