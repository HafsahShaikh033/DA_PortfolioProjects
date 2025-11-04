
-- Creating a Database 

CREATE DATABASE GCC_Analyst_Jobs ;

USE GCC_Analyst_Jobs ;

SELECT *
FROM Sheet1$;

-- Changing the Name of the Table 

EXEC Sp_rename 'sheet1$', 'Gcc_Analyst_Jobs';

SELECT *
FROM GCC_Analyst_Jobs;

-- Adding the Job_Id Column 

ALTER TABLE Gcc_Analyst_Jobs
ADD Job_Id INT IDENTITY(1,1) PRIMARY KEY;

SELECT *
FROM Gcc_Analyst_Jobs;

-- Deleting the Unwanted Null Values 

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'GCC_Analyst_Jobs';

SELECT * 
FROM Gcc_Analyst_Jobs
where Country is null; 

DELETE 
FROM Gcc_Analyst_Jobs
Where [Country ] is NULL;

-- Fixing Spellings 

SELECT Country, REPLACE(Country, 'harin','hrain') AS Correct_Country
FROM GCC_Analyst_Jobs;

UPDATE Gcc_Analyst_Jobs
SET Country = LTRIM(RTRIM(Country));

-- Total Number of job Posting by Country 

SELECT Country, COUNT(*) AS Total_Jobs 
FROM Gcc_Analyst_Jobs
Group By Country
order by Total_Jobs Desc ;

-- Number of Analytical Jobs in Each Country 

SELECT Country, Count ([Job Title ]) AS Number_Of_Differnt_Jobs_Per_Country 
FROM Gcc_Analyst_Jobs 
Group By Country;


-- Number of Job Postings By Job Tilte

SELECT [Job Title ], COUNT(*) AS Total_Jobs_by_the_Title 
FROM Gcc_Analyst_Jobs
Group By [Job Title ]
order by Total_Jobs_by_the_Title Desc ;

-- Average experience required per country

SELECT [Country ], AVG ([Experince( Years )]) AS AVG_Experince_Required  
FROM Gcc_Analyst_Jobs 
Group By [Country ]
Order By AVG_Experince_Required   DESC; 

-- Most in-demand tools/software

SELECT [Tools/Software (technical)], COUNT(*) AS Mention_CountFROM GCC_Analyst_JobsGROUP BY [Tools/Software (technical)]ORDER BY Mention_Count DESC;

-- Top 3 Highest Paying Jobs Per Country 

WITH RankedJobs AS (
	SELECT 
		[Country ],
		[Job Title ],
		[Salary ],  
		ROW_NUMBER() OVER (PARTITION BY [Country ] ORDER BY [Salary ] DESC ) AS Ranked_Jobs
	FROM Gcc_Analyst_Jobs
WHERE [Salary ] is not NUll
)
SELECT [Country ],[Job Title ],[Salary ]
FROM RankedJobs 
WHERE [Salary ] <=3 ;

SELECT [Salary ]
FROM Gcc_Analyst_Jobs;

ALTER TABLE Gcc_Analyst_Jobs
ALTER COLUMN [Salary ] int;

-- What are the Most common Soft/Analytical Skills Requiered by each job  

SELECT [Job Title ], [Skills (soft/analytical)], COUNT(*) AS Common_Soft_kills 
FROM Gcc_Analyst_Jobs
GROUP BY [Job Title ], [Skills (soft/analytical)]
ORDER BY Common_Soft_kills DESC;

-- Skill Extraction Lets look at the primary skills requiered for each job 

SELECT 
    [Job Title ],[Country ],
    SUBSTRING([Skills (soft/analytical)], 1, CHARINDEX(',', [Skills (soft/analytical)] + ',') - 1) AS First_Skill
FROM GCC_Analyst_Jobs
WHERE [Skills (soft/analytical)] IS NOT NULL;


-- Lets look at the most recent job posting By date

SELECT [Job Title ], [Country ], [Date Posted ], [Company ]
FROM Gcc_Analyst_Jobs
WHERE [Date Posted ] >= DATEADD(DAY, -30, GETDATE());

EXEC sp_help 'Gcc_Analyst_Jobs';


-- the Date Posted in not done in the right DATETIME formte so it needs to be corrected 

ALTER TABLE Gcc_Analyst_Jobs 
ADD [Date_Posted_Cleaned] DATE;

UPDATE Gcc_Analyst_Jobs 
SET [Date_Posted_Cleaned] = TRY_CONVERT(DATE, [Date Posted ], 103);

SELECT [Date_Posted_Cleaned], [Date Posted ]
FROM Gcc_Analyst_Jobs;

ALTER TABLE Gcc_Analyst_Jobs
DROP COLUMN [Date Posted ];

-- Now Lets look at the most recent job posting 

SELECT [Job Title ], [Country ], [Date_Posted_Cleaned], [Company ]
FROM Gcc_Analyst_Jobs
WHERE [Date_Posted_Cleaned] >= DATEADD(DAY, -30, GETDATE());

-- What are the most in demand technical tools 

SELECT * 
FROM Gcc_Analyst_Jobs; 

SELECT [Tools/Software (technical)]
FROM Gcc_Analyst_Jobs;

SELECT 
SUM(CASE WHEN [Tools/Software (technical)] LIKE '%Excel%' THEN 1 ELSE 0 END) AS Excel_rq,
SUM(CASE WHEN [Tools/Software (technical)] LIKE '%SQL%' THEN 1 ELSE 0 END ) AS SQL_rq,
SUM(CASE WHEN [Tools/Software (technical)] LIKE '%Power BI%' THEN 1 ELSE 0 END ) AS PowerBI_rq,
SUM(CASE WHEN [Tools/Software (technical)] LIKE '%Tablue%' THEN 1 ELSE 0 END ) AS Tablue_rq,
SUM(CASE WHEN [Tools/Software (technical)] LIKE '%Python%' THEN 1 ELSE 0 END ) AS Python_rq
FROM Gcc_Analyst_Jobs;

