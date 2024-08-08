use crop_yields;

select* from crop_yield;

-- DATA CLEANING
-- REMOVING DUPLICATES IF ANY

create table crop_yield2
like crop_yield;

insert crop_yield2
select* from crop_yield;

select* from crop_yield2;

with duplicate_cte as
(
select*,
row_number() over(partition by Crop, Crop_Year, Season, State, Area, Production, Annual_Rainfall, Fertilizer, Pesticide, Yield) as row_num
from crop_yield2
) 
 select* from duplicate_cte
 where row_num >1;
 
 -- STANDARDIZING THE NULL VALUES
 -- Removing spaces
 select distinct (trim(Crop))
 from crop_yield2;
 
 update crop_yield2
 set Crop = trim(Crop);
 
 select distinct Season
 from crop_yield2
 order by 1;
 
 select distinct (trim(Season))
 from crop_yield2;
 
 update crop_yield2
 set Season = trim(Season);
 
 select distinct State
 from crop_yield2;
 
 select* from crop_yield2;
 
 -- NULL VALUES (OR) BLANK VALUES
 
 select * from crop_yield2
 where Annual_Rainfall is null
 and Fertilizer is null;
 

 
 
 
 
 
 
 
 
 
 
 