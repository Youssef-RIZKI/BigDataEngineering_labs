-----------------------------------------------------------------------------
-- la creation de la base de donnees
-----------------------------------------------------------------------------
CREATE DATABASE HOTEL_BOOKING ;


-----------------------------------------------------------------------------
--la creation de la table client 
-----------------------------------------------------------------------------
CREATE TABLE clients ( client_id INT, nom STRING, email STRING,
telephone STRING )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


-----------------------------------------------------------------------------
-- la creation de la table reservations et reservaition_partitioned 
-----------------------------------------------------------------------------
CREATE TABLE reservations(
    reservation_id INT,
    client_id INT,
    hotel_id INT,
    date_debut DATE,
    date_fin DATE,
    prix_total DECIMAL(10,2))
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


CREATE TABLE reservations_partitioned(
    reservation_id INT,
    client_id INT,
    hotel_id INT,
    date_fin DATE,
    prix_total DECIMAL(10,2))
PARTITIONED BY(date_debut DATE) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


--la creation de la table reservations Bucketed 
    CREATE TABLE reservations_bucketed (
        reservation_id INT,
        client_id INT,
        hotel_id INT,
        date_debut DATE,
        date_fin DATE,
        prix_total DECIMAL(10,2)
    )
    CLUSTERED BY (client_id) INTO 4 BUCKETS
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE;
 



-----------------------------------------------------------------------------
--la creation de la table hotels et hotels_partitioned
-----------------------------------------------------------------------------
CREATE TABLE hotels (
    hotel_id INT,
    nom STRING,
    ville STRING,
    etoiles INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


CREATE TABLE hotels_partitioned (
    hotel_id INT,
    nom STRING,
    etoiles INT
)
PARTITIONED BY (ville STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

