-- Utworz strukture bazy danych na podstawie diagrammu klas

CREATE TABLE Przedmioty (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ilosc INTEGER,
    rodzaj VARCHAR(20),
    nazwa VARCHAR(20),
    cena_jednostkowa INTEGER
);

CREATE TABLE  SL_RodzajZnizki (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nazwa VARCHAR(20)
);

CREATE TABLE  SL_RodzajDokumentu (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nazwa VARCHAR(20)
);


CREATE TABLE Zakup (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_zawarcia_umowy TIMESTAMP,
    id_znizki INTEGER NOT NULL REFERENCES SL_RodzajZnizki(id),
    id_klienta INTEGER NOT NULL REFERENCES Klient(id),
    id_sklepu INTEGER NOT NULL REFERENCES Sklep(id),
    data_wysylki TIMESTAMP,
    data_odbioru TIMESTAMP,
    kwota_ostateczna INTEGER
);

CREATE TABLE Faktura(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    numer VARCHAR(50),
    id_dokumentu INTEGER NOT NULL REFERENCES SL_RodzajDokumentu(id),
    id_zakupu INTEGER NOT NULL REFERENCES Zakup(id)
);

CREATE TABLE Klient (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    kod_pocztowy VARCHAR(20),
    imie VARCHAR(40),
    nazwisko VARCHAR(50),
    nip VARCHAR(40),
    adres_nr_lokalu VARCHAR(40),
    id_adresu INTEGER NOT NULL REFERENCES Adres(id)
);

CREATE TABLE Adres(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    miejscowosc VARCHAR(40),
    ulica VARCHAR(40),
    nr_adresowy VARCHAR(20)
);


CREATE TABLE Sklep(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nazwa VARCHAR(40),
    adres_id INTEGER NOT NULL REFERENCES Adres(id),
    kod_poczt VARCHAR(20),
    nip VARCHAR(40),
    tel VARCHAR(20),
    email VARCHAR(40),
    os_kontaktowa VARCHAR(40),
    fax VARCHAR(20),
    www VARCHAR(40)
);

CREATE TABLE int_przedmioty_zakup(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_zakupu INTEGER NOT NULL REFERENCES Zakup(id),
    id_przedmiotu INTEGER NOT NULL REFERENCES Przedmioty(id)
);

INSERT INTO SL_RodzajZnizki VALUES (1, 'promocja A');
INSERT INTO SL_RodzajZnizki VALUES (2, 'promocja B');
INSERT INTO SL_RodzajZnizki VALUES (3, 'promocja C');

INSERT INTO SL_RodzajDokumentu VALUES (1, 'paragon');
INSERT INTO SL_RodzajDokumentu VALUES (2, 'faktura');

-- przykladowe dane do kwerendy

INSERT INTO Adres VALUES (1, 'Warszawa', 'Marszalkowska', '1');

INSERT INTO Sklep VALUES (1, 'Sklep1', 1, '00-000', '1234567890', '123456789', 'dawda@dadw.com', 'Jan Kowalski', '123456789', 'www.sklep1.pl');

INSERT INTO Klient VALUES (1, '00-000', 'Jan', 'Kowalski', '1234567890', '1', 1);

INSERT INTO Zakup VALUES (1, 4312, 1, 1, 1, 4312, 4312, 100);

-- Utwórz w bazie kwerendę, która wyświetli listę o postaci:
-- nazwa sklepu, łączna liczba zakupów

SELECT Sklep.nazwa, COUNT(Zakup.id) AS liczba_zakupow
FROM Sklep
INNER JOIN Zakup ON Sklep.id = Zakup.id_sklepu
GROUP BY Sklep.nazwa;

CREATE VIEW Zakupy_Sklepow AS
SELECT Sklep.nazwa, COUNT(Zakup.id) AS liczba_zakupow
FROM Sklep
INNER JOIN Zakup ON Sklep.id = Zakup.id_sklepu
GROUP BY Sklep.nazwa;
