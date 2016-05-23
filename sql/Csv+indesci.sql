CREATE DIRECTORY Mycsv AS 'C:\Users\Andreea SM\Desktop\ProiectSGBD\ProiectSGBD';
GRANT READ, write ON DIRECTORY Mycsv TO PUBLIC;
--GRANT EXECUTE ON UTL_FILE TO PUBLIC;

--din tabel un fisier csv

PROCEDURE tabel_csv AS
     fisier UTL_FILE.FILE_TYPE;
     cursor cursor_pe_clienti is SELECT * FROM client; 
  BEGIN
     fisier := UTL_FILE.FOPEN ('MYCSV', 'DOC.CSV','w', 32767);
     UTL_FILE.PUT_LINE(fis, 'ID' ||','|| 'Nume' ||','|| 'Prenume' ||','|| 'Email' ||','|| 'Parola' || ',' || 'Telefon');
     FOR contor IN cursor_pe_clienti LOOP
        UTL_FILE.PUT_LINE(fis, contor.ID ||','|| contor.Nume ||','|| contor.Prenume ||','|| contor.Email ||','|| contor.Parola ||','|| contor.Telefon );
     END LOOP;
     UTL_FILE.FCLOSE(fisier);
     EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('EROARE');
END;
  
  
  
 --din fisier csv in tabel 
  procedure csv_tabel as
    fis UTL_FILE.FILE_TYPE;     
    v_line VARCHAR2 (1000);
    v_id_produs PRODUSE.ID_PRODUS%type;
    v_nume PRODUSE.NUME%type;
    v_nr number:=0;
      
    BEGIN
      delete from produse_csv;
      fis := UTL_FILE.FOPEN ('MYCSV', 'produse.CSV', 'r');
      IF UTL_FILE.IS_OPEN(fis) THEN
      LOOP
          BEGIN
            UTL_FILE.GET_LINE(fis, v_line, 1000);
            IF v_line IS NULL THEN
               EXIT;
            END IF;
            if(v_nr>0) then
              v_id_produs:=REGEXP_SUBSTR(v_line, '[^,]+', 1, 1);
              v_nume:=REGEXP_SUBSTR(v_line, '[^,]+', 1, 2);
              INSERT INTO produse_csv (id_produs, nume) VALUES(v_id_produs,v_nume);
            end if;
            v_nr :=1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                EXIT;
            
          END;
        END LOOP;
       END IF;
       UTL_FILE.FCLOSE(fis);
  END ;
  
  
  
----------------------INDECSI
-- pt. 		select count(*) into nr_email from client where email=p_email;
--si 		select id into v_id_client from client where email = p_email;
--si 		select count(*) into nr_email from client where email=p_email;
--si 		select id into v_id_client from client where email=p_email;
  CREATE INDEX client_email_idx
  ON client (email);
/
-- pt select count(*) into nr_clienti from client where p_parola=parola and email=p_email;
  CREATE INDEX client_parola_si_email_idx
  ON client (parola,email);
  
--pt 		select data_nastere into v_data_nastere from card where id_client = p_id_client;
--si 		select sum(pret) into v_total_bon from bon where p_id_bon = id;
--si 	
-- nu avem nevoie deoarece indecsii pe id_client e creat automat


-- pt 	select sold into p_sold from card where id_client = v_id_client;
  CREATE INDEX sold_id_client_idx
  ON sold (id_client);




  