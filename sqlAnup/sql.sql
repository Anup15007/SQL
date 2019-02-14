create table Associate(
associateId number,
firstName varchar2(50) not null,
lastName varchar2(50) not null,
yearlyInvestmentUnder80C number,
department varchar2(50) not null,
designation varchar2(50) not null,
pancard varchar2(50) not null,
emailId varchar2(50) not null
);
desc Associate;
drop table Associate

alter table Associate
 add constraint PK_AssociateID
   primary key(associateId);
   
alter table Associate
 add constraint UK_EmailId
 unique(emailId);
 
 CREATE TABLE SALARY(
 BASICSALARY NUMBER,
 HRA NUMBER,
 CONVEYENCEALLOWANCE NUMBER,
 OTHERALLOWANCE NUMBER,
 PERSONALALLOWANCE NUMBER,
 MONTHLYTAX NUMBER,
 EPF NUMBER,
 COMPANYPF NUMBER,
 GROSSSALARY NUMBER,
 NETSALARY NUMBER
 );
 drop table salary;
 alter table Salary
  add associateId number;
  
  alter table Salary
    add constraint FK_AssociateID
      foreign key(associateId)REFERENCES Associate(associateId);
      
Create Table BankDetails(
ACCOUNTNUMBER NUMBER,
BANKNAME VARCHAR2(50),
IFSCCODE VARCHAR(50)
);
alter table BankDetails
  add associateId number;


alter table BANKDETAILS
    add constraint AssociateID_FK
      foreign key(associateId)REFERENCES Associate(associateId);
      
      
      --------------------------------------------------
  SELECT sysdate from dual;
  
  SELECT ADD_MONTHS(sysdate,10)
  FROM dual;
  
  SELECT round (MONTHS_BETWEEN(sysdate,'01-sep-95'),1)
  FROM dual;
  
  SELECT EXTRACT (year from sysdate)
  FROM dual;
  
   SELECT EXTRACT(month FROM DATE '2011-04-01')
   FROM dual;
   
    SELECT EXTRACT (month from book_issue_date)
    from book_transaction;
    
SELECT TO_CHAR(SYSDATE,'DD month,YYYY')FROM dual;

SELECT TO_CHAR(SYSDATE,'DDth month,YYYY')FROM dual;

SELECT TO_CHAR(17000,'$99,999.00')FROM dual;
  ---------------------------------------------------------------
  
  
  SELECT a.associateId,a.firstName,a.lastName, s.basicSalary,s.netSalary,b.bankName
  from Associate a,Salary s,BankDetails b
    where a.ASSOCIATEID=s.associateId and a.ASSOCIATEID=b.associateId;
    
select *
from Associate,salary,bankDetails

SELECT a.associateId,a.firstName,a.lastName, s.basicSalary,s.netSalary,b.bankName
  from Associate a,Salary s,BankDetails b
    where a.ASSOCIATEID(+)=s.associateId;
    
select * from bankDetails 
where (Select bankName from bankDetails where bankName='CITI');
 
create view AssociateBankDetails
as
select a.associateId,a.firstName,a.lastName,b.bankName,b.IFSCCODE
  from Associate a,BankDetails b
    where a.ASSOCIATEID=b.associateId;
  select * from AssociateBankDetails
  --------------------------------------------
DECLARE
  veName VARCHAR2(20)NOT NULL:='Satish';
  id NUMBER;
  BEGIN
  veNAme:='Satish';
  DBMS_OUTPUT.PUT_LINE(veName||''||id);
  END;
  ------------------------------------------------
DECLARE
  aid NUMBER;
  fName varchar(50);
  lName varchar(50);
  BEGIN
  SELECT associateId,firstName,lastName INTO aid,fName,lName
  from Associate
    where associateId=&aid;
  DBMS_OUTPUT.PUT_LINE(aid||''||fNAme||''||lName);
  END;
  --------------------------------------------------
  DECLARE
  aid ASSOCIATE.ASSOCIATEID%TYPE;
  fName ASSOCIATE.FIRSTNAME%TYPE;
  lName  ASSOCIATE.LASTNAME%TYPE;
  BEGIN
  SELECT associateId,firstName,lastName INTO aid,fName,lName
  from Associate
    where associateId=&aid;
  DBMS_OUTPUT.PUT_LINE(aid||''||fNAme||''||lName);
  END;
  -----------------------------------------------------
  DECLARE 
    associateRow ASSOCIATE%ROWTYPE;
  begin
  select * INTO associateRow
  from Associate
    where associateId=&aid;
  DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID);
end;
--------------------------------------------------------------
DECLARE 
   cursor  associateCursor is select * from ASSOCIATE;
   associateRow ASSOCIATE%ROWTYPE;
  begin
  open associateCursor;
  loop
  FETCH associateCursor INTO associateRow;
  DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID||''||associateRow.firstName||''||associateRow.lastName);
  exit when associateCursor%NOTFOUND;
  end loop;
  close associateCursor;
  end;
  ------------------------------------------------------------
  DECLARE
  aid NUMBER;
  fName varchar(50);
  lName varchar(50);
  BEGIN
  SELECT associateId,firstName,lastName INTO aid,fName,lName
  from Associate
    where associateId=&aid;
  DBMS_OUTPUT.PUT_LINE(aid||''||fNAme||''||lName);
  EXCEPTION
  when NO_DATA_FOUND THEN
 DBMS_OUTPUT.PUT_LINE('No employees exits');
 when TOO_MANY_ROWS then
 DBMS_OUTPUT.PUT_LINE('too many records found');
 end;
 -----------------------------------------------------------------
 DECLARE 
   cursor  associateCursor is select * from ASSOCIATE
                            where YEARLYINVESTMENTUNDER80C>=&YEARLYINVESTMENTUNDER80C;
   associateRow ASSOCIATE%ROWTYPE;
   No_Records_Found EXCEPTION;
  begin
  open associateCursor;
  FETCH associateCursor INTO associateRow;
  IF associateCursor%ROWCOUNT>0
  then
  loop
  FETCH associateCursor INTO associateRow;
  DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID||''||associateRow.firstName||''||associateRow.lastName);
  exit when associateCursor%NOTFOUND;
  end loop;
  else
  raise NO_RECORDS_FOUND;
  end if;
  close associateCursor;
  EXCEPTION
  WHEN NO_RECORDS_FOUND Then
    DBMS_OUTPUT.PUT_LINE('no records found');
  end;
  -----------------------------------------------
   create or replace PROCEDURE sp_FindAssociateDetails
   AS
   cursor  associateCursor is select * from ASSOCIATE
                            where YEARLYINVESTMENTUNDER80C>=&YEARLYINVESTMENTUNDER80C;
   associateRow ASSOCIATE%ROWTYPE;
   No_Records_Found EXCEPTION;
  begin
  open associateCursor;
  FETCH associateCursor INTO associateRow;
  IF associateCursor%ROWCOUNT>0
  then
  loop
  FETCH associateCursor INTO associateRow;
  DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID||''||associateRow.firstName||''||associateRow.lastName);
  exit when associateCursor%NOTFOUND;
  end loop;
  else
  raise NO_RECORDS_FOUND;
  end if;
  close associateCursor;
  EXCEPTION
  WHEN NO_RECORDS_FOUND Then
    DBMS_OUTPUT.PUT_LINE('no records found');
  end sp_FindAssociateDetails;