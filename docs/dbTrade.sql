CREATE TABLE PRODUTOR(
	id	int not null primary key,
	cnpj	varchar(14) unique,
	nome	varchar(50) unique
);

CREATE TABLE TRADE(
	id	int not null primary key,
	cnpj	varchar(14) unique,
	nome	varchar(50) unique
);

CREATE TABLE GRAO(
	id	int not null primary key,
	nome	varchar(50) unique
);

CREATE TABLE CONTRATO(
	id	int not null primary key,
	idProdutor	int not null,
	idTrade		int not null,
	idGrao		int not null,
	quantidade	decimal(6,3),
	dtEmissao	timestamp default current_timestamp,
	dtVigencia	timestamp,
	foreign key (idProdutor) references PRODUTOR(id),
	foreign key (idTrade) references TRADE(id),
	foreign key (idGrao) references GRAO(id)
);

CREATE TABLE SILO(
	idTrade		int not null,
	idContrato	int not null,	
	identificador	varchar(20),
	quantidade	decimal(6,3),
	foreign key (idTrade) references TRADE(id),
	foreign key (idContrato) references CONTRATO(id)
);

CREATE GENERATOR gen_idProdutor;
CREATE GENERATOR gen_idTrade;
CREATE GENERATOR gen_idGrao;
CREATE GENERATOR gen_idContrato;

CREATE TRIGGER tgProdutor for Produtor
BEFORE INSERT position 0
AS
BEGIN
    new.id = gen_id(gen_idProdutor,1);
END;

CREATE TRIGGER tgTrade for Trade
BEFORE INSERT position 0
AS
BEGIN
    new.id = gen_id(gen_idTrade,1);
END;

CREATE TRIGGER tgGrao for Grao
BEFORE INSERT position 0
AS
BEGIN
    new.id = gen_id(gen_idGrao,1);
END;

CREATE TRIGGER tgContrato for Contrato
BEFORE INSERT position 0
AS
BEGIN
    new.id = gen_id(gen_idContrato,1);
END;

CREATE TRIGGER tgDistribuirGraos for Contrato
AFTER INSERT position 0
AS
BEGIN
    execute procedure pDistribuirGraos(:idTrade, :id, :quantidade);
END;

CREATE PROCEDURE pdistribuirgraos (
    idtradetgdist integer,
    idcontratotgdist integer,
    quantidadetgdist decimal(6,3))
AS
	declare qtdesilo integer;
	declare restosilo integer;
	declare capacidadesilo decimal(6,3);
BEGIN
    capacidadeSilo = 10;
    qtdeSilo = cast(quantidadeTgDist/capacidadeSilo as integer);
    restoSilo = mod(quantidadeTgDist, capacidadeSilo);

    if (qtdeSilo >= 1) then
    BEGIN
        while (qtdeSilo >= 1) do
        begin
            insert into Silo (idTrade, idContrato, identificador, quantidade) values (:idTradeTgDist, :idContratoTgDist, 0, :capacidadeSilo);
            qtdeSilo = qtdeSilo - 1;
        end
    END

    if (restoSilo > 0) then
        insert into Silo (idTrade, idContrato, identificador, quantidade) values (:idTradeTgDist, :idContratoTgDist, 0, :restoSilo);
END
