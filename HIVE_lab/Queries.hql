---------------------------------------------------------
--------------REQUETES SIMPLES: -------------------------
---------------------------------------------------------
select 
    * 
from clients;

select 
    * 
from hotels_partitioned 
where ville = 'Paris';

SELECT 
    R.*,
    H.*,
    C.*
FROM reservations_bucketed R
INNER JOIN CLIENTS C
    ON C.CLIENT_ID = R.CLIENT_ID
INNER JOIN hotels_partitioned H
    ON R.hotel_id = H.hotel_id;    


---------------------------------------------------------
--------------REQUETES AVEC JOINTURES: ------------------
---------------------------------------------------------

SELECT C.NOM NOM_CLIENT, COUNT(R.RESERVATION_ID) NOMBER_RESERVATIONS 
FROM RESERVATIONS R
INNER JOIN clients C
ON C.CLIENT_ID = R.CLIENT_ID
GROUP BY C.NOM;


SELECT C.NOM AS CLIENT , H.NOM AS HOTEL
FROM CLIENTS C
INNER JOIN RESERVATIONS R 
    ON C.CLIENT_ID = R.CLIENT_ID
INNER JOIN HOTELS H 
    ON R.hotel_id = H.hotel_id;


--Afficher les noms des hôtels dans lesquels il y a plus qu’une réservation.
SELECT  H.nom
FROM HOTELS H
INNER JOIN RESERVATIONS R
    ON R.HOTEL_ID = H.HOTEL_ID
GROUP BY  H.NOM
having count(R.RESERVATION_ID)>1;





-- Afficher les noms des hôtels dans lesquels il y a pas de réservation.
SELECT H.NOM AS HOTELS_NON_RESERVES
FROM HOTELS H
LEFT OUTER JOIN RESERVATIONS R 
    ON R.hotel_id = H.hotel_id
WHERE R.HOTEL_ID IS NULL ; 


---------------------------------------------------------
-------------- REQUETES IMBRIQUES  ----------------------
---------------------------------------------------------

SELECT C.NOM  --, H.etoiles
FROM CLIENTS C
INNER JOIN RESERVATIONS R
    ON C.CLIENT_ID = R.CLIENT_ID
INNER JOIN HOTELS H 
    on R.HOTEL_ID = H.HOTEL_ID 
WHERE H.etoiles > 4;

--  Afficher le Total des revenus générés par chaque hôtel

SELECT H.NOM  AS HOTEL, SUM(IF(R.prix_total IS NULL, 0 , R.prix_total))
FROM HOTELS H
LEFT OUTER JOIN RESERVATIONS R 
    ON R.hotel_id = H.hotel_id
GROUP BY H.NOM ;


SELECT H.NOM, SUM(IF(R.prix_total IS NULL, 0,R.prix_total )) OVER(PARTITION BY R.HOTEL_ID)
FROM HOTELS H
LEFT OUTER JOIN RESERVATIONS R 
    ON R.hotel_id = H.hotel_id;
