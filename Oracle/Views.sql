CREATE VIEW RezerwacjeWszystkie
AS
SELECT
w.ID_WYCIECZKI,
w.NAZWA,
w.KRAJ,
w.DATA,
o.IMIE,
o.NAZWISKO,
r.STATUS
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY;

CREATE VIEW RezerwacjePotwierdzone
AS
SELECT
w.KRAJ,
w.DATA,
w.NAZWA,
o.IMIE,
o.NAZWISKO,
r.STATUS
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
WHERE r.STATUS = 'Z' OR r.STATUS = 'P';

CREATE VIEW RezerwacjeWPrzyszłości
AS
SELECT
w.KRAJ,
w.DATA,
w.NAZWA,
o.IMIE,
o.NAZWISKO,
r.STATUS
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
WHERE w.DATA > CURRENT_DATE;

CREATE VIEW WycieczkiMiejsca
AS
SELECT
w.ID_WYCIECZKI,
w.NAZWA,
w.KRAJ,
w.DATA,
w.LICZBA_MIEJSC,
(w.LICZBA_MIEJSC -
 (SELECT COUNT(*) FROM REZERWACJE r WHERE r.ID_WYCIECZKI = w.ID_WYCIECZKI AND r.status <> 'A' ))
    AS LICZBA_WOLNYCH_MIEJSC
FROM WYCIECZKI w
GROUP BY w. ID_WYCIECZKI, w.NAZWA, w.KRAJ, w.DATA, w.LICZBA_MIEJSC;


CREATE VIEW WycieczkiDostępne
AS
SELECT
w.ID_WYCIECZKI,
w.KRAJ,
w.DATA,
w.NAZWA,
w.LICZBA_MIEJSC,
(w.LICZBA_MIEJSC -
 (SELECT COUNT(*) FROM REZERWACJE r WHERE r.ID_WYCIECZKI = w.ID_WYCIECZKI AND r.status <> 'A' ))
    AS LICZBA_WOLNYCH_MIEJSC
FROM WYCIECZKI w
WHERE w.DATA > CURRENT_DATE;

CREATE VIEW RezerwcjeDoAnulowania
AS
SELECT w.ID_WYCIECZKI,
       w.NAZWA,
       r.STATUS,
       o.IMIE,
       o.NAZWISKO
FROM REZERWACJE r
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
JOIN WYCIECZKI w ON r.ID_WYCIECZKI = w.ID_WYCIECZKI
WHERE r.STATUS = 'N' AND  w.DATA - CURRENT_DATE < 14;