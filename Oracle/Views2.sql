CREATE VIEW WycieczkiMiejsca2
AS
SELECT
w.ID_WYCIECZKI,
w.NAZWA,
w.KRAJ,
w.DATA,
w.LICZBA_MIEJSC,
w.LICZBA_WOLNYCH_MIEJSC
FROM WYCIECZKI w;



CREATE VIEW WycieczkiDostępne2
AS
SELECT
w.ID_WYCIECZKI,
w.KRAJ,
w.DATA,
w.NAZWA,
w.LICZBA_MIEJSC,
w.LICZBA_WOLNYCH_MIEJSC
FROM WYCIECZKI w
WHERE w.DATA > CURRENT_DATE;
