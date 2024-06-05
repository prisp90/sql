/*
What is the population of people aged 90 and above for each country in the latest year?
*/

SELECT *
FROM public.population_and_demography;

select 
country_name,
population_year,
population_90_to_99 + population_100_above as pop_90_above
from public.population_and_demography
where population_year = 2021
and record_type = 'Country'
order by country_name asc;

/*
Which countries have the highest population growth in the last year?
*/

select 
country_name,
population_2020,
population_2021,
population_2021 - population_2020 as pop_growth_num,
round(cast ((population_2021 - population_2020) as decimal) / population_2020 * 100, 2) as pop_growth_pct
from(
	select
	p.country_name,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2020
	) as population_2020,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2021
	) as population_2021
	from population_and_demography p
	where p.record_type = 'Country'
	and p.population_year = 2021
) s
order by pop_growth_num desc;

/*
Which single country has the highest population decline in the last year?
*/

select 
country_name,
population_2020,
population_2021,
population_2021 - population_2020 as pop_growth_num,
round(cast ((population_2021 - population_2020) as decimal) / population_2020 * 100, 2) as pop_growth_pct
from(
	select
	p.country_name,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2020
	) as population_2020,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2021
	) as population_2021
	from population_and_demography p
	where p.record_type = 'Country'
	and p.population_year = 2021
) s
order by pop_growth_num asc 
limit 1;

/*
Which age group had the highest population out of all countries last year?
 */

select *
from population_and_demography
where country_name = 'World'
and population_year = 2021;

select 
unnest(array[
	'population_1_to_9',
	'population_10_to_19',
	'population_20_to_29',
	'population_30_to_39',
	'population_40_to_49',
	'population_50_to_59',
	'population_60_to_69',
	'population_70_to_79',
	'population_80_to_89',
	'population_90_to_99'
]) as age_group,
unnest(array[
	population_1_to_4 + population_5_to_9,
	population_10_to_14 + population_15_to_19,
	population_20_to_29,
	population_30_to_39,
	population_40_to_49,
	population_50_to_59,
	population_60_to_69,
	population_70_to_79,
	population_80_to_89,
	population_90_to_99
]) as population
from population_and_demography
where country_name = 'World'
and population_year = 2021
order by population desc;

/*
What are the top 10 countries with the highest population growth in the last 10 years?
 */

select 
country_name,
population_2011,
population_2021,
population_2021 - population_2011 as pop_growth_num
from(
	select
	p.country_name,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2011
	) as population_2011,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2021
	) as population_2021
	from population_and_demography p
	where p.record_type = 'Country'
	and p.population_year = 2021
) s
order by pop_growth_num asc
limit 10;

/*
Which country has the highest percentage growth since the first year recorded?
 */

create view population_by_year as
select 
country_name,
population_1950,
population_2011,
population_2020,
population_2021
from(
	select
	p.country_name,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 1950
	) as population_1950,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2011
	) as population_2011,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2020
	) as population_2020,
	(
		select p1.population
		from public.population_and_demography p1
		where p1.country_name = p.country_name
		and p1.population_year = 2021
	) as population_2021
	from population_and_demography p
	where p.record_type = 'Country'
	and p.population_year = 2021
) s;

select 
country_name,
population_1950,
population_2021,
round(cast ((population_2021 - population_1950) as decimal) / population_1950 * 100, 2) as pop_growth_pct
from population_by_year
order by pop_growth_pct desc;

/*
Which country has the highest population aged 1 as a percentage of their overall population?
*/

select 
country_name,
population,
population_at_1,
round(cast (population_at_1 as decimal) / population * 100, 2) as pop_ratio
from population_and_demography
where record_type = 'Country'
and population_year = 2021
order by pop_ratio desc;

/*
What is the population of each continent in each year, and how much has it changed in each year?
*/

select 
    country_name,
    population_year,
    population,
    lag(population, 1) over(
        partition by country_name
        order by population_year asc
    ) as pop_previous_year,
    round(
        cast(
            (population - lag(population, 1) over(
                partition by country_name
                order by population_year asc
            )) as decimal
        ) / cast(
            lag(population, 1) over(
                partition by country_name
                order by population_year asc
            ) as decimal
        ) * 100, 2
    ) as population_growth_rate
from population_and_demography
where record_type = 'Continent'
order by country_name asc, population_year asc;

