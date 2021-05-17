 DROP TABLE Appointment;
 DROP TABLE Nurse;
 DROP TABLE Hospital;
 DROP TABLE Blood;
 DROP TABLE Blood_Bank;
 DROP TABLE Donerpho;
 DROP TABLE Doner;
 

 CREATE TABLE Doner(
 donerID NUMBER (4) PRIMARY KEY,
 gender CHAR(1),
 name VARCHAR2(17),
 age NUMBER(3)
 );

 CREATE TABLE Donerpho(
 phone_number NUMBER(10),
 donerID NUMBER (4),
 CONSTRAINT PK PRIMARY KEY(phone_number,donerID),
 CONSTRAINT FK1 FOREIGN KEY (donerID)REFERENCES Doner(donerID)
 );

 CREATE TABLE Blood_Bank(
 serial_num char(4) PRIMARY KEY,
 phone_num char(10),
 addres VARCHAR2(15) 
 );

 CREATE TABLE Blood (
 code CHAR(5)PRIMARY KEY,
 donerID NUMBER (4),
 serial_num char(4),
 Blood_tyb VARCHAR2(3),
 amount NUMBER (5 , 4),
 CONSTRAINT FK2 FOREIGN KEY (donerID)REFERENCES Doner(donerID),
 CONSTRAINT FK3 FOREIGN KEY (serial_num)REFERENCES Blood_Bank(serial_num)
 );

 CREATE TABLE Hospital(
 name VARCHAR2(12) PRIMARY KEY,
 Phone_number NUMBER(10),
 addres VARCHAR2(20),
 serial_num char(4) REFERENCES Blood_Bank(serial_num)
 );
 
 CREATE TABLE Nurse(
 nurseID CHAR(5) PRIMARY KEY,
 Hospital_name VARCHAR2(20),
 serial_num char(4) REFERENCES Blood_Bank(serial_num)
 );
 
 CREATE TABLE Appointment(
 donerID NUMBER(4) PRIMARY KEY,
 nurseID CHAR(5),
 Hospital_name VARCHAR2(12),
 appdate DATE ,
 apptime DATE ,
 FOREIGN KEY (donerID)REFERENCES Doner(donerID),
 FOREIGN KEY (nurseID)REFERENCES Nurse (NurseID),
 FOREIGN KEY (Hospital_name)REFERENCES Hospital(name)
 );

 INSERT INTO Doner (donerID , gender , name , age ) VALUES (0001 , 'f' , 'Add a name' , 19 );
 INSERT INTO Doner (donerID , gender , name , age ) VALUES (0002 , 'f' , 'Add a name' , 19 );
 INSERT INTO Doner (donerID , gender , name , age ) VALUES (0003 , 'f' , 'Add a name' ,20);
 INSERT INTO Doner (donerID , gender , name , age ) VALUES (0004 , 'm' , 'Add a name' ,18);

 INSERT INTO Donerpho ( phone_number , donerID ) VALUES (0507274988 , 0001);
 INSERT INTO Donerpho ( phone_number , donerID ) VALUES (0508643561 , 0002);
 INSERT INTO Donerpho ( phone_number , donerID ) VALUES (0509737434 , 0003);
 INSERT INTO Donerpho ( phone_number , donerID ) VALUES (0537439298 , 0004);  
 
 INSERT INTO Blood_Bank (serial_num , phone_num , addres ) VALUES (4253 , 0507274988 , 'Riyadh');
 INSERT INTO Blood_Bank (serial_num , phone_num , addres ) VALUES (8744 , 0508643561 , 'Riyadh');
 INSERT INTO Blood_Bank (serial_num , phone_num , addres ) VALUES (6317 , 0537439298 , 'Riyadh');
 INSERT INTO Blood_Bank (serial_num , phone_num , addres ) VALUES (6316 , 0509737434 , 'Riyadh');
 INSERT INTO Blood_Bank (serial_num , phone_num , addres ) VALUES (7543 , 0559341408 , 'Riyadh');
 INSERT INTO Blood_Bank (serial_num , phone_num , addres ) VALUES (8688 , 0566778899 , 'Riyadh');
  
 INSERT INTO Blood(code , donerID , serial_num , Blood_tyb , amount ) VALUES ('B0001' , 0001, 4253,'A+' , 0.3456 ); 
 INSERT INTO Blood(code , donerID , serial_num , Blood_tyb , amount) VALUES  ('B0002' , 0002, 8744 ,'AB+', 0.7589 );
 INSERT INTO Blood(code , donerID , serial_num, Blood_tyb , amount ) VALUES  ('B0003' , 0003, 6316 ,'A+' , 0.0298 ); 
 INSERT INTO Blood(code , donerID , serial_num, Blood_tyb , amount ) VALUES  ('B0004' , 0004, 6317 ,'O-' , 0.9298 ); 
 
 INSERT INTO Hospital(name , phone_number , addres , serial_num ) VALUES ('Add Hospital Name' ,05244889 , 'Riyadh' ,4253 ); 
 INSERT INTO Hospital(name , phone_number , addres , serial_num ) VALUES ('Add Hospital Name' ,05233881 , 'Riyadh' , 8744 ); 
 INSERT INTO Hospital(name , phone_number , addres , serial_num ) VALUES ('Add HospitalName' ,05277893 , 'Riyadh' ,6317 );
 
 INSERT INTO Nurse(nurseID , Hospital_name , serial_num ) VALUES ('N0001' , 'Alhayah' , 6317 ); 
 INSERT INTO Nurse(nurseID , Hospital_name , serial_num ) VALUES ('N0002' , 'Alamal'  , 8744 ); 
 INSERT INTO Nurse(nurseID , Hospital_name , serial_num ) VALUES ('N0003' , 'Alhayah' , 6317 ); 
 INSERT INTO Nurse(nurseID , Hospital_name , serial_num ) VALUES ('N0004' , 'Alhayah' , 6317 ); 
 
 INSERT INTO Appointment(donerID ,  nurseID , Hospital_name , appdate , apptime ) VALUES ( 0001, 'N0001' , 'Alhabeb'  , (TO_DATE ('12-12-2020','DD-MM- YYYY')),(TO_DATE('05:30','HH24:MI'))); 
 INSERT INTO Appointment(donerID ,  nurseID , Hospital_name , appdate , apptime ) VALUES ( 0002, 'N0002' , 'Alshmesi' , (TO_DATE ('22-01-2021','DD-MM- YYYY')),(TO_DATE ('03:45','HH24:MI'))); 
 INSERT INTO Appointment(donerID ,  nurseID , Hospital_name , appdate , apptime ) VALUES ( 0003, 'N0003' , 'Alyamamah', (TO_DATE ('25-01-2021','DD-MM- YYYY')),(TO_DATE ('06:45','HH24:MI')));


CREATE user Adminn IDENTIFIED BY system2;

Grant connect to Adminn;
Grant all PRIVILEGES to Adminn;



SET serveroutput ON; 
  DECLARE 
          DonerrID Blood.DonerID%type;
		   
  BEGIN
       DonerrID := &DonerrID; 
      
      Checkamount(DonerrID) ; 
  END;
/ 


SET serveroutput ON;
DECLARE
Doner_id_ NUMBER;
Type_ VARCHAR2(3);
BEGIN
Doner_id_ := &Doner_id_;
SELECT Blood_tyb INTO Type_ FROM Blood WHERE donerID = Doner_id_;

CASE Type_
when 'A+' then dbms_output.put_line('Blood Type A+');
when 'B+' then dbms_output.put_line('Blood Type B+');
when 'AB+' then dbms_output.put_line('Blood Type AB+');
when 'O+' then dbms_output.put_line('Blood Type O+');
when 'A-' then dbms_output.put_line('Blood Type A-');
when 'B-' then dbms_output.put_line('Blood Type B-');
when 'AB-' then dbms_output.put_line('Blood Type AB-');
ELSE dbms_output.put_line('Blood Type O-');
END CASE;
END;
/




CREATE OR REPLACE TRIGGER CheckAge
BEFORE
 INSERT OR UPDATE ON Doner 
FOR EACH ROW 
BEGIN 
     IF :new.age<18 THEN
     raise_application_error(-20001, 'Age should be greater than 18'); 
     END IF; 
END;
/

 INSERT INTO Doner (donerID , gender , name , age ) VALUES (0005 , 'f' , 'Sadeem' , 20 );
 INSERT INTO Doner (donerID , gender , name , age ) VALUES (0006 , 'm' , 'Ahmad' , 17 );



CREATE OR REPLACE TRIGGER CheckBloodType
BEFORE
 INSERT OR UPDATE ON Blood 
FOR EACH ROW 
BEGIN 
     IF :new.Blood_tyb IN('A+','A-','B+','B-','AB+','AB-','O+','O-') THEN
	 dbms_output.put_line('The blood type entered is correct.'); 
	 else
     raise_application_error(-20001, 'The blood type entered is incorrect. It should be A+, A-, B+, B-, AB+, AB-, O+, O-'); 
     END IF; 
END;
/ 

  INSERT INTO Blood(code , donerID , serial_num, Blood_tyb , amount ) VALUES  ('B0005' , 0005, 7543 ,'O+' , 0.1298 ); 
  INSERT INTO Blood(code , donerID , serial_num, Blood_tyb , amount ) VALUES  ('B0006' , 0006, 8688 ,'BA+' , 0.9298 ); 