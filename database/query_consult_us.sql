SELECT
    g.player_id,
    ul.law_number,
    CASE
        WHEN ul.law_number = 'CPC 187 / CPC 190.2(a)(7)' THEN CASE
            WHEN g.cops_killed > 2 THEN 'life_sentence'
            WHEN g.cops_killed > 5 THEN 'death_penalty'
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
            WHEN g.murdered_civilians > 2 THEN 'life_sentence'
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
    g.player_id = 'sabia013';