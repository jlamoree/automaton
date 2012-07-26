SET client_min_messages TO warning;

/*
On a new database:
CREATE LANGUAGE plpgsql;
*/

/*
Application User
*/

-- Production
CREATE ROLE automaton WITH LOGIN PASSWORD 'secret';

-- Development
-- ALTER ROLE automaton WITH PASSWORD 'secret';

/*
Database
*/
CREATE DATABASE automaton WITH OWNER = automaton ENCODING = 'UTF-8';


/*
========================
LOGIN AS AUTOMATON USER
========================
*/

/*
Last Modified Trigger Function

Usage:
  CREATE TRIGGER setModifyDate BEFORE UPDATE ON table_name
  FOR EACH ROW EXECUTE PROCEDURE setModifyDate();

*/
CREATE OR REPLACE FUNCTION setModifyDate()
RETURNS TRIGGER AS $$
BEGIN
   NEW.modifyDate = now(); 
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;
