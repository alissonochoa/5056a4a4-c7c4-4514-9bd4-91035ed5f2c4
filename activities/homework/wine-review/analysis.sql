/*
 Instructions:
    - Create a branch named "wine"
    - Solve the data-requests from this file using SQL.
    - Add/Commit/Push your changes to github (individual).
 Note: You can work along with your project team.
 */

-- EX.1) Get the top 10 countries with more population density
SELECT name FROM country WHERE area_km2 = 0;
SELECT
    name,
    (population / area_km2) AS "density"
FROM
    country c
WHERE
    area_km2 > 0
ORDER BY density DESC
LIMIT 10 --Como me pide solo 10, pongo un limite
;

-- EX.2) Get the count of male/female tasters.
SELECT DISTINCT gender FROM taster; -- Valores unicos

SELECT
    gender,
    count(*)
FROM
    taster
WHERE
    LOWER(gender) IN ('male', 'female')
    -- LOWER(gender) != 'undefined'
    -- LOWER(gender) NOT LIKE 'undef%'
    -- LOWER(gender) LIKE '%male'
GROUP BY
    gender
;

-- EX.3) Get the percentage of male/female tasters.
--WITH nombre de una tabla que solo existira en este contexto
WITH taster_valid AS (
    SELECT *
    FROM taster
    WHERE LOWER(gender) IN ('male', 'female')
), taster_gender_agg AS (
    SELECT
    gender,
    COUNT(*):: NUMERIC(7,2) gender_sum --:: cambiar el tipo de dato; 7=int, 2=#decimales
    FROM
    taster_valid
    GROUP BY
    gender
), taster_total AS (
    SELECT
           COUNT(*):: NUMERIC(7,2) total
    FROM
        taster_valid
)
SELECT --desde aqui es la query, lo demás son tablas temporales
    gender,
    TRUNC(100 * gender_sum / total, 2) percentage
FROM
    taster_gender_agg,
     taster_total
;

-- EX.4) How many countries share the same first digit on their country-code?
-- Show only those digits with more than 20 countries.
-- WHERE antes del group by
-- HAVING despues del group by
-- LEFT para poner el primer # de izq a derecha
SELECT  DISTINCT LEFT(code, 1) FROM country;

SELECT
    LEFT(code, 1) first_digit,
    count(*) country_count
FROM
    country
GROUP BY
    first_digit
HAVING
    count(*) > 20
;


-- EX.5) Get the % of countries are not labeled as a trillion usd gdp and
-- do have a null happiness_score.
SELECT count(*) FROM country;
SELECT
    100 * COUNT(*) / MAX(t.total) Percentage
FROM
    country,
     (SELECT count(*) total FROM country) t
WHERE
    --LOWER(split_part(gdp_usd, ' ', 2)) != 'trillion'
    LOWER(gdp_usd) NOT LIKE '%trillion'
    AND happiness_score IS NULL
;


-- COUNTRY ANALYSIS

-- A) Get the average happiness_score of the countries labeled with a GDP
-- of "billion" and "trillion".
SELECT
    AVG(happiness_score) AS "Average of Happines Score"
FROM
    country
WHERE
    gdp_usd = 'Billion' AND gdp_usd = 'Trillion'
;


-- B) Show a table with the country name, population, area, gdp, and happiness core of the
-- the G7 countries (i.e., `Canada`, `France`, `Germany`, `Italy`, `Japan`, `United Kingdom`, `United States`)
-- order by happiness_score (DESC).
SELECT
FROM
;

-- C) Create a custom score called "score" using this formula: happiness_score * density
-- Where `density` is population / area_km2. Show the top 10 countries (name) with greater score.
SELECT
FROM
;

-- WINE ANALYSIS

-- D) Get the number of wines per variety, ordered by the latter (desc)
SELECT
FROM
;

-- E) How many wines are registered per country? Show country name and number of wines, ordered by the latter (desc).
SELECT
FROM
;


-- REVIEW ANALYSIS

-- F) What's the average wine price and points per province?
-- Show the province, avg-price, avg-points when the avg-points are grater than 85.
-- Ordered by avg-price and then by avg-points.


-- G) What's the average wine price and points of the countries with more than a 7 in their happiness score?
-- Show the country, avg-price, avg-points.
-- Ordered by avg-points and then by avg-price.


-- H) What's the min, avg, and max wine points per taster gender (excluding undefined) and wine variety starting with "Cabernet".
-- Order by: variety, gender


-- I) Create the following custom score called "wine_quality_and_happiness_index": happiness_score * avg(points) / 100
-- Get the score per country and order by the value (desc).

