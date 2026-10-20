WITH
    dados AS (
        SELECT
            g.player_id,
            ul.law_number,
            CASE
                WHEN ul.law_number = 'CPC 187 / CPC 190.2(a)(7)' THEN CASE
                    WHEN g.cops_killed > 5 THEN 'death_penalty'
                    WHEN g.cops_killed > 2 THEN 'life_sentence'
                    ELSE concat(
                        g.cops_killed * ul.pity_years,
                        ' years'
                    )
                END
                WHEN ul.law_number = 'CPC 215' THEN concat(
                    g.vehicles_stolen * ul.pity_years,
                    ' years'
                )
                WHEN ul.law_number = 'CPC 187(a)-1' THEN CASE
                    WHEN g.murdered_civilians > 10 THEN 'life_sentence'
                    ELSE concat(
                        g.murdered_civilians * ul.pity_years,
                        ' years'
                    )
                END
                WHEN ul.law_number = 'CPC 211 / CPC 12022.53' THEN concat(
                    g.store_hold_ups * ul.pity_years,
                    ' years'
                )
            END AS anos_pena
        FROM gta g
            JOIN usa_laws ul ON 1 = 1
        WHERE
            g.player_id = 'sabia013'
    )
SELECT player_id, law_number, anos_pena
FROM dados
UNION ALL
SELECT DISTINCT
    player_id,
    'sentença final em anos' AS law_number,
    CASE
        WHEN MAX(
            CASE
                WHEN trim(anos_pena) = 'death_penalty' THEN 1
                ELSE 0
            END
        ) OVER () > 0 THEN 'death_penalty'
        WHEN MAX(
            CASE
                WHEN trim(anos_pena) = 'life_sentence' THEN 1
                ELSE 0
            END
        ) OVER () > 0 THEN 'life_sentence'
        ELSE CONCAT(
            to_char(
                SUM(
                    CAST(
                        regexp_replace(anos_pena, '[^0-9]', '', 'g') AS bigint
                    )
                ) FILTER (
                    WHERE
                        trim(anos_pena) NOT IN (
                            'life_sentence',
                            'death_penalty'
                        )
                        AND anos_pena IS NOT NULL
                ) OVER (),
                'FM999G999G999G999'
            ),
            ' years'
        )
    END AS anos_pena
FROM dados