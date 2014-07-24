pmccullo Cousera Getting & Cleaning Data - Final Project
============================
I did everything in this effort to ensure that I get as much credit as I can for this project. All decisions that I made were to follow the instructions of the class as closely as I could. 

HERE IS A ROUGH OUTLINE OF THIS README:

1. INSTRUCTIONS FROM PROFESSORS
2. WALK THROUGH OF MY CODE
3. CODE BOOK

## 1. INSTRUCTIONS FROM THE PROFESSORS
The following instructions were provided by the professors:
Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


1. You should create one R script called run_analysis.R that does the following. 
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

-------
## 2. WALK THROUGH OF MY CODE

The following steps that I took are either outside of the code or are in the begining of my run_analysis.R code, but are commented out (Steps 1-2 in the code)

1. Download data to working directory using download.file()
2. Unzip using unzip()
3. Thoroughly read through README.txt to understand data structure (not in code)
4. The main Test & Training data have observations with 561 measurements, column headers for hte measurements can be found in the features.txt file (good background in the features_Info.txt as well)

------

The run_analysis.R code has comments throughout and here is additional information to help the reader understand, starting with step 3 (1&2 are described in the previous section):

3a
- 3aUse rbind to combine primary test and training data sets together
- In the problem statement, we are asked to extract Mean and Standard Deviation measurements for the 33 unique features (which are desribed in the two feature related .txt files in the zipped data)

3b
- I manually extracted the columns that had the Mean and STD values using a simple excel lookup (sorry!), these columns are the 'vectorcolumns' variable in the code

3c
- i used rbind to create a master data label set and then cbind to append the activity labels to the actual data
- the ordered() function was used to convert the numeric activity labels into the more meaningful text descriptions
- the column labels were pulled straight from the underlying data, I didn't have time to make them more meaningful to an end user. 

This ended problems 1 through 4

--------

The final step was to solve for the averages of all of the measurements that we were asked to retrieve by the unique combinations of Subject (the person in the test) and Activity

There should be 180 observations for this data set as there are 30 subjects and 6 activities

In the code, starting with #4a

- I needed to add the subjects into the primary dataset, as we had not done that before
- I used cbind and rbind to do this again

4b - goal was to isolate all unique combinations of subject and activity

- I used mutate to create a combined column of Subject & Activity
- I converted to a data.table and used lapply to calculate the mean of the measurement columns by unique of my new concated_column

4c - I took off the front column because it was ugly and repeated information from the next two columns

4d - I had to reconvert the activity numbers to the names as I lost them in the data.table conversion

4e - I wrote my final tidydata set to a .txt file so I could submit per the class instructions

## 3. CODE BOOK
Most information can be found in the README.txt in the downloaded zip files as well as the features_info.txt

Here is some information borrowed from the latter, we were asked to find the averages of the Means and Standard Deviations for all unique combinations of subject and activity:

----
Feature Selection


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

That is the end of the borrowed information 
-----

Here is a summary of the final parameters of the tidydata set that I created: 

Subject                Activity_Name tBodyAcc.mean...X tBodyAcc.mean...Y  
 Min.   : 1.0   LAYING            :30    Min.   :0.2216    Min.   :-0.040514  
 1st Qu.: 8.0   SITTING           :30    1st Qu.:0.2712    1st Qu.:-0.020022  
 Median :15.5   STANDING          :30    Median :0.2770    Median :-0.017262  
 Mean   :15.5   WALKING           :30    Mean   :0.2743    Mean   :-0.017876  
 3rd Qu.:23.0   WALKING_DOWNSTAIRS:30    3rd Qu.:0.2800    3rd Qu.:-0.014936  
 Max.   :30.0   WALKING_UPSTAIRS  :30    Max.   :0.3015    Max.   :-0.001308  
 tBodyAcc.mean...Z  tBodyAcc.std...X  tBodyAcc.std...Y   tBodyAcc.std...Z 
 Min.   :-0.15251   Min.   :-0.9961   Min.   :-0.99024   Min.   :-0.9877  
 1st Qu.:-0.11207   1st Qu.:-0.9799   1st Qu.:-0.94205   1st Qu.:-0.9498  
 Median :-0.10819   Median :-0.7526   Median :-0.50897   Median :-0.6518  
 Mean   :-0.10916   Mean   :-0.5577   Mean   :-0.46046   Mean   :-0.5756  
 3rd Qu.:-0.10443   3rd Qu.:-0.1984   3rd Qu.:-0.03077   3rd Qu.:-0.2306  
 Max.   :-0.07538   Max.   : 0.6269   Max.   : 0.61694   Max.   : 0.6090  
 tGravityAcc.mean...X tGravityAcc.mean...Y tGravityAcc.mean...Z tGravityAcc.std...X
 Min.   :-0.6800      Min.   :-0.47989     Min.   :-0.49509     Min.   :-0.9968    
 1st Qu.: 0.8376      1st Qu.:-0.23319     1st Qu.:-0.11726     1st Qu.:-0.9825    
 Median : 0.9208      Median :-0.12782     Median : 0.02384     Median :-0.9695    
 Mean   : 0.6975      Mean   :-0.01621     Mean   : 0.07413     Mean   :-0.9638    
 3rd Qu.: 0.9425      3rd Qu.: 0.08773     3rd Qu.: 0.14946     3rd Qu.:-0.9509    
 Max.   : 0.9745      Max.   : 0.95659     Max.   : 0.95787     Max.   :-0.8296    
 tGravityAcc.std...Y tGravityAcc.std...Z tBodyAccJerk.mean...X tBodyAccJerk.mean...Y
 Min.   :-0.9942     Min.   :-0.9910     Min.   :0.04269       Min.   :-0.0386872   
 1st Qu.:-0.9711     1st Qu.:-0.9605     1st Qu.:0.07396       1st Qu.: 0.0004664   
 Median :-0.9590     Median :-0.9450     Median :0.07640       Median : 0.0094698   
 Mean   :-0.9524     Mean   :-0.9364     Mean   :0.07947       Mean   : 0.0075652   
 3rd Qu.:-0.9370     3rd Qu.:-0.9180     3rd Qu.:0.08330       3rd Qu.: 0.0134008   
 Max.   :-0.6436     Max.   :-0.6102     Max.   :0.13019       Max.   : 0.0568186   
 tBodyAccJerk.mean...Z tBodyAccJerk.std...X tBodyAccJerk.std...Y tBodyAccJerk.std...Z
 Min.   :-0.067458     Min.   :-0.9946      Min.   :-0.9895      Min.   :-0.99329    
 1st Qu.:-0.010601     1st Qu.:-0.9832      1st Qu.:-0.9724      1st Qu.:-0.98266    
 Median :-0.003861     Median :-0.8104      Median :-0.7756      Median :-0.88366    
 Mean   :-0.004953     Mean   :-0.5949      Mean   :-0.5654      Mean   :-0.73596    
 3rd Qu.: 0.001958     3rd Qu.:-0.2233      3rd Qu.:-0.1483      3rd Qu.:-0.51212    
 Max.   : 0.038053     Max.   : 0.5443      Max.   : 0.3553      Max.   : 0.03102    
 tBodyGyro.mean...X tBodyGyro.mean...Y tBodyGyro.mean...Z tBodyGyro.std...X
 Min.   :-0.20578   Min.   :-0.20421   Min.   :-0.07245   Min.   :-0.9943  
 1st Qu.:-0.04712   1st Qu.:-0.08955   1st Qu.: 0.07475   1st Qu.:-0.9735  
 Median :-0.02871   Median :-0.07318   Median : 0.08512   Median :-0.7890  
 Mean   :-0.03244   Mean   :-0.07426   Mean   : 0.08744   Mean   :-0.6916  
 3rd Qu.:-0.01676   3rd Qu.:-0.06113   3rd Qu.: 0.10177   3rd Qu.:-0.4414  
 Max.   : 0.19270   Max.   : 0.02747   Max.   : 0.17910   Max.   : 0.2677  
 tBodyGyro.std...Y tBodyGyro.std...Z tBodyGyroJerk.mean...X tBodyGyroJerk.mean...Y
 Min.   :-0.9942   Min.   :-0.9855   Min.   :-0.15721       Min.   :-0.07681      
 1st Qu.:-0.9629   1st Qu.:-0.9609   1st Qu.:-0.10322       1st Qu.:-0.04552      
 Median :-0.8017   Median :-0.8010   Median :-0.09868       Median :-0.04112      
 Mean   :-0.6533   Mean   :-0.6164   Mean   :-0.09606       Mean   :-0.04269      
 3rd Qu.:-0.4196   3rd Qu.:-0.3106   3rd Qu.:-0.09110       3rd Qu.:-0.03842      
 Max.   : 0.4765   Max.   : 0.5649   Max.   :-0.02209       Max.   :-0.01320      
 tBodyGyroJerk.mean...Z tBodyGyroJerk.std...X tBodyGyroJerk.std...Y tBodyGyroJerk.std...Z
 Min.   :-0.092500      Min.   :-0.9965       Min.   :-0.9971       Min.   :-0.9954      
 1st Qu.:-0.061725      1st Qu.:-0.9800       1st Qu.:-0.9832       1st Qu.:-0.9848      
 Median :-0.053430      Median :-0.8396       Median :-0.8942       Median :-0.8610      
 Mean   :-0.054802      Mean   :-0.7036       Mean   :-0.7636       Mean   :-0.7096      
 3rd Qu.:-0.048985      3rd Qu.:-0.4629       3rd Qu.:-0.5861       3rd Qu.:-0.4741      
 Max.   :-0.006941      Max.   : 0.1791       Max.   : 0.2959       Max.   : 0.1932      
 tBodyAccMag.mean.. tBodyAccMag.std.. tGravityAccMag.mean.. tGravityAccMag.std..
 Min.   :-0.9865    Min.   :-0.9865   Min.   :-0.9865       Min.   :-0.9865     
 1st Qu.:-0.9573    1st Qu.:-0.9430   1st Qu.:-0.9573       1st Qu.:-0.9430     
 Median :-0.4829    Median :-0.6074   Median :-0.4829       Median :-0.6074     
 Mean   :-0.4973    Mean   :-0.5439   Mean   :-0.4973       Mean   :-0.5439     
 3rd Qu.:-0.0919    3rd Qu.:-0.2090   3rd Qu.:-0.0919       3rd Qu.:-0.2090     
 Max.   : 0.6446    Max.   : 0.4284   Max.   : 0.6446       Max.   : 0.4284     
 tBodyAccJerkMag.mean.. tBodyAccJerkMag.std.. tBodyGyroMag.mean.. tBodyGyroMag.std..
 Min.   :-0.9928        Min.   :-0.9946       Min.   :-0.9807     Min.   :-0.9814   
 1st Qu.:-0.9807        1st Qu.:-0.9765       1st Qu.:-0.9461     1st Qu.:-0.9476   
 Median :-0.8168        Median :-0.8014       Median :-0.6551     Median :-0.7420   
 Mean   :-0.6079        Mean   :-0.5842       Mean   :-0.5652     Mean   :-0.6304   
 3rd Qu.:-0.2456        3rd Qu.:-0.2173       3rd Qu.:-0.2159     3rd Qu.:-0.3602   
 Max.   : 0.4345        Max.   : 0.4506       Max.   : 0.4180     Max.   : 0.3000   
 tBodyGyroJerkMag.mean.. tBodyGyroJerkMag.std.. fBodyAcc.mean...X fBodyAcc.mean...Y 
 Min.   :-0.99732        Min.   :-0.9977        Min.   :-0.9952   Min.   :-0.98903  
 1st Qu.:-0.98515        1st Qu.:-0.9805        1st Qu.:-0.9787   1st Qu.:-0.95361  
 Median :-0.86479        Median :-0.8809        Median :-0.7691   Median :-0.59498  
 Mean   :-0.73637        Mean   :-0.7550        Mean   :-0.5758   Mean   :-0.48873  
 3rd Qu.:-0.51186        3rd Qu.:-0.5767        3rd Qu.:-0.2174   3rd Qu.:-0.06341  
 Max.   : 0.08758        Max.   : 0.2502        Max.   : 0.5370   Max.   : 0.52419  
 fBodyAcc.mean...Z fBodyAcc.std...X  fBodyAcc.std...Y   fBodyAcc.std...Z 
 Min.   :-0.9895   Min.   :-0.9966   Min.   :-0.99068   Min.   :-0.9872  
 1st Qu.:-0.9619   1st Qu.:-0.9820   1st Qu.:-0.94042   1st Qu.:-0.9459  
 Median :-0.7236   Median :-0.7470   Median :-0.51338   Median :-0.6441  
 Mean   :-0.6297   Mean   :-0.5522   Mean   :-0.48148   Mean   :-0.5824  
 3rd Qu.:-0.3183   3rd Qu.:-0.1966   3rd Qu.:-0.07913   3rd Qu.:-0.2655  
 Max.   : 0.2807   Max.   : 0.6585   Max.   : 0.56019   Max.   : 0.6871  
 fBodyAccJerk.mean...X fBodyAccJerk.mean...Y fBodyAccJerk.mean...Z fBodyAccJerk.std...X
 Min.   :-0.9946       Min.   :-0.9894       Min.   :-0.9920       Min.   :-0.9951     
 1st Qu.:-0.9828       1st Qu.:-0.9725       1st Qu.:-0.9796       1st Qu.:-0.9847     
 Median :-0.8126       Median :-0.7817       Median :-0.8707       Median :-0.8254     
 Mean   :-0.6139       Mean   :-0.5882       Mean   :-0.7144       Mean   :-0.6121     
 3rd Qu.:-0.2820       3rd Qu.:-0.1963       3rd Qu.:-0.4697       3rd Qu.:-0.2475     
 Max.   : 0.4743       Max.   : 0.2767       Max.   : 0.1578       Max.   : 0.4768     
 fBodyAccJerk.std...Y fBodyAccJerk.std...Z fBodyGyro.mean...X fBodyGyro.mean...Y
 Min.   :-0.9905      Min.   :-0.993108    Min.   :-0.9931    Min.   :-0.9940   
 1st Qu.:-0.9737      1st Qu.:-0.983747    1st Qu.:-0.9697    1st Qu.:-0.9700   
 Median :-0.7852      Median :-0.895121    Median :-0.7300    Median :-0.8141   
 Mean   :-0.5707      Mean   :-0.756489    Mean   :-0.6367    Mean   :-0.6767   
 3rd Qu.:-0.1685      3rd Qu.:-0.543787    3rd Qu.:-0.3387    3rd Qu.:-0.4458   
 Max.   : 0.3498      Max.   :-0.006236    Max.   : 0.4750    Max.   : 0.3288   
 fBodyGyro.mean...Z fBodyGyro.std...X fBodyGyro.std...Y fBodyGyro.std...Z fBodyAccMag.mean..
 Min.   :-0.9860    Min.   :-0.9947   Min.   :-0.9944   Min.   :-0.9867   Min.   :-0.9868   
 1st Qu.:-0.9624    1st Qu.:-0.9750   1st Qu.:-0.9602   1st Qu.:-0.9643   1st Qu.:-0.9560   
 Median :-0.7909    Median :-0.8086   Median :-0.7964   Median :-0.8224   Median :-0.6703   
 Mean   :-0.6044    Mean   :-0.7110   Mean   :-0.6454   Mean   :-0.6577   Mean   :-0.5365   
 3rd Qu.:-0.2635    3rd Qu.:-0.4813   3rd Qu.:-0.4154   3rd Qu.:-0.3916   3rd Qu.:-0.1622   
 Max.   : 0.4924    Max.   : 0.1966   Max.   : 0.6462   Max.   : 0.5225   Max.   : 0.5866   
 fBodyAccMag.std.. fBodyBodyAccJerkMag.mean.. fBodyBodyAccJerkMag.std..
 Min.   :-0.9876   Min.   :-0.9940            Min.   :-0.9944          
 1st Qu.:-0.9452   1st Qu.:-0.9770            1st Qu.:-0.9752          
 Median :-0.6513   Median :-0.7940            Median :-0.8126          
 Mean   :-0.6210   Mean   :-0.5756            Mean   :-0.5992          
 3rd Qu.:-0.3654   3rd Qu.:-0.1872            3rd Qu.:-0.2668          
 Max.   : 0.1787   Max.   : 0.5384            Max.   : 0.3163          
 fBodyBodyGyroMag.mean.. fBodyBodyGyroMag.std.. fBodyBodyGyroJerkMag.mean..
 Min.   :-0.9865         Min.   :-0.9815        Min.   :-0.9976            
 1st Qu.:-0.9616         1st Qu.:-0.9488        1st Qu.:-0.9813            
 Median :-0.7657         Median :-0.7727        Median :-0.8779            
 Mean   :-0.6671         Mean   :-0.6723        Mean   :-0.7564            
 3rd Qu.:-0.4087         3rd Qu.:-0.4277        3rd Qu.:-0.5831            
 Max.   : 0.2040         Max.   : 0.2367        Max.   : 0.1466            
 fBodyBodyGyroJerkMag.std..
 Min.   :-0.9976           
 1st Qu.:-0.9802           
 Median :-0.8941           
 Mean   :-0.7715           
 3rd Qu.:-0.6081           
 Max.   : 0.2878         





