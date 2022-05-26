CREATE TABLE tprodutor
(
    tprodutor_id varchar(38) not null primary key,
    tprodutor_nome varchar(100) not null,
    tprodutor_cnpj varchar(18) not null unique
);

CREATE TABLE ttrader
(
    ttrader_id varchar(38) not null primary key,
    ttrader_nome varchar(100) not null,
    ttrader_qtde_silos integer,
    ttrader_armazenamento float not null,
    ttrader_cnpj varchar(18) not null unique
);


CREATE TABLE tcontrato
(
    tcontrato_id varchar(38) not null primary key,
    tcontrato_id_produtor varchar(38) not null,
    tcontrato_id_trader varchar(38) not null,
    tcontrato_nome_prod varchar(100) not null,
    tcontrato_tipo_grao varchar(15) not null,
    tcontrato_data_contrato timestamp,
    tcontrato_kg_grao float,
    CONSTRAINT FK_TCONTRATO_ID_PRODUTOR FOREIGN KEY (tcontrato_id_produtor) REFERENCES TPRODUTOR (TPRODUTOR_ID),
    CONSTRAINT FK_TCONTRATO_ID_TRADER   FOREIGN KEY (tcontrato_id_trader) REFERENCES TTRADER (TTRADER_ID)
);

