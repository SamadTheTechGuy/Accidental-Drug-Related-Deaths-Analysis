--To create table1 for the dataset
DROP TABLE IF EXISTS DrugCause
CREATE TABLE DrugCause (
	Date DATE,
	Date_Type TEXT,
	Location TEXT,
	Location_If_Other TEXT,
	Cause_Of_Death TEXT,
	Manner_Of_Death TEXT,
	Other_Significant_Conditions TEXT,
	Heroin TEXT,
	Heroin_death_certificate_DC TEXT,
	Cocaine TEXT,
	Fentanyl TEXT,
	Fentanyl_Analogue TEXT,
	Oxycodone TEXT,
	Oxymorphone TEXT,
	Ethanol TEXT,
	Hydrocodone TEXT,
	Benzodiazepine TEXT,
	Methadone TEXT,
	Meth_Amphethamine TEXT,
	Amphet TEXT,
	Tramad TEXT,
	Hydromorphone TEXT,
	Morphine_Not_Heroin TEXT,
	Xylazine TEXT,
	Gabapentin TEXT,
	Opiate_NOS TEXT,
	Heroin_Morph_Codeine TEXT,
	Other_Opioid TEXT,
	Any_Opioid TEXT,
	Other TEXT,
	ResidenceCityGeo CHAR(50),
	InjuryCityGeo CHAR(50),
	DeathCityGeo CHAR(50)
);

--To create table2 for the dataset
DROP TABLE IF EXISTS DrugDeaths
CREATE TABLE DrugDeaths (
	Date DATE,
	Date_type TEXT,
	Age INT,
	Sex TEXT,
	Race TEXT,
	Ethnicity TEXT,
	Residence_City TEXT,
	Residence_County TEXT,
	Residence_State TEXT,
	Injury_City TEXT,
	Injury_County TEXT,
	Injury_State TEXT,
	Injury_Place TEXT,
	Description_of_Injury TEXT,
	Death_City TEXT,
	Death_County TEXT,
	Death_State TEXT
);

--Opiate_NOS: Opiate nitrous oxide

--To import the data into DrugCause table
COPY DrugCause FROM 'C:\Users\Public\Documents\DrugCause.csv'
	WITH DELIMITER ',' CSV HEADER;

--To import the data into DrugDeaths table
COPY DrugDeaths FROM 'C:\Users\Public\Downloads\DrugDeaths.csv'
	WITH DELIMITER ',' CSV HEADER;

--To view the DrugCause table
SELECT * FROM DrugCause;

--To view the DrugDeaths table
SELECT * FROM DrugDeaths;

--Data cleaning for DrugDeaths and DrugCause table
--To update their columns to lowercase
UPDATE drugdeaths
SET description_of_injury = LOWER(description_of_injury)

UPDATE drugcause
SET location_if_other = LOWER(location_if_other)

UPDATE drugcause
SET cause_of_death = LOWER(cause_of_death)

UPDATE drugcause
SET manner_of_death = LOWER(manner_of_death)

UPDATE drugcause
SET other_significant_conditions = LOWER(other_significant_conditions)

UPDATE drugcause
SET other = LOWER(other)

--To update misspellings and punctuation errors
UPDATE drugdeaths
SET description_of_injury = 
	CASE
		WHEN description_of_injury ILIKE ANY(ARRAY['ingested medications, alcohol%','ingested medication and alcohol%'
												  ,'ingested medications with alcohol.%','ingested medicine with alcohol%'
												  ,'ingested alcohol and medications%','medications,alcohol%','medications with alcohol%'])
			THEN 'ingested medications and alcohol'
		WHEN description_of_injury ILIKE ANY(ARRAY['substance abuse)%','substances abuse%','substance abuse.%','subsatnce abuse%'])
			THEN 'substance abuse'
		WHEN description_of_injury ILIKE ANY(ARRAY['ingested ethanol with medication%','ingested ethanol and medications%'])
			THEN 'ingested medications and ethanol'
		WHEN description_of_injury ILIKE ANY(ARRAY['abuse of medications.%','medication abuse%','medication overuse%'
												  ,'excessive use of medications%','misuse of medications%'
												  ,'excessive ingestion of medication%','excessive prescribed of medication%'
												  ,'abuse of medication%','abused medication%']) 
			THEN 'abuse of medications'
		WHEN description_of_injury ILIKE ANY(ARRAY['ingestion of drugs%','ingested medications'
												  ,'ingested medicines%','ingestion of medications'])
			THEN 'ingested drugs'
		WHEN description_of_injury = 'substance sue'  THEN 'substance use'
		WHEN description_of_injury ILIKE ANY(ARRAY['inhalation/ingestion%','inhalation; ingestion%']) 
			THEN 'inhalation and ingestion'
		WHEN description_of_injury = 'druguse' THEN 'drug use'
		WHEN description_of_injury = 'ingested narcotic medications and alcohol' THEN 'ingested narcotic medications with alcohol'
		WHEN description_of_injury ILIKE ANY(ARRAY['took ethanol and prescription medication%','took ethanol and prescription medications%'])
			THEN 'took ethanol and prescribed medications'
		WHEN description_of_injury ILIKE ANY(ARRAY['used medications, alcohol%','used medications and alcohol%'
												  ,'used medications with alcohol%','took alcohol and medications%'
												  ,'took drugs and alcohol%','medication, alcohol use%','drug, alcohol use%'])
			THEN 'used drugs and alcohol'
		WHEN description_of_injury ILIKE ANY(ARRAY['usage of multiple drugs%','took multiple medications%','multiple drug use%'])
			THEN 'used multiple medications'
		WHEN description_of_injury ILIKE ANY(ARRAY['medication alcohol abuse%','alcohol and medication/substance abuse%'
												  ,'alcohol and substance abuse%'])
			THEN 'medication and alcohol abuse'
		WHEN description_of_injury = 'used drugs' THEN 'took medications'
		WHEN description_of_injury = 'took drugs' THEN 'took medications'
		WHEN description_of_injury = 'took medication' THEN 'took medications'
		WHEN description_of_injury ILIKE ANY(ARRAY['ingested medication%','consumed medications%']) THEN 'took medications'
		WHEN description_of_injury ILIKE ANY(ARRAY['fentanyl use%','consumed fentanyl%']) THEN 'took fentanyl'
		WHEN description_of_injury ILIKE ANY(ARRAY['used fentanyl and ethanol%'
												   ,'took ethanol and fentanyl%']) 
			THEN 'took fentanyl and ethanol'
		WHEN description_of_injury ILIKE ANY(ARRAY['took ethanol and prescribed medications%'
												   ,'consumed ethanol and prescribed medications%'
												   ,'consumed ethanol and prescription medication%'
												   ,'consumed ethanol with prescribed medication%'])
			THEN 'consumed ethanol with prescribed medications'
		WHEN description_of_injury = 'ingestion of pills' THEN 'ingested pills'
		WHEN description_of_injury = 'ingested prescription medication' THEN 'ingested prescription medications'
		WHEN description_of_injury = 'prescription misuse' THEN 'prescription abuse'
		WHEN description_of_injury = 'combined alcohol and medication' THEN 'combined alcohol and medications'
		WHEN description_of_injury ILIKE ANY(ARRAY['took prescription drugs%','took prescription-type%'])								  
			THEN 'took prescription medications'
		WHEN description_of_injury = 'took prescription medication' THEN 'took prescription medications'
		WHEN description_of_injury ILIKE ANY(ARRAY['prescription medication abuse%','prescription medicine abuse%'
												  ,'prescription medicine misuse%','abused prescription medications%'])
			THEN 'prescription drug overuse'
		ELSE description_of_injury
		END
		
UPDATE drugdeaths
SET race =
	CASE
		WHEN race = 'Black' THEN 'Black or African American'
		ELSE race
		END

UPDATE drugcause
SET location_if_other = 
	CASE
		WHEN location_if_other IN ('friend''s apartment','friend''s apt.','friend''s home'
								   ,'friend''s house','friend home')
			THEN 'friend''s residence'
		WHEN location_if_other IN ('friends'' home','friends''s residence','friends apartment'
								   ,'friends home','friends house','friends resident')
			THEN 'friends residence'
		WHEN location_if_other IN ('boyfriend''s home','boyfriend''s house')
			THEN 'boyfriend''s residence'
		WHEN location_if_other = 'boyfriends house' THEN 'boyfriends residence'
		WHEN location_if_other IN ('girlfriend''s apt','girlfriend''s apt.','girlfriend''s home'
								   ,'girlfriend''s house','girlfriend residence')
			THEN 'girlfriend''s residence'
		WHEN location_if_other IN ('hotel or motel', 'motel/hotel') THEN 'hotel/motel'
		WHEN location_if_other = 'in vehicle in parking lot' THEN 'vehicle in parking lot'
		WHEN location_if_other IN ('"sober house"', 'sober  house') THEN 'sober house'
		WHEN location_if_other IN ('vehicle', 'inside vehicle') THEN 'in vehicle'
		WHEN location_if_other = 'roadway in vehicle' THEN 'inside vehicle in roadway'
		WHEN location_if_other IN ('outside driveway', 'strip  mall outside') THEN 'outside'
		WHEN location_if_other = 'abandon house' THEN 'abandoned house'	
		WHEN location_if_other = 'mom''s house' THEN 'mother''s house'
		WHEN location_if_other IN ('mother''s home', 'mother''s house') THEN 'mother''s residence'
		WHEN location_if_other IN ('father''s home', 'father''s house', 'dad''s home') THEN 'father''s residence'
		WHEN location_if_other = 'days inn' THEN 'day''s inn'
		WHEN location_if_other = 'la quinta inn' THEN 'laquinta inn'
		WHEN location_if_other = 'sunny side inn' THEN 'sunnyside inn'
		WHEN location_if_other IN ('parent''s home', 'parent''s house', 'parent''S residence') THEN 'parent''s residence'
		WHEN location_if_other = 'parents house' THEN 'parents'' home'
		WHEN location_if_other = 'in park' THEN 'park'
		WHEN location_if_other = 'counsin''s residence' THEN 'cousin''s residence'
		WHEN location_if_other = 'other residence' THEN 'other''s residence'
		WHEN location_if_other IN ('brother''s home', 'brother''s house') THEN 'brother''s residence'
		WHEN location_if_other IN ('sister''s home', 'sister''s house') THEN 'sister''s residence'
		WHEN location_if_other = 'behind building' THEN 'behind a building'
		WHEN location_if_other = 'econologe' THEN 'econo lodge'
		WHEN location_if_other = 'family''s house' THEN 'family residence'
		WHEN location_if_other = 'neighbor''s home' THEN 'neighbor''s residence'
		WHEN location_if_other = 'other''s residents' THEN 'other''s residence'
		ELSE location_if_other
		END
											   
UPDATE drugcause
SET cause_of_death = 
	CASE
		--WHEN cause_of_death = 'acute fentanyl intoxication.' THEN 'acute fentanyl intoxication'
		WHEN cause_of_death IN ('acute intoxication due to the combined effects of cocaine and fentanyl'
								, 'acute cocaine and fentanyl intoxication'
							    , 'acute intoxication due to the combined effects of fentanyl and cocaine'
							    , 'acute intoxication by the combined effects of fentanyl and cocaine'
							    , 'acute intoxication by the combined effects of cocaine and fentanyl'
							    , 'acute intoxication from the combined effects of cocaine and fentanyl')
			THEN 'acute fentanyl and cocaine intoxication' 
		WHEN cause_of_death IN ('acute intoxication due to the combined effects of fentanyl and heroin'
							    , 'acute intoxication by the combined effects of fentanyl and heroin'
							    , 'acute intoxication due to the combined effects of heroin and fentanyl'
							    , 'acute intoxication from the combined effects of fentanyl and heroin')
			THEN 'acute fentanyl and heroin intoxication'
		WHEN cause_of_death IN ('acute intoxication due to the combined effects of fentanyl and alcohol'
							    , 'acute intoxication due to the combined effects of fentanyl and ethanol'
							    , 'acute intoxication due to the combined effects of ethanol and fentanyl'
							    , 'acute intoxication by the combined effects of fentanyl and alcohol'
								, 'acute intoxication by the combined effects of ethanol and fentanyl'
							    , 'acute fentanyl and ethanol intoxication'
							    , 'acute intoxication from the combined effects of fentanyl and alcohol')
			THEN 'acute ethanol and fentanyl intoxication'
		WHEN cause_of_death = 'acute intoxication due to the combined effects of cocaine and heroin'
			THEN 'acute heroin and cocaine intoxication'
		WHEN cause_of_death IN ('intoxication due to the combined effects of cocaine and heroin'
								, 'heroin and cocaine intoxication')
			THEN 'cocaine and heroin intoxication'
		WHEN cause_of_death IN ('acute intoxication due to the combined effects of fentanyl, cocaine and alcohol'
							    , 'acute intoxication due to the combined effects of fentanyl, cocaine, and ethanol'
							    , 'acute intoxication combined effects of ethanol, cocaine, and fentanyl')
			THEN 'acute intoxication by the combined effects of ethanol, cocaine, and fentanyl'
		WHEN cause_of_death IN ('acute intoxication due to the combined effects of cocaine, fentanyl, and heroin'
							    , 'acute intoxication due to the combined effects of fentanyl, heroin and cocaine'
							    , 'acute intoxication from the combined effects of cocaine, fentanyl, and heroin')
			THEN 'acute intoxication due to the combined effects of fentanyl, heroin, and cocaine'
		WHEN cause_of_death = 'acute intoxication due to the combined effects of ethanol, fentanyl, and heroin'
			THEN 'acute intoxication due to the combined effects of fentanyl, heroin, and ethanol'
		WHEN cause_of_death = 'acute intoxication from the combined effects of fentanyl and alprazolam'
			THEN 'acute intoxication due to the combined effects of fentanyl and alprazolam'
		WHEN cause_of_death IN ('acute intoxication due to the combined effects of heroin and ethanol'
							    , 'acute intoxication due to the combined effects of heroin and alcohol')
			THEN 'acute heroin and ethanol intoxication'
		WHEN cause_of_death = 'acute intoxication by the combined effects of fentanyl and xylazine'
			THEN 'acute intoxication due to the combined effects of fentanyl and xylazine'
		WHEN cause_of_death = 'acute intoxication due to the combined effects of cocaine and alcohol'
			THEN 'acute intoxication due to the combined effects of cocaine and ethanol'
		WHEN cause_of_death = 'intoxication due to the combined effects of ethanol, cocaine, and heroin'
			THEN 'acute intoxication due to the combined effects of ethanol, cocaine, and heroin'
		Else cause_of_death
		END
		
UPDATE drugcause
SET other_significant_conditions = 
	CASE
		WHEN other_significant_conditions = 'atherosclerotic and hypertensive cardiovascular disease'
			THEN 'hypertensive and atherosclerotic cardiovascular disease'
		WHEN other_significant_conditions = 'recent cocaine use.'
			THEN 'recent cocaine use'
		ELSE other_significant_conditions
		END		

--To check for and remove duplicates
--Create temporary unique id columns for the two tables
ALTER TABLE drugdeaths ADD COLUMN row_num INT GENERATED ALWAYS AS IDENTITY;

DELETE FROM drugdeaths
WHERE row_num IN (
				SELECT MAX(row_num)
				FROM drugdeaths
				GROUP BY date, date_type
				HAVING COUNT(*) > 1);

ALTER TABLE drugdeaths DROP COLUMN row_num;

ALTER TABLE drugcause ADD COLUMN row_num INT GENERATED ALWAYS AS IDENTITY;

DELETE FROM drugcause
WHERE row_num IN (
				SELECT MAX(row_num)
				FROM drugcause
				GROUP BY date, date_type
				HAVING COUNT(*) > 1);

ALTER TABLE drugcause DROP COLUMN row_num;	

--To find the total number of deaths
SELECT
	COUNT(*) AS total_deaths
FROM drugdeaths;

--To find the number of male and female victims from the DrugDeaths table
SELECT
	DISTINCT sex,
	COUNT(*) AS num_victims
FROM DrugDeaths
WHERE sex is not null
GROUP BY 1
ORDER BY 2 DESC;

--To find the year most deaths were recorded or reported from the DrugDeaths table
SELECT
	extract(year from date) AS year,
	COUNT(*) AS DeathCount
FROM DrugDeaths
WHERE date_type IN ('Date of death', 'Date reported')
GROUP BY 1
ORDER BY 2 DESC;

--To find the race with the most drug related death from the DrugDeaths table
SELECT
	DISTINCT race,
	COUNT(*) AS num_drug_related_deaths
FROM DrugDeaths
WHERE race is not null
GROUP BY 1
ORDER BY 2 DESC;

--To view the residence city with the most death counts from the drugdeaths table
SELECT
	DISTINCT residence_city,
	COUNT(*) AS num_deaths
FROM DrugDeaths
WHERE residence_city is not null
GROUP BY 1
ORDER BY 2 DESC;

--To view the residence state with the most death from the drugdeaths table
SELECT
	DISTINCT residence_state,
	COUNT(*) AS num_deaths
FROM DrugDeaths
WHERE residence_state IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

--To view the most form of description of injury from drugdeaths table
SELECT
	DISTINCT description_of_injury,
	COUNT(*) AS num_of_injuries
FROM DrugDeaths
WHERE description_of_injury is not null
GROUP BY 1
ORDER BY 2 DESC;

--To view the age categories of the victims by their description of injury
SELECT
	DISTINCT description_of_injury,
	age,
		CASE
			WHEN age < 31 THEN 'Adolescent'
			WHEN age >= 31 AND age <= 54 THEN 'Middle age'
			WHEN age >54 THEN 'Old'
		END AS Age_Categories
FROM DrugDeaths
WHERE description_of_injury IS NOT NULL AND age IS NOT NULL
ORDER BY 2 DESC;

--To view the age categories with the most deaths
SELECT
	DISTINCT age_categories,
	COUNT(*) OVER(PARTITION BY age_categories) AS num_of_deaths
FROM
	(SELECT
		age,
			CASE
				WHEN age < 31 THEN 'Adolescent'
				WHEN age >= 31 AND age <= 54 THEN 'Middle age'
				WHEN age >54 THEN 'Old'
			END AS Age_Categories
	FROM DrugDeaths
	WHERE age IS NOT NULL
	ORDER BY 2 DESC) X
ORDER BY 2 DESC;

--To find the top 3 places where most injury occurred
SELECT 
	DISTINCT injury_place,
	COUNT(*) AS Count_Injury_Place
FROM drugdeaths
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

--To find the top 3 causes of death in each age category having the max num_death
WITH t1 AS (	
SELECT
	DISTINCT dc.cause_of_death,
		CASE
			WHEN age < 31 THEN 'Adolescent'
			WHEN age >= 31 AND age <= 54 THEN 'Middle age'
			WHEN age >54 THEN 'Old'
		END AS Age_Categories,
	COUNT(*) AS cod_count
FROM drugdeaths dd
INNER JOIN drugcause dc
	ON dd.date = dc.date
WHERE dd.age IS NOT NULL
	AND dc.cause_of_death IS NOT NULL
GROUP BY 1,2
ORDER BY 3 DESC
),
t2 AS (
	SELECT 
		*,
		RANK() OVER(PARTITION BY age_categories ORDER BY cod_count DESC) AS rnk
	FROM t1
)
SELECT 
	*
FROM t2 
WHERE t2.rnk < 4;
		
--To find the total number of male and female victims that died by accident or naturally
SELECT 
	dd.sex,
	dc.manner_of_death,
	COUNT(*) AS num_victims
FROM drugcause dc
INNER JOIN drugdeaths dd
	ON dc.date = dd.date
WHERE dc.manner_of_death IN ('natural', 'accident')
	AND dd.sex IS NOT NULL
GROUP BY 1,2
ORDER BY 3 DESC;
	
--To view each year with the corresponding Annual and Total number of deaths for the age group
WITH total_deaths AS (
	SELECT 
		COUNT(date) AS total_num_deaths
	FROM drugdeaths
	)	
SELECT 
	EXTRACT(YEAR FROM date) AS annual_year,
	age,
	CASE
		WHEN age < 31 THEN 'Adolescent'
		WHEN age >= 31 AND age <= 54 THEN 'Middle age'
		WHEN age >54 THEN 'Old'
	END AS Age_Categories,
	COUNT(date) AS annual_num_deaths,
	total_num_deaths
FROM drugdeaths, total_deaths
GROUP BY 1,2,5
ORDER BY 1;

--To view each year with the highest and lowest number of deaths for the age categories 	
WITH yearly_deaths AS (
	SELECT 
		EXTRACT(YEAR FROM date) AS annual_year,
		CASE
			WHEN age < 31 THEN 'Adolescent'
			WHEN age >= 31 AND age <= 54 THEN 'Middle age'
			WHEN age >54 THEN 'Old'
		END AS Age_Categories,
		COUNT(date) AS annual_num_deaths_per_age_categories
	FROM drugdeaths
	GROUP BY 1,2	
	),	
yearly_min_max_deaths AS (	
	SELECT
		annual_year,
		MIN(annual_num_deaths_per_age_categories) AS yearly_min_deaths,
		MAX(annual_num_deaths_per_age_categories) AS yearly_max_deaths
	FROM yearly_deaths
	GROUP BY 1)
SELECT
	yd.annual_year,
	Age_Categories,
	yd.annual_num_deaths_per_age_categories,
	yearly_min_deaths,
	yearly_max_deaths
FROM yearly_deaths yd
INNER JOIN yearly_min_max_deaths ymmd
	ON yd.annual_year = ymmd.annual_year
ORDER BY 1;

--To fetch the top 10 details of the victims that were of the same age but of different races	
--Create temporary unique id columns for the drugdeaths table
ALTER TABLE drugdeaths ADD COLUMN row_num INT GENERATED ALWAYS AS IDENTITY;

SELECT
	DISTINCT dd1.*
FROM drugdeaths dd1
INNER JOIN drugdeaths dd2
	ON dd1.row_num != dd2.row_num
	AND dd1.age = dd2.age
	AND dd1.race <> dd2.race
LIMIT 10;

ALTER TABLE drugdeaths DROP COLUMN row_num;

--To fetch the detected overdose drugs with the corresponding number of deaths
SELECT 
	chemical_substance, 
	indicator,
	COUNT(*) AS num_of_deaths
FROM (SELECT
	UNNEST(array['Heroin',
				'Cocaine',
				'Fentanyl',
				'Fentanyl_Analogue',
				'Oxycodone',
				'Oxymorphone',
				'Ethanol',
				'Hydrocodone',
				'Benzodiazepine',
				'Methadone',
				'Meth_Amphethamine',
				'Amphet',
				'Tramad',
				'Hydromorphone',
				'Morphine_Not_Heroin',
				'Xylazine',
				'Gabapentin',
				'Opiate_NOS',
				'Heroin_Morph_Codeine']) AS chemical_substance,
	UNNEST(array[Heroin,
				 Cocaine,
				 Fentanyl,
				 Fentanyl_Analogue,
				 Oxycodone,
				 Oxymorphone,
				 Ethanol,
				 Hydrocodone,
				 Benzodiazepine,
				 Methadone,
				 Meth_Amphethamine,
				 Amphet,
				 Tramad,
				 Hydromorphone,
				 Morphine_Not_Heroin,
				 Xylazine,
				 Gabapentin,
				 Opiate_NOS,
				 Heroin_Morph_Codeine]) AS indicator
FROM drugcause) x
WHERE x.indicator = 'Y'
GROUP BY 1,2
ORDER BY 3 DESC;

--To create view to store the age categories with the most deaths data	
CREATE VIEW age_categories_death AS
SELECT
	DISTINCT age_categories,
	COUNT(*) OVER(PARTITION BY age_categories) AS num_of_deaths
FROM
	(SELECT
		age,
			CASE
				WHEN age < 31 THEN 'Adolescent'
				WHEN age >= 31 AND age <= 54 THEN 'Middle age'
				WHEN age >54 THEN 'Old'
			END AS Age_Categories
	FROM DrugDeaths
	WHERE age IS NOT NULL
	ORDER BY 2 DESC) X
ORDER BY 2 DESC;

--To create view to store each year with the corresponding Annual number of deaths data
CREATE VIEW annual_deaths AS
SELECT
	extract(year from date) AS year,
	COUNT(*) AS DeathCount
FROM DrugDeaths
WHERE date_type IN ('Date of death', 'Date reported')
GROUP BY 1
ORDER BY 2;
























