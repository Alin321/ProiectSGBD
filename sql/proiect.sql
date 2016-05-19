--`````````````````````````````` PACKAGE FOR DROPING TABLES ``````````````````````````
create or replace package table_drops as
  procedure drop_table_client;
  procedure drop_table_card;
  procedure drop_table_adresa;
  procedure drop_table_pizza;
  procedure drop_table_ingrediente;
  procedure drop_table_ingrediente_pizza;
  procedure drop_table_bon;
  procedure drop_table_vanzari;
end table_drops;
/

CREATE OR REPLACE PACKAGE BODY table_drops as

  PROCEDURE drop_table_client is 
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE client';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END drop_table_client;
  
  
  PROCEDURE drop_table_card is
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE card';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END;
  
  PROCEDURE drop_table_adresa is 
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE adresa';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END;
  
  PROCEDURE drop_table_pizza is 
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE pizza';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END;
  
  PROCEDURE drop_table_ingrediente is 
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ingrediente';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END;
  
  PROCEDURE drop_table_ingrediente_pizza is 
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ingrediente_pizza';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END;
  
  PROCEDURE drop_table_bon is 
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE bon';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END;
  
  PROCEDURE drop_table_vanzari is 
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vanzari';
  EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
  END;
  
end table_drops;
/
--```````````````````````````````END PACKAGE FOR DROPING TABLES```````````````````````

--`````````````````````````````DROP TABLES IF THEY EXIST``````````````````````````````

begin
  TABLE_DROPS.DROP_TABLE_INGREDIENTE_PIZZA();
  TABLE_DROPS.DROP_TABLE_VANZARI();
  TABLE_DROPS.DROP_TABLE_BON();
  TABLE_DROPS.DROP_TABLE_ADRESA();
  TABLE_DROPS.DROP_TABLE_CARD();  
  TABLE_DROPS.DROP_TABLE_PIZZA();
  TABLE_DROPS.DROP_TABLE_INGREDIENTE();
  TABLE_DROPS.DROP_TABLE_CLIENT();
end;
/
--`````````````````````````````END TABLE DROPPING ````````````````````````````````````

--``````````````````````````````` CREATE TABLE STATEMENTS `````````````````````````````
CREATE TABLE client ( ID NUMBER(5),
                      Nume VARCHAR2(50),
                      Prenume Varchar2(50),
                      Email Varchar2(100),
                      Parola Varchar2(50),
                      Telefon Varchar2(10),
                      primary key (id))
                  
/

CREATE TABLE card ( ID NUMBER(5),
                    Data_nastere DATE,
                    sold Number(10,2),
                    id_client NUMBER(5),
                    primary key(id),
                    foreign key(id_client) references client(id))
                    
/

CREATE TABLE adresa ( ID NUMBER(5),
                      strada VARCHAR2(15),
                      numar NUMBER(5),
                      bloc VARCHAR2(5),
                      scara VARCHAR2(5),
                      etaj NUMBER(2),
                      apartament NUMBER(3),
                      id_client NUMBER(5),
                      primary key(id),
                      foreign key(id_client) references client(id))
                      
/

CREATE TABLE pizza ( ID NUMBER(5),
                      nume varchar2(50),
                      pret NUMBER(5,2),
                      tip VARCHAR2(10),
                      dimensiune VARCHAR2(5),
                      primary key(id))
                      
/

CREATE TABLE ingrediente ( ID NUMBER(5),
                            nume VARCHAR2(50),
                            pret_furnizor NUMBER(5,2),
                            primary key(id))
                            
/

CREATE TABLE ingrediente_pizza ( id_pizza NUMBER(5),
                                  id_ingredient NUMBER(5),
                                  foreign key(id_pizza) references pizza(id),
                                  foreign key(id_ingredient) references ingrediente(id))
                                  
/

CREATE TABLE bon ( ID NUMBER(5),
                    data_creare DATE,
                    id_pizza NUMBER(5),
                    pret NUMBER(5,2),
                    primary key(id),
                    foreign key(id_pizza) references pizza(id))

/

CREATE TABLE vanzari (ID NUMBER(5),
                      id_client NUMBER(5),
                      id_bon NUMBER(5),
                      data_tranzactie DATE,
                      total NUMBER(10,2),
                      primary key(id),
                      foreign key(id_client) references client(id),
                      foreign key(id_bon) references bon(id))
                      
/

-- ``````````````````````````` END CREATE TABLE STATEMENTS ``````````````````````````````

--`````````````````````````````CREATE PACKAGE WITH EXCEPTION`````````````````````````````
create or replace package exceptii as
	client_deja_existent EXCEPTION;
	parola_invalida EXCEPTION;
	client_inexistent EXCEPTION;
	pizza_inexistenta EXCEPTION;
	ingredient_inexistent EXCEPTION;
	email_invalid EXCEPTION;
	bon_inexistent EXCEPTION;
end exceptii;
/

create or replace package BODY exceptii as
	client_deja_existent EXCEPTION;
	parola_invalida EXCEPTION;
	client_inexistent EXCEPTION;
	pizza_inexistenta EXCEPTION;
	ingredient_inexistent EXCEPTION;
	email_invalid EXCEPTION;
	bon_inexistent EXCEPTION;
	PRAGMA EXCEPTION_INIT(client_deja_existent, -20001);
	PRAGMA EXCEPTION_INIT(parola_invalida, -20002);
	PRAGMA EXCEPTION_INIT(client_inexistent, -20003);
	PRAGMA EXCEPTION_INIT(pizza_inexistenta, -20004);
	PRAGMA EXCEPTION_INIT(ingredient_inexistent, -20005);
	PRAGMA EXCEPTION_INIT(email_invalid, -20006);
	PRAGMA EXCEPTION_INIT(bon_inexistent, -20007);
end exceptii;
/
--`````````````````````````````END EXCEPTION PACKAGE``````````````````````````````````````
--`````````````````````````````APPLICATION PROCEDURES````````````````````````````````````

create or replace package application_procedures as
	PROCEDURE actualizare_sold_card(p_id_client in NUMBER, p_total in NUMBER);
	PROCEDURE insereaza_combinatii_pizza;
end application_procedures;
/
create or replace package body application_procedures as
	PROCEDURE actualizare_sold_card(p_id_client in NUMBER, p_total in NUMBER) is
		new_sold card.sold%TYPE;
		old_sold card.sold%TYPE;
	BEGIN
		select sold into old_sold from card where id_client = p_id_client;
		new_sold := old_sold + p_total;

		update card set sold = new_sold where p_id_client = id_client;
	END;

	PROCEDURE insereaza_combinatii_pizza is 
		n pls_integer;
	BEGIN
		for indx in (select id from pizza) loop
			for i in 1..6 loop
				n := dbms_random.value(1,14);
				table_inserts.insert_into_ingrediente_pizza(indx.id,n);
			end loop;
		end loop;
	END;
end application_procedures;
/
--`````````````````````````````END APPLICATION PROCEDURES`````````````````````````````````
-- ``````````````````````````` BEGIN INSERT DATA PROCEDURES``````````````````````````````
create or replace package table_inserts as
  procedure insert_into_client(p_nume in varchar2, p_prenume in varchar2, p_email in varchar2, p_parola in varchar2, p_telefon in varchar2);
  procedure insert_into_client(p_nume in varchar2, p_prenume in varchar2, p_email in varchar2, p_parola in varchar2);

  procedure insert_into_card(p_data_nastere in DATE, p_id_client in NUMBER, p_sold in NUMBER);
  procedure insert_into_card(p_data_nastere in DATE, p_id_client in NUMBER);

  procedure insert_into_adresa(p_strada in VARCHAR2, p_numar in NUMBER, p_bloc in VARCHAR2, p_scara in VARCHAR2, p_etaj in Number, p_apartament in NUMBER, p_id_client NUMBER);
  procedure insert_into_adresa(p_strada in VARCHAR2, p_numar in NUMBER, p_id_client NUMBER);

  procedure insert_into_pizza (p_nume in varchar2, p_pret in NUMBER, p_tip in varchar2, p_dimensiune in varchar2);

  procedure insert_into_ingrediente(p_nume in varchar2);

  procedure insert_into_ingrediente_pizza(p_id_pizza in NUMBER, p_id_ingredient in NUMBER);

  procedure insert_into_bon(p_id in NUMBER,p_data_creare in DATE, p_id_pizza in NUMBER);

  procedure insert_into_vanzari(p_id_client in NUMBER, p_id_bon in NUMBER);
end table_inserts;
/

create or replace package body table_inserts as
	PROCEDURE insert_into_client(p_nume in varchar2, p_prenume in varchar2, p_email in varchar2, p_parola in varchar2, p_telefon in varchar2) is
		new_id client.id%TYPE;
		nr_of_emails number;
	BEGIN
		select nvl(max(id),0) into new_id from client;
		new_id := new_id + 1;

		IF (length(p_parola) < 8) THEN
			RAISE exceptii.parola_invalida;
		END IF;

		IF (instr(p_email,'@') = 0 or instr(p_email,'.') = 0) THEN
			RAISE exceptii.email_invalid;
		END IF;

		select count(*) into nr_of_emails from client where email = p_email;

		IF (nr_of_emails = 0) THEN
			insert into client(id, nume, prenume, email, parola, telefon) values (new_id, p_nume, p_prenume, p_email, p_parola, p_telefon);
		ELSE 
			raise exceptii.client_deja_existent;
		END IF;
	EXCEPTION
		WHEN exceptii.email_invalid THEN
			raise_application_error(-20006, 'Emailul este invalid. Format corect: ceva@domeniu.ceva');
		WHEN exceptii.parola_invalida THEN
			raise_application_error(-20002, 'Parola trebuie sa fie mai lunga de 7 caractere');
		WHEN exceptii.client_deja_existent THEN
			raise_application_error(-20001, 'Adresa de email este deja inregistrata in baza noastra de date');
		WHEN OTHERS THEN
          raise_application_error( -20999, 'Ceva nu a mers bine!');
	END insert_into_client;

	PROCEDURE insert_into_client(p_nume in varchar2, p_prenume in varchar2, p_email in varchar2, p_parola in varchar2) is
		new_id client.id%TYPE;
		nr_of_emails number;
	BEGIN
		select nvl(max(id),0) into new_id from client;
		new_id := new_id + 1;

		IF (length(p_parola) < 8) THEN
			RAISE exceptii.parola_invalida;
		END IF;

		select count(*) into nr_of_emails from client where email = p_email;

		IF (nr_of_emails = 0) THEN
			insert into client(id, nume, prenume, email, parola, telefon) values (new_id, p_nume, p_prenume, p_email, p_parola, '');
		ELSE 
			raise exceptii.client_deja_existent;
		END IF;
	EXCEPTION
		WHEN exceptii.parola_invalida THEN
			raise_application_error(-20002, 'Parola trebuie sa fie mai lunga de 7 caractere');
		WHEN exceptii.client_deja_existent THEN
			raise_application_error(-20001, 'Adresa de email este deja inregistrata in baza noastra de date');
		WHEN OTHERS THEN
          raise_application_error( -20999, 'Ceva nu a mers bine!');
	END insert_into_client;

	PROCEDURE insert_into_card(p_data_nastere in DATE, p_id_client in NUMBER, p_sold in NUMBER) is
		new_id card.id%TYPE;
		nr_id_client NUMBER;
	BEGIN
		select count(*) into nr_id_client from client where id = p_id_client;

		IF (nr_id_client = 1) THEN
			select nvl(max(id),0) into new_id from card;
			new_id := new_id + 1;
			insert into card(id,id_client,sold) values (new_id,p_id_client,p_sold);
		ELSE 
			raise exceptii.client_inexistent;
		END IF;
	EXCEPTION
		WHEN exceptii.client_inexistent THEN
			raise_application_error(-20003, 'Clientul cu acest id nu exista in baza de date!');
		WHEN OTHERS THEN
			raise_application_error(-20999, 'Ceva nu a mers bine!');
	END;

	PROCEDURE insert_into_card(p_data_nastere in DATE, p_id_client in NUMBER) is
		new_id card.id%TYPE;
		nr_id_client NUMBER;
	BEGIN
		select count(*) into nr_id_client from client where id = p_id_client;

		IF (nr_id_client = 1) THEN
			select nvl(max(id),0) into new_id from card;
			new_id := new_id + 1;
			insert into card(id,id_client,sold) values (new_id,p_id_client,0);
		ELSE 
			raise exceptii.client_inexistent;
		END IF;
	EXCEPTION
		WHEN exceptii.client_inexistent THEN
			raise_application_error(-20003, 'Clientul cu acest id nu exista in baza de date!');
		WHEN OTHERS THEN
			raise_application_error(-20999, 'Ceva nu a mers bine!');
	END;

	PROCEDURE insert_into_adresa(p_strada in VARCHAR2, p_numar in NUMBER, p_bloc in VARCHAR2, p_scara in VARCHAR2, p_etaj in Number, p_apartament in NUMBER, p_id_client NUMBER) is
		new_id adresa.id%TYPE;
		nr_id_client NUMBER;
	BEGIN
		select count(*) into nr_id_client from client where id = p_id_client;

		IF (nr_id_client = 1) THEN
			select nvl(max(id),0) into new_id from adresa;
			new_id := new_id + 1;
			insert into adresa(id,strada,numar,bloc,scara,etaj,apartament,id_client) values (new_id,p_strada,p_numar,p_bloc,p_scara,p_etaj,p_apartament,p_id_client);
		ELSE 
			raise exceptii.client_inexistent;
		END IF;
	EXCEPTION
		WHEN exceptii.client_inexistent THEN
			raise_application_error(-20003, 'Clientul cu acest id nu exista in baza de date!');
		WHEN OTHERS THEN
			raise_application_error(-20999, 'Ceva nu a mers bine!');
	END;

	PROCEDURE insert_into_adresa(p_strada in VARCHAR2, p_numar in NUMBER, p_id_client NUMBER) is
		new_id adresa.id%TYPE;
		nr_id_client NUMBER;
	BEGIN
		select count(*) into nr_id_client from client where id = p_id_client;

		IF (nr_id_client = 1) THEN
			select nvl(max(id),0) into new_id from adresa;
			new_id := new_id + 1;
			insert into adresa(id,strada,numar,bloc,scara,etaj,apartament,id_client) values (new_id,p_strada,p_numar,'','','','',p_id_client);
		ELSE 
			raise exceptii.client_inexistent;
		END IF;
	EXCEPTION
		WHEN exceptii.client_inexistent THEN
			raise_application_error(-20003, 'Clientul cu acest id nu exista in baza de date!');
		WHEN OTHERS THEN
			raise_application_error(-20999, 'Ceva nu a mers bine!');
	END;

	PROCEDURE insert_into_pizza (p_nume in varchar2, p_pret in NUMBER, p_tip in varchar2, p_dimensiune in varchar2) is
		new_id pizza.id%TYPE;
		nr_pizzza NUMBER;
    BEGIN
    	select nvl(max(id),0) into new_id from pizza;
    	new_id := new_id + 1;

    	insert into pizza(id,nume,pret,tip,dimensiune) values (new_id,p_nume,p_pret,p_tip,p_dimensiune);
	EXCEPTION
		WHEN OTHERS THEN
			raise_application_error(-20999, 'Ceva nu a mers bine!');
	END;

	PROCEDURE insert_into_ingrediente(p_nume in varchar2) is
		new_id pizza.id%TYPE;
		n pls_integer;
    BEGIN
    	select nvl(max(id),0) into new_id from ingrediente;
    	new_id := new_id + 1;

    	n := dbms_random.value(1,20);

    	insert into ingrediente(id,nume,pret_furnizor) values (new_id,p_nume,n);
	EXCEPTION
		WHEN OTHERS THEN
			raise_application_error(-20999, 'Ceva nu a mers bine!');
	END;

	PROCEDURE insert_into_ingrediente_pizza(p_id_pizza in NUMBER, p_id_ingredient in NUMBER) is
		nr_pizza NUMBER;
		nr_ingeridente NUMBER;
	BEGIN
		select count(*) into nr_pizza from pizza where id = p_id_pizza;
		select count(*) into nr_ingeridente from ingrediente where id = p_id_ingredient;

		IF (nr_pizza > 0) THEN
			IF (nr_ingeridente > 0) THEN
				insert into ingrediente_pizza(id_pizza,id_ingredient) values(p_id_pizza,p_id_ingredient);
			ELSE 
				raise exceptii.ingredient_inexistent;
			END IF;
		ELSE
			raise exceptii.pizza_inexistenta;
		END IF;
	EXCEPTION
		WHEN exceptii.pizza_inexistenta THEN
			raise_application_error(-20004,'Pizza cu acest id nu exista in baza de date');
		WHEN exceptii.ingredient_inexistent THEN
			raise_application_error(-20005,'Ingredientul cu acest id nu exista in baza de date');
		WHEN OTHERS THEN
			raise_application_error(-20999,'Ceva nu a mers bine');
	END;

	procedure insert_into_bon(p_id in NUMBER, p_data_creare in DATE, p_id_pizza in NUMBER) is 
		nr_pizza NUMBER;
		pret_pizza NUMBER;
	BEGIN
		select count(*) into nr_pizza from pizza where id = p_id_pizza;

		IF (nr_pizza > 0) THEN
			select pret into pret_pizza from pizza where id = p_id_pizza;
			insert into bon(id, data_creare, id_pizza, pret) values (p_id, p_data_creare, p_id_pizza, pret_pizza);
		ELSE
			raise exceptii.pizza_inexistenta;
    END IF;
	EXCEPTION
		WHEN exceptii.pizza_inexistenta THEN
			raise_application_error(-20004,'Pizza cu acest id nu exista in baza de date');
		WHEN OTHERS THEN
			raise_application_error(-20999,'Ceva nu a mers bine');
	END;	

	procedure insert_into_vanzari(p_id_client in NUMBER, p_id_bon in NUMBER) is
		v_total NUMBER;
		nr_id_client NUMBER;
		nr_id_bon NUMBER;
		v_data_tranzactie DATE;
		new_id vanzari.id%TYPE;
	BEGIN
		select count(*) into nr_id_client from client where id = p_id_client;

		IF (nr_id_client = 0) THEN
			raise exceptii.client_inexistent;
		END IF;

		select count(*) into nr_id_bon from bon where id = p_id_bon;

		IF (nr_id_bon = 0) THEN
			raise exceptii.bon_inexistent;
		END IF;

		select data_creare into v_data_tranzactie from bon where id = p_id_bon;
		select sum(pret) into v_total from bon where id=p_id_bon;
		select nvl(max(id),0) into new_id from vanzari;

		insert into vanzari(id, id_client, id_bon, data_tranzactie, total) values (new_id, p_id_client, p_id_bon, v_data_tranzactie, v_total);

		select count(*) into nr_id_client from card where id_client = p_id_client;

		IF (nr_id_client > 0) THEN
			application_procedures.actualizare_sold_card(p_id_client,v_total);
		END IF;
	EXCEPTION
		WHEN exceptii.client_inexistent THEN
			raise_application_error(-20003, 'Clientul cu acest id nu exista in baza de date!');
		WHEN exceptii.bon_inexistent THEN
			raise_application_error(-20007, 'Nu exista bonul cu acest id!');
		WHEN OTHERS THEN
			raise_application_error(-20999, 'Ceva nu a mers bine!');
	END;


end table_inserts;
/
--````````````````````````````` END INSERT PROCEDURES```````````````````````````````````````

--`````````````````````````````POPULATE TABLES````````````````````````````````````````````
BEGIN
	--Insert into ingrediente
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Mozzarella');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Ciuperci');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Rosii');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Masline');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Sos rosii');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Salam');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Sunca');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Bacon');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Cabanos');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Piept de pui');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Porumb');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Ardei');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Ceapa');
	TABLE_INSERTS.INSERT_INTO_INGREDIENTE('Ton');

	--Insert into pizza NUME PRET TIP DIMENSIUNE
	TABLE_INSERTS.INSERT_INTO_PIZZA('A La Chef', 33.40, 'Clasica', '45cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Bacon i Cipola',31.50 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Beef Deluxe',44.20 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Capriciosa',24.80 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Double Cheese',26.80 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Espagnola',25.60 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Florenza',25.80 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Floriany',25.50 ,'Clasica' ,'25cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Inferno',29.90 ,'Clasica' ,'25cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Jessina',30.80 ,'Clasica' ,'25cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Libanese',45.70 ,'Clasica' ,'45cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Prosciutto',61.30 ,'Clasica' ,'45cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Lucifero',23.30 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Quattro Formaggi',26.30 ,'Clasica' ,'25cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Quattro Staggioni',25.70 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Salamino Funghi',31.30 ,'Clasica' ,'25cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Specialitatea case',27.30 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Turkey Deluxe',22.10 ,'Clasica' ,'45cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Verona',25.60 ,'Clasica' ,'25cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Napoli',33.30 ,'Clasica' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Broccoli i Funghi',21.70 ,'Vegetala' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Vegetala',26.20 ,'Vegetala' ,'35cm');
	TABLE_INSERTS.INSERT_INTO_PIZZA('Alpina',30.50 ,'Vegetala' ,'35cm');

	--Insert into pizza_ingrediente
	APPLICATION_PROCEDURES.INSEREAZA_COMBINATII_PIZZA();

	-- Insert clients p_nume in varchar2, p_prenume in varchar2, p_email in varchar2, p_parola in varchar2, p_telefon in varchar2
	TABLE_INSERTS.INSERT_INTO_CLIENT('','','','','');
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
--```````````````````````````````END POPULATE TABLES```````````````````````````````````````