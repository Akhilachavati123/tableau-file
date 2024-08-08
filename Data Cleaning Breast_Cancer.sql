use breast_cancer;

select* from brca;

-- DATA CLEANING
-- Removing Duplicates

create table brca2
like brca;

insert brca2
select* from brca;

select* from brca2;

alter table brca2
change column `ï»¿Patient_ID` Patient_ID varchar(255);

with duplicate_cte as
(
select*,
row_number() over(partition by Patient_ID, Age, Gender, Protein1, Protein2, Protein3, Protein4, Tumour_Stage, 
Histology, `ER status`, `PR status`, `HER2 status`, `Surgery_type`, `Date_of_Surgery`, `Date_of_Last_Visit`, Patient_Status) as row_num
from brca2
) 
 select* from duplicate_cte
 where row_num >1;
 
 -- Standardizing the data (Checking for spaces special characters)
 
 select distinct Patient_ID
 from brca2;
 
select distinct Histology
from brca2;

select Date_of_Surgery,
str_to_date(Date_of_Surgery, '%d-%b-%y')
from brca2;

update brca2
set Date_of_Surgery = str_to_date(Date_of_Surgery, '%d-%b-%y');

alter table brca2
modify column Date_of_Surgery date;

select Date_of_Last_Visit,
str_to_date(Date_of_Last_Visit, '%d-%b-%y')
from brca2;

select Date_of_Last_Visit
from brca2
where str_to_date(Date_of_Last_Visit, '%d-%b-%y') is null ;

update brca2
set Date_of_Last_Visit = null
where Date_of_Last_Visit = '';

update brca2
set Date_of_Last_Visit = str_to_date(Date_of_Last_Visit, '%d-%b-%y')
where str_to_date(Date_of_Last_Visit, '%d-%b-%y') is not null;

alter table brca2
modify column Date_of_Last_Visit date;
 
select* from brca2;

-- NULL VALUES (OR) BLANK VALUES

select* from brca2
where Date_of_Surgery is null
and Date_of_Last_Visit is null
and Patient_Status is null;

























