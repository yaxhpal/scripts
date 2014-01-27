SELECT DISTINCT * FROM `koha`.`authorised_values` WHERE category = 'NOT_LOAN' ORDER BY authorised_value;

SELECT DISTINCT * FROM `koha`.`authorised_values` WHERE category = 'LOST' ORDER BY authorised_value;

SELECT DISTINCT * FROM `koha`.`authorised_values` WHERE category = 'WITHDRAWN' ORDER BY authorised_value;

SELECT DISTINCT * FROM `koha`.`authorised_values` WHERE category = 'DAMAGED' ORDER BY authorised_value;

SELECT DISTINCT category  FROM `koha`.`authorised_values`;