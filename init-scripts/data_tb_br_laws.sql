CREATE TABLE PUBLIC.BR_LAWS (
    LAW_NUMBER VARCHAR(50) NOT NULL,
    LAW_NAME VARCHAR(255) NOT NULL,
    LAW_DESCRIPTION TEXT,
    PITY_YEARS INTEGER,
    LIFE_SENTENCE BOOLEAN DEFAULT FALSE,
    DEATH_PENALTY BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (LAW_NUMBER)
);

INSERT INTO PUBLIC.BR_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES (
    'CP Art. 121, §2º, VII', 
    'Homicídio Funcional (Agente de Segurança Pública)', 
    'Matar integrante das Forças Armadas ou órgãos de segurança pública (policiais, bombeiros, etc.) no exercício da função ou em decorrência dela.', 
    12, 
    FALSE, 
    FALSE
);

-- 2. Roubo / Carjacking de Veículo Automotor
-- Art. 157, § 2º, II/V ou IV do Código Penal
INSERT INTO PUBLIC.BR_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES (
    'CP Art. 157, §2º', 
    'Roubo de Veículo Automotor', 
    'Subtrair veículo automotor mediante violência ou grave ameaça à pessoa, inclusive mantendo a vítima em seu poder ou transportando para outro estado/exterior.', 
    4, 
    FALSE, 
    FALSE
);



-- 4. Roubo Majorado pelo Emprego de Arma de Fogo (Assalto a Estabelecimento Comercial)
-- Art. 157, § 2º-A, I do Código Penal
INSERT INTO PUBLIC.BR_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES (
    'CP Art. 157, §2º-A, I', 
    'Roubo Majorado por Emprego de Arma de Fogo', 
    'Subtrair bem alheio móvel em estabelecimento comercial ou via pública mediante violência ou grave ameaça exercida com emprego de arma de fogo.', 
    6, 
    FALSE, 
    FALSE
);

-- 5. Homicídio Qualificado (Corresponde ao First-Degree Murder)
-- Art. 121, § 2º do Código Penal
INSERT INTO PUBLIC.BR_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES (
    'CP Art. 121, §2º', 
    'Homicídio Qualificado', 
    'Matar alguém mediante paga, promessa de recompensa, motivo fútil, torpe, meio cruel, emboscada ou para assegurar a execução/impunidade de outro crime.', 
    12, 
    FALSE, 
    FALSE
);

