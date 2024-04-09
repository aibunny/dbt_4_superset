```
DO $$
DECLARE
    table_record RECORD;
BEGIN
    -- Cursor to select all tables in the "analytics" schema
    FOR table_record IN 
        SELECT tablename 
        FROM pg_tables 
        WHERE schemaname = 'analytics' 
    LOOP
        -- Dynamically alter the storage type for each table
        EXECUTE format('SELECT columnar.alter_table_set_access_method(''%I.%I'', ''columnar'');', 'analytics', table_record.tablename);
    END LOOP;
END $$;



CREATE SERVER smartcollect_server_pg FOREIGN DATA WRAPPER postgres_fdw OPTIONS (dbname 'smartcollect');
CREATE USER MAPPING FOR CURRENT_USER SERVER smartcollect_server_pg OPTIONS (user 'postgres', password 'b3puv9792qw');


```
