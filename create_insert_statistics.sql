/*
Ivan Costa de Sousa
N.USP; 9292754
P1
*/

/* Comando para criar e entrar no banco de dados*/
CREATE DATABASE bdcovid;
\c bdcovid

/* Comandos para a criação das tabelas*/

CREATE TABLE EXAMES(
    ID SERIAL PRIMARY KEY,	
    PACIENTE VARCHAR(255) NOT NULL,
	ATENDIMENTO VARCHAR(255) NOT NULL,
	DATACOLETA DATE NOT NULL,
	ORIGEM TEXT NOT NULL,
	EXAME VARCHAR(255) NOT NULL,
	ANALITO VARCHAR(255),
	RESULTADO TEXT,
	UNIDADE VARCHAR(255),
	VALORREFERENCIA TEXT,
    HOSPITAL INT,
        
    CONSTRAINT FK_PACIENTE 
        FOREIGN KEY(PACIENTE)
        REFERENCES PACIENTES(ID) 
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT FK_HOSPITAL 
        FOREIGN KEY(HOSPITAL)
        REFERENCES HOSPITAIS(ID)
        ON DELETE CASCADE ON UPDATE CASCADE 
);


CREATE TABLE PACIENTES(
    ID VARCHAR(32) PRIMARY KEY,
    SEXO CHAR(1) NOT NULL,
    ANONASCIMENTO INT NOT NULL,
    PAISRES CHAR(2) NOT NULL,
    UF CHAR(2) NOT NULL,
    MUNICIPIO VARCHAR(255) NOT NULL,
    CEP VARCHAR(5) NOT NULL
);

CREATE TABLE DESFECHOS(
    PACIENTE VARCHAR(35) NOT NULL,
    IDATENDIMENTO VARCHAR(255) PRIMARY KEY,
    DATAATENDIMENTO DATE NOT NULL,
    TIPOATENDIMENTO TEXT,
    IDCLINICA INT NOT NULL,
    CLINICA TEXT,
    DATADESFECHO DATE,
    DESFECHO TEXT,

    CONSTRAINT FK_PACIENTE 
        FOREIGN KEY(PACIENTE)
        REFERENCES PACIENTES(ID) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE HOSPITAIS(
    ID INT PRIMARY KEY,
    SIGLA CHAR(3),
    NOME VARCHAR(255)
);


/*Inserção para a tabela hospitais*/
INSERT INTO HOSPITAIS VALUES(1,'HC', 'HOSPITAL DAS CLÍNICAS DA FACULDADE DE MEDICINA DA UNIVERSIDADE DE SÃO PAULO');
INSERT INTO HOSPITAIS VALUES(2,'HSL', 'HOSPITAL SÍRIO-LIBANÊS');

/* Utilizando o comando COPY para inserção dos dados nas tabelas, os arquivos xxx1 e xxx2 são arquivos tatados de pacientes e exames*/
COPY pacientes
FROM '/home/ivan/Área de Trabalho/Lab BD/HC_Janeiro2021/xxx1.csv'
DELIMITER '|'
csv HEADER;
/*AAAA = 0 YYYY = 1 -- esse tratamento feito em python */

COPY EXAMES
FROM '/home/ivan/Área de Trabalho/Lab BD/HC_Janeiro2021/xxx2.csv'
DELIMITER ','
csv HEADER;
/*incluido no arquivo o id hospital e substituido os campos com "," para "." - feito esse tratamento em python*/

COPY DESFECHOS
FROM '/home/ivan/Área de Trabalho/Lab BD/HSL_Janeiro2021/HSL_Desfechos_3.csv'
DELIMITER '|'
csv HEADER;
/* campo da data quando DDMMAA = null*/


/*Comandos para as analises solicitadas e para verificação; os resultado estão comentados*/
SELECT * FROM DESFECHOS;
SELECT COUNT(ATENDIMENTO) FROM DESFECHOS; /* 42691*/

SELECT * FROM PACIENTES;
SELECT COUNT(ID) FROM PACIENTES; /* 12722*/

SELECT * FROM EXAMES;
SELECT COUNT(ATENDIMENTO) FROM EXAMES; /*  3962484 */

select count(distinct id) from pacientes;/* 12722*/
select count(distinct exame) from exames; /* 1098 */

