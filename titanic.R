# Data Wrangling Exercise 2: Dealing with Missing Values
# Springboard
# Section 3.1 (5)


# Step 0: Import titanic_original.csv as a data frame.

# If everything is a factor, the file is a mess.
mydata <- read.csv(file = "/Users/Kevin/Documents/titanic_original.csv", header=TRUE, stringsAsFactors = FALSE)


# Step 1: Port of embarkation

# embarkation is a 'chr' column and nothing filled the blank spaces.
location <- which(!(as.logical(nchar(mydata$embarked))))
mydata$embarked[location] <- "S"


# Step 2: Age

# Age is a 'num' column and NA filled the blank spaces.  First get the average (rounded to whole number).
average_age <- round(mean(mydata$age, na.rm = TRUE), 0)
# Second, determine which indices in the column have NA and fill them with the average age.
not_apps <- which(is.na(mydata$age))
mydata$age[not_apps] <- average_age

# Using the average age seems to be the best (and easiest) choice.


# Step 3: Lifeboat

# boat is a 'chr' column
no_boat <- which(nchar(mydata$boat) == 0)
mydata$boat[no_boat] <- "none"


# Step 4: Cabin

# First: create a vector of '1's; Second: cbind it to the data frame; Third: determine entries with no cabin number; Fourth: Enter '0' for entries with no cabin number.
has_cabin_number <- rep(1, times=nrow(mydata))
mydata <- cbind(mydata, has_cabin_number)

no_cabin <- which(nchar(mydata$cabin) == 0)
mydata$has_cabin_number[no_cabin] <- 0


# Step 5: Create a csv file to submit
write.csv(mydata, "/Users/Kevin/Documents/titanic_clean2.csv", quote = TRUE, row.names=FALSE)
