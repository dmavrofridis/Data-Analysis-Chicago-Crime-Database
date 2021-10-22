# Instructions:

Thank you for reading this.

In order to ensure that you won't encounter any problems or errors 
while opening the Tableau files on your computer please make sure to
carefully read the next steps.

Before you continue please be aware that checkpoint 2 was completed 
using JetBrain's Datagrip and Tableau for the visualization of the data after establishing an active and valid 
connection to the CPDP database.

## Prerequisites
- Please make sure to download and install Tableau on your machine while also activating the free trial or the student/teacher 1 year free version.
- Set up the connection to the CPDP database in Tableau using PostgreSQL by following the steps that are posted on Canvas.

## Next steps:
- After setting up the connection, you can run each one of the files by opening them up using the Tableau user interface. 
- You may be prompted to enter the CPDP connection password in order to gain access to the visualizations.
- You may encounter an error about custom SQL code being used, if so please select "yes" from the given options.
- If you receive a message about "extract not found", please choose the "regenerate the extract" option and store the new file somewhere convenient.
- By opening up each file from the src folder, you are going to be served with the appropriate visual results.

## Results & Analysis:
Please make sure to read the findings report in order to completely understand the results for each one of the questions below.

## Question 1:
#### What is the connection between awards and allegations?  That is to say, when allegations increase do awards increase or is there some other correlation?
##### Question 1 is broken down into 2 different answers labeled question_1a and question_1b. In order to generate the appropriate graphics we were required to write two different SQL queries. Therefore, for question_1a we obtained a count of both their awards and allegations. The two graphs included in part A, represent the number of awards per each count of allegations in two different but colorful ways. For question_1b, we are generating two different graphs. The first graph represents the distribution of police officers' counts with a certain number of rewards and allegations. For the second graph, we presented the average number of police officers rewards grouped by the number of allegations they receive.
- ##### [Tableau Question 1a](src/question_1a.twb)
- ##### [Tableau Question 1b](src/question_1b.twb)

## Question 2:
#### Based on TRRs, what streets experienced the greatest number of incidents?  Of these, in what percentage of these did the police respond violently (eg. the action response category was greater than or equal to 4)?
##### For these visualizations, we obtained the number of incidents per location (in this case, locations were all streets). Afterwards we determined based on the action category rating, whether or not each incident involved a violent police response (eg. a weapon was discharged, melee force was used, etc.). As a result, question 2 generates 4 different graphs in order to represent police violence and it's relation to how dangerous certain streets in Chicago can be.
- ##### [Tableau Question 2](src/question_2.twb)

## Question 3:
#### Is there a correlation between the number of tactical response reports filed by each officer and the number of awards that the officer received?
##### For question 3, we have successfully managed to generate two different charts in order to identify whether there exists a relationship between the TRR’s and the number of awards that the police officers receive. The two visualizations demonstrate something of a trend: as the officer is involved in more TRR incidents, they also will likely get more awards.
- ##### [Tableau Question 3](src/question_3.twb)

