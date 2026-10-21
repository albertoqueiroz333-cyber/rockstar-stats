WITH
    dados AS (
        SELECT
            g.player_id,
            bl.law_number,
            CASE
                WHEN bl.law_number = 'CP Art. 121, §2º, VII' THEN concat(
                    to_char(
                        g.cops_killed * bl.pity_years,
                        'FM999G999G999G999'
                    ),
                    ' years'
                )
                WHEN bl.law_number = 'CP Art. 157, §2º' THEN concat(
                    to_char(
                        g.vehicles_stolen * bl.pity_years,
                        'FM999G999G999G999'
                    ),
                    ' years'
                )
                WHEN bl.law_number = 'CP Art. 157, §2º-A, I' THEN concat(
                    to_char(
                        g.murdered_civilians * bl.pity_years,
                        'FM999G999G999G999'
                    ),
                    ' years'
                )
                WHEN bl.law_number = 'CP Art. 121, §2º' THEN concat(
                    to_char(
                        g.store_hold_ups * bl.pity_years,
                        'FM999G999G999G999'
                    ),
                    ' years'
                )
            END AS anos_pena
        FROM gta g
            JOIN br_laws bl ON 1 = 1
        WHERE
            g.player_id = 'sabia013'
    )
SELECT player_id, law_number, anos_pena
FROM dados
UNION ALL
SELECT DISTINCT
    player_id,
    'sentença final em anos' AS law_number,
    CONCAT(
        to_char(
            SUM(
                CAST(
                    regexp_replace(anos_pena, '[^0-9]', '', 'g') AS bigint
                )
            ) OVER (),
            'FM999G999G999G999'
        ),
        ' years'
    ) AS anos_pena
FROM dados