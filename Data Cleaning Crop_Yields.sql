use crop_yields;

select* from crop_yield;

create table crop_yield2
like crop_yield;

insert crop_yield2
select* from crop_yield;

select* from crop_yield2;

-- DATA CLEANING
-- REMOVING DUPLICATES IF ANY
with duplicate_cte as
(
select*, 
row_number() over(partition by Crop, Crop_Year, Season, State, Area, Production, Annual_Rainfall, Fertilizer, Pesticide, Yield) as row_num
from crop_yield2
)
 select*
 from duplicate_cte
 where row_num >1;
 
 CREATE TABLE `crop_yield3` (
  `Crop` text,
  `Crop_Year` int DEFAULT NULL,
  `Season` text,
  `State` text,
  `Area` int DEFAULT NULL,
  `Production` int DEFAULT NULL,
  `Annual_Rainfall` double DEFAULT NULL,
  `Fertilizer` double DEFAULT NULL,
  `Pesticide` double DEFAULT NULL,
  `Yield` double DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select* from crop_yield3;

insert into crop_yield3
select*, 
row_number() over(partition by Crop, Crop_Year, Season, State, Area, Production, Annual_Rainfall, Fertilizer, Pesticide, Yield) as row_num
from crop_yield2;

select*  
from crop_yield3
where row_num >1;

delete
from crop_yield3
where row_num >1;

-- STANDARDIZING THE DATA
select distinct Crop
from crop_yield3;

select distinct Season
from crop_yield3;

select distinct State
from crop_yield3;

-- NULL VALUES (OR) BLANK VALUES
select Fertilizer
from crop_yield3
where Fertilizer is null;

select Area
from crop_yield3
where Area is null;

select *
from crop_yield3
where Area is null
and Production is null
and Annual_Rainfall is null
and Fertilizer is null
and Pesticide is null
and Yield is null;

-- REMOVING ANY COLUMNS
alter table crop_yield3
drop column row_num;

select* from crop_yield3;