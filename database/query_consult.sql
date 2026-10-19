SELECT
    law_number,
    CASE
        WHEN law_number = 'CPC 187 / CPC 190.2(a)(7)' THEN (cops_killed * pity_years)
        WHEN law_number = 'CPC 215' THEN (vehicles_stolen * pity_years)
        WHEN law_number = 'CPC 187(a)-1' THEN (murdered_civilians * pity_years)
    END AS anos_pena
FROM
    gta
    JOIN usa_laws ON 1 = 1