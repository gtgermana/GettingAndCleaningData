> This document describes the naming convention used to generate the variable names appearing in the tidy dataset produced for the "Getting and Cleaning Data" course project.

> The first two variable names are:
* activity - representing one of the six possible activities (LAYING, SITTING, STANDING, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS)
* subjectID - a number between 1 and 30 used to identify a particular subject

> The selected variables are those variables which has "mean" or "std" in their names in the original data files. The naming convention for these variables is 

>> [time|freq][Body|Gravity][Accel|Gyro]{Jerk}{Mag}[Mean|Std]{Freq}{X|Y|Z}

> where [...] denotes a required token and {...} denotes an optional token.

1. The first token is 'time'  for a time domain variable or 'freq' for a frequency domain variable  
2. 'Body' denotes body induced motion, while 'Gravity' denotes gravity induced motion
3. 'Accel' denotes linear acceleration, while 'Gyro' denotes angular velocity
4. 'Jerk' denotes the change in acceleration, and is optional
5. 'Mag' denotes magnitude of a three dimensional signal, and is optional
6. 'Mean' denotes this is mean based variable, while 'Std' denotes this is a standard deviation variable
7. 'Freq' denotes a frequency feature and is optional
8. 'X', 'Y', 'Z' denotes a spatial dimension, and is optional

> The complete list of variable names, using the above naming convention, follows:

timeBodyAccelMeanX
timeBodyAccelMeanY              
timeBodyAccelMeanZ
timeBodyAccelStdX               
timeBodyAccelStdY
timeBodyAccelStdZ               
timeGravityAccelMeanX
timeGravityAccelMeanY           
timeGravityAccelMeanZ
timeGravityAccelStdX            
timeGravityAccelStdY
timeGravityAccelStdZ            
timeBodyAccelJerkMeanX
timeBodyAccelJerkMeanY          
timeBodyAccelJerkMeanZ
timeBodyAccelJerkStdX           
timeBodyAccelJerkStdY
timeBodyAccelJerkStdZ           
timeBodyGyroMeanX
timeBodyGyroMeanY               
timeBodyGyroMeanZ
timeBodyGyroStdX                
timeBodyGyroStdY
timeBodyGyroStdZ                
timeBodyGyroJerkMeanX
timeBodyGyroJerkMeanY           
timeBodyGyroJerkMeanZ
timeBodyGyroJerkStdX            
timeBodyGyroJerkStdY
timeBodyGyroJerkStdZ            
timeBodyAccelMagMean
timeBodyAccelMagStd             
timeGravityAccelMagMean
timeGravityAccelMagStd          
timeBodyAccelJerkMagMean
timeBodyAccelJerkMagStd         
timeBodyGyroMagMean
timeBodyGyroMagStd              
timeBodyGyroJerkMagMean
timeBodyGyroJerkMagStd          
freqBodyAccelMeanX
freqBodyAccelMeanY              
freqBodyAccelMeanZ
freqBodyAccelStdX               
freqBodyAccelStdY
freqBodyAccelStdZ               
freqBodyAccelMeanFreqX
freqBodyAccelMeanFreqY          
freqBodyAccelMeanFreqZ
freqBodyAccelJerkMeanX          
freqBodyAccelJerkMeanY
freqBodyAccelJerkMeanZ          
freqBodyAccelJerkStdX
freqBodyAccelJerkStdY           
freqBodyAccelJerkStdZ
freqBodyAccelJerkMeanFreqX      
freqBodyAccelJerkMeanFreqY
freqBodyAccelJerkMeanFreqZ      
freqBodyGyroMeanX
freqBodyGyroMeanY               
freqBodyGyroMeanZ
freqBodyGyroStdX                
freqBodyGyroStdY
freqBodyGyroStdZ                
freqBodyGyroMeanFreqX
freqBodyGyroMeanFreqY           
freqBodyGyroMeanFreqZ
freqBodyAccelMagMean            
freqBodyAccelMagStd
freqBodyAccelMagMeanFreq        
freqBodyBodyAccelJerkMagMean
freqBodyBodyAccelJerkMagStd     
freqBodyBodyAccelJerkMagMeanFreq
freqBodyBodyGyroMagMean         
freqBodyBodyGyroMagStd
freqBodyBodyGyroMagMeanFreq     
freqBodyBodyGyroJerkMagMean
freqBodyBodyGyroJerkMagStd      
freqBodyBodyGyroJerkMagMeanFreq

> For each activity and subject combination, each variable above is averaged and placed in the tidy dataset, per project instructions.

> This tidy datset was written to a csv file using

>> write.table(tidyDataset,"tidyDataset.txt", quote = FALSE, sep = ",", row.names = FALSE)

> It can be read using

>> tidyDataset <- read.table("tidyDataset.txt", header = TRUE, sep = ",")

> So why is this a tidy dataset? Each variable forms one column, each observation forms one row, and each type of observational unit forms a table. (See Hadley Wickham, “Tidy Data”, for a discussion on tidy data. These definitions are found in Section 2.3.)

> See also the README.md file for this project.

