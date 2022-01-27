DROP TABLE miejscowosc CASCADE CONSTRAINTS;
DROP TABLE apteka CASCADE CONSTRAINTS;
DROP TABLE farmaceuta CASCADE CONSTRAINTS;
DROP TABLE produc CASCADE CONSTRAINTS;
DROP TABLE doktor CASCADE CONSTRAINTS;
DROP TABLE pacjent CASCADE CONSTRAINTS;
DROP TABLE lek CASCADE CONSTRAINTS;
DROP TABLE listalekow CASCADE CONSTRAINTS;
DROP TABLE recepta CASCADE CONSTRAINTS;
DROP TABLE bez_recepty CASCADE CONSTRAINTS;
DROP TABLE stanowisko CASCADE CONSTRAINTS;
DROP TABLE typ_leku CASCADE CONSTRAINTS;
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE miejscowosc (
    id_miejsco   NUMBER(7) NOT NULL PRIMARY KEY,
    nazwa        VARCHAR2(30) NOT NULL,
    kod_pocztowy VARCHAR2(6) NOT NULL
);

CREATE TABLE apteka (
    id_apteka              NUMBER(7) NOT NULL PRIMARY KEY,
    nazwa                  VARCHAR2(25) NOT NULL,
    ulica                  VARCHAR2(25) NOT NULL,
    numer                  NUMBER(3) NOT NULL,
    telefon                NUMBER(9) NOT NULL,
    iloscstanowisk         NUMBER(1) NOT NULL,
    iloscpracownikow       NUMBER(1) NOT NULL,
    miejscowosc_id_miejsco NUMBER(7) NOT NULL,
    CONSTRAINT apteka_miejscowosc_fk FOREIGN KEY ( miejscowosc_id_miejsco ) REFERENCES miejscowosc ( id_miejsco )
);

CREATE TABLE farmaceuta (
    id_farm  NUMBER(7) NOT NULL PRIMARY KEY,
    imie     VARCHAR2(25) NOT NULL,
    nazwisko VARCHAR2(25) NOT NULL,
    plec     VARCHAR2(11) NOT NULL,
    CONSTRAINT plec_check CHECK (plec = 'Mezczyzna' OR plec = 'Kobieta')
);

CREATE TABLE produc (
    id_prod          NUMBER(7) NOT NULL PRIMARY KEY,
    nazwa_producenta VARCHAR2(25) NOT NULL,
    adres_firmy      VARCHAR2(25) NOT NULL,
    telefon          NUMBER(9) NOT NULL,
    produkt_krajowy  VARCHAR2(3),
    CONSTRAINT kraj_check CHECK (produkt_krajowy = 'Tak' OR produkt_krajowy = 'Nie')
);

CREATE TABLE doktor (
    id_doktor              NUMBER(7) NOT NULL PRIMARY KEY,
    imie                   VARCHAR2(25) NOT NULL,
    nazwisko               VARCHAR2(25) NOT NULL,
    telefon                NUMBER(9),
    plec                   VARCHAR2(11) NOT NULL,
    lata_pracy             NUMBER(2) NOT NULL,
    miejscowosc_id_miejsco NUMBER(7) NOT NULL,
    CONSTRAINT plec_doktor_check CHECK (plec = 'Mezczyzna' OR plec = 'Kobieta'),	
    CONSTRAINT doktor_miejscowosc_fk FOREIGN KEY ( miejscowosc_id_miejsco ) REFERENCES miejscowosc ( id_miejsco )
);

CREATE TABLE pacjent (
    id_pacjent             NUMBER(7) NOT NULL PRIMARY KEY,
    imie                   VARCHAR2(25) NOT NULL,
    nazwisko               VARCHAR2(25) NOT NULL,
    pesel                  NUMBER(11) NOT NULL,
    wiek                   NUMBER(3) NOT NULL,
    miejscowosc_id_miejsco NUMBER(7) NOT NULL,
    CONSTRAINT pacjent_miejscowosc_fk FOREIGN KEY ( miejscowosc_id_miejsco ) REFERENCES miejscowosc ( id_miejsco )
);

CREATE TABLE lek (
    id_lek              NUMBER(7) NOT NULL PRIMARY KEY,
    nazwa               VARCHAR2(25) NOT NULL,
    ilosc_opako         NUMBER(2) NOT NULL,
    cena                NUMBER(8, 2),
    dawka_tabletek      VARCHAR2(25) NOT NULL,
    produc_id_prod      NUMBER(7) NOT NULL,
    CONSTRAINT lek_produc_fk FOREIGN KEY ( produc_id_prod ) REFERENCES produc ( id_prod )
);

CREATE TABLE listalekow (
    id_listalekow      NUMBER(7) NOT NULL PRIMARY KEY,
    ilosc              NUMBER(2) NOT NULL,
    lek_id_lek    NUMBER(7) NOT NULL,
    CONSTRAINT listalekow_lek_fk FOREIGN KEY ( lek_id_lek ) REFERENCES lek ( id_lek )
);

CREATE TABLE recepta (
    id_recepta         NUMBER(7) NOT NULL PRIMARY KEY,
    data_wystaw        DATE NOT NULL,
    e_recepta          VARCHAR2(5),
    recepta_papierowa  VARCHAR2(5),
    doktor_id_doktor   NUMBER(7) NOT NULL,
    pacjent_id_pacjent NUMBER(7) NOT NULL,
    farmaceuta_id_farm NUMBER(7) NOT NULL,
    listalekow_id_listalekow NUMBER(7) NOT NULL,
    CONSTRAINT e_recepta1_check CHECK (e_recepta = 'Tak' OR e_recepta = 'Nie'),
    CONSTRAINT recepta_papier1_check CHECK (recepta_papierowa = 'Tak' OR recepta_papierowa = 'Nie'),
    CONSTRAINT recepta_doktor_fk FOREIGN KEY ( doktor_id_doktor ) REFERENCES doktor ( id_doktor ),
    CONSTRAINT recepta_farmaceuta_fk FOREIGN KEY ( farmaceuta_id_farm ) REFERENCES farmaceuta ( id_farm ),
    CONSTRAINT recepta_listalekow_fk FOREIGN KEY ( listalekow_id_listalekow ) REFERENCES listalekow ( id_listalekow ),
    CONSTRAINT recepta_pacjent_fk FOREIGN KEY ( pacjent_id_pacjent ) REFERENCES pacjent ( id_pacjent )
);

CREATE TABLE bez_recepty (
    id_bezr                  NUMBER(7) NOT NULL PRIMARY KEY,
    data_wystaw              DATE NOT NULL,
    e_recepta                VARCHAR2(3),
    recepta_papierowa        VARCHAR2(3),
    listalekow_id_listalekow NUMBER(7) NOT NULL,
    farmaceuta_id_farm       NUMBER(7) NOT NULL,
    CONSTRAINT e_recepta2_check CHECK (e_recepta = 'Tak' OR e_recepta = 'Nie'),
    CONSTRAINT recepta_papier2_check CHECK (recepta_papierowa = 'Tak' OR recepta_papierowa = 'Nie'),
    CONSTRAINT bez_recepty_farmaceuta_fk FOREIGN KEY ( farmaceuta_id_farm ) REFERENCES farmaceuta ( id_farm ),
    CONSTRAINT bez_recepty_listalekow_fk FOREIGN KEY ( listalekow_id_listalekow ) REFERENCES listalekow ( id_listalekow )
);

CREATE TABLE stanowisko (
    id_stanow          NUMBER(7) NOT NULL PRIMARY KEY, 
    numer_stanowiska   NUMBER(2) NOT NULL,
    max_osob           NUMBER(1) NOT NULL,
    farmaceuta_id_farm NUMBER(7) NOT NULL,
    CONSTRAINT stanowisko_farmaceuta_fk FOREIGN KEY ( farmaceuta_id_farm ) REFERENCES farmaceuta ( id_farm )
);

CREATE TABLE typ_leku (
    id_typleku    NUMBER(7) NOT NULL PRIMARY KEY,
    forma         VARCHAR2(28) NOT NULL,
    dla_dzieci    VARCHAR2(3),
    dla_doroslych VARCHAR2(3),
    przechowanie  VARCHAR2(28),
    lek_id_lek    NUMBER(7) NOT NULL,
    CONSTRAINT dla_dzieci_check CHECK (dla_dzieci = 'Tak' OR dla_dzieci = 'Nie'),
    CONSTRAINT dla_doroslych_check CHECK (dla_doroslych = 'Tak' OR dla_doroslych = 'Nie'),
    CONSTRAINT typ_leku_lek_fk FOREIGN KEY ( lek_id_lek ) REFERENCES lek ( id_lek )
);








 



