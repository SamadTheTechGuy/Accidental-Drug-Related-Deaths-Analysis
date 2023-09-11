# Accidental-Drug-Related-Deaths-Analysis
This is an exploratory analysis of accidental drug related deaths data.
# Brief Introduction
The accidental drug related deaths data shows accidental death report associated with drug overdose from different genders, races, the causes and manners of death, etc. from 2012 to 2021 in United States. So, recently, the Office of the Chief Medical Examiner, State of Connecticut hired me as a data analyst to help unravel and find insightful information about the data. 
## Brief Overview of the dataset
This dataset was made available on data.gov provided by the Office of the Chief Medical Examiner, State of Conneticut. Owned by Pauline Zaldonis. It consists of more than 9,000 rows and 48 columns split into 2 tables. After data cleaning, the rows was reduced to 3,163 rows.
## Problem Questions
*  What is the total number of deaths recorded over the years?
*  What are the total number of male and female victims from the report?
*  Which year had the highest death counts from the report?
*  Which race had the highest death records compared to others?
*  Which state and city recorded the most death counts?
*  What are the top 5 description of injuries?
*  Which age categories had the highest and least death counts?
*  What are the top 3 places most injuries occurred?
*  What are the top 3 causes of death in each age category having the maximum number of deaths?
*  What are the total number of male and female victims that died by accident or naturally?
*  What are the highest and lowest number of deaths per year for the age categories?
*  What are the top 5 detected overdose drugs in the victims with their corresponding number of deaths?
## Tool used
*  Postgresql
##  Processes
*  Created two tables for the datasets in pgadmin
*  Imported the data into the tables
*  Data cleaning - checked for errors/removed duplicates, updated some columns to lowercase, corrected misspelt words and punctuation errors.
*  Analysis
## Key Insights
*  **3,163 deaths** were recorded over the years - from **2012 to 2021.**
![Screenshot (162)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/013d597c-703f-486b-b1be-109212591baa)
*  Male victims total deaths recorded, **2,345** were more than the females **816**.
![Screenshot (164)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/3c0646cb-5bf0-4c48-849d-ff765d2d203f)
*  **Year 2021** had highest death counts with **357 records.**
![Screenshot (166)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/9c676b31-3c44-452d-9c3e-4006892cc6dd)
*  **White race** death records had the highest death counts compared to others with more than **2,000 records.**
![Screenshot (168)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/a533eb4b-b3f0-4868-a54f-628415122e9a)
*  **Connecticut State** and **Hartford City** had the most death counts - with more **2,500** and **200 records.**
![Screenshot (170)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/c33ab766-22cd-459e-a3b9-c266a4958545)
![Screenshot (172)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/d4d4c0e6-3531-4877-bc32-10988775bae7)
*  The most common form of **description of injury** was **drug abuse.**
![Screenshot (175)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/1d70b08f-216f-425a-9928-3035d04fe38b)
*  The age brackets with the highest number of death counts was the **middle age(1,901)** - **between 31 and 54 years old** while 
the **old age had the least(592)** - **above 54 years old.**
![Screenshot (177)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/ca184c3f-5bb5-4863-a875-0b061983561a)
*  The most common **place of injury** was their **place of residence.**  
![Screenshot (179)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/74ef2ec7-cab5-450d-8489-934f4adb9c1e)
*  The most common causes of death amongst the age categories were: 
For **Adolescence and middle ages** - **use of cocaine**
For **Old age** - **hypertensive and atherosclerotic cardiovascular disease**
![Screenshot (181)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/f2bdc880-eb9a-49e9-ad9a-f6a7a49df5c9)
*  **Almost 2,500 males** died by **accident**, **more than 800** were **female victims**, and only just **1 male** died **naturally.**
![Screenshot (183)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/72239f6a-717d-46c0-8c45-d753a41597db)
*  The **maximum number of deaths** was recorded in **2021 - 221 (Middle age)** while the **least number of deaths** was in **2014 - 29 (Old age).**
![Screenshot (187)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/e4cc10aa-7e33-4819-ab24-ea60e88e5698)
*  It was recorded that **fentanyl** was **detected most** in the victims which resulted to **1,698 deaths.**
![Screenshot (189)](https://github.com/SamadTheTechGuy/Accidental-Drug-Related-Deaths-Analysis/assets/97789215/654cb957-d0ea-47d9-b8a4-5aa7908de332)




