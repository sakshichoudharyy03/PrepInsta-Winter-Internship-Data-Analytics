# Murder occured on 15th Jan 2018 in SQL City
USE murder_mystery; 
SELECT *
FROM crime_scene_report
WHERE date = "20180115"
AND type = "murder"
AND city = "SQL City";

# 2 witnesses
-- 1st witness
SELECT * 
FROM person
WHERE address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 1;
-- 2nd witness
SELECT * 
FROM person
WHERE address_street_name = "Franklin Ave"
AND name LIKE '%Ann%';

# Finding the two witness' interview transcript
SELECT *
FROM interview
WHERE person_id IN (14887, 16371);


# "Get Fit Now Gym" membership started with "48Z" Gold member
# Car Plate includes "H42W"
# Murderer was in gym on 9th Jan
SELECT p.*
FROM drivers_license AS dl
INNER JOIN person AS p ON dl.id = p.license_id
INNER JOIN get_fit_now_member AS member ON p.id = member.person_id
INNER JOIN get_fit_now_check_in AS ci ON member.id = ci.membership_id
WHERE plate_number LIKE '%H42W%'
AND check_in_date = "20180109";

SELECT * 
FROM interview
WHERE person_id = "67318";

# Rich woman, height 5'5" (65") or 5'7" (67"), red hair, Tesla Model S car, attended SQL Symphony Concert 3 times in Dec 2017
WITH CTE AS (
SELECT person_id,
COUNT(*) AS visits
FROM facebook_event_checkin
WHERE date BETWEEN 20171201 AND 20171231
AND event_name = "SQL Symphony Concert"
GROUP BY person_id
HAVING COUNT(*) = 3
)

SELECT p.*, fb.*
FROM drivers_license AS dl
INNER JOIN person AS p ON dl.id = p.license_id
INNER JOIN CTE AS fb ON p.id = fb.person_id
WHERE height BETWEEN 65 AND 67
AND hair_color = "red"
AND car_make = "Tesla"
AND car_model = "Model S"
AND gender = "female";