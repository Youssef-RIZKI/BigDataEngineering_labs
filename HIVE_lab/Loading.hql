-- I put my dataset files in the shard volume first.

------------------------------------------------------------------------------------
-- 1. load the file clients.txt to the table clients
------------------------------------------------------------------------------------
LOAD DATA LOCAL INPATH '/shared_volume/Hive_dataset/clients.txt' INTO TABLE hotels ;

------------------------------------------------------------------------------------
-- 2. load the file reservaitions.txt to the table reservaitions 
------------------------------------------------------------------------------------
-- firstly, I load the file "reservations.txt" into the reservations table as a staging table
    LOAD DATA LOCAL INPATH '/shared_volume/Hive_dataset/reservations.txt' INTO TABLE clients ;


--then I insert selected data from reservations table into reservaition_partitioned table 

    INSERT INTO  RESERVATIONS_PARTITIONED(reservation_id, client_id, hotel_id, date_debut, date_fin, prix_total)
    SELECT reservation_id, client_id, hotel_id,date_debut,  date_fin, prix_total
    from reservations

------------------------------------------------------------------------------------
-- 3. load the file hotels.txt to the table reservations_bucketed --------------
------------------------------------------------------------------------------------
LOAD DATA LOCAL INPATH '/shared_volume/Hive_dataset/reservations.txt' INTO TABLE RESERVATIONS_BUCKETED