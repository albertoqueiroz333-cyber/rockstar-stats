CREATE TABLE PUBLIC.USA_LAWS (
    LAW_NUMBER VARCHAR(50) NOT NULL,
    LAW_NAME VARCHAR(255) NOT NULL,
    LAW_DESCRIPTION TEXT,
    PITY_YEARS INTEGER,
    LIFE_SENTENCE BOOLEAN NOT NULL,
    DEATH_PENALTY BOOLEAN NOT NULL,
    PRIMARY KEY (LAW_NUMBER)
);

INSERT INTO PUBLIC.USA_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES ('CPC 187 / CPC 190.2(a)(7)', 'Murder of a Peace Officer / Capital Murder', 'Assassinar um agente de segurança pública (policial, bombeiro, etc.) no exercício de suas funções, sabendo ou devendo saber de sua condição.', 25, TRUE, TRUE);

INSERT INTO PUBLIC.USA_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES ('CPC 215', 'Carjacking', 'Tomada ilegítima de um veículo motorizado da posse direta ou presença imediata de outra pessoa, contra a sua vontade, mediante força ou medo.', 3, FALSE, FALSE);


-- Assalto à Mão Armada em Estabelecimento Comercial (2º Grau + Qualificadora de Arma)
INSERT INTO PUBLIC.USA_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES (
    'CPC 211 / CPC 12022.53', 
    'Armed Robbery (Second-Degree)', 
    'Subtrair propriedade de outrem ou de um estabelecimento comercial contra a vontade da vítima, mediante o uso de força, medo e arma de fogo.', 
    15, 
    FALSE, 
    FALSE
);

INSERT INTO PUBLIC.USA_LAWS (LAW_NUMBER, LAW_NAME, LAW_DESCRIPTION, PITY_YEARS, LIFE_SENTENCE, DEATH_PENALTY) 
VALUES ('CPC 187(a)-1', 'First-Degree Murder', 'Homicídio ilícito de um ser humano com premeditação, deliberação e malícia prévia (malice aforethought).', 25, TRUE, FALSE);

