------------------------------------------------------------------
-- Drop all RLS policies from public schema
------------------------------------------------------------------
DO $$
DECLARE
    policy_record RECORD;
BEGIN
    FOR policy_record IN
        SELECT schemaname, tablename, policyname
        FROM pg_policies
        WHERE schemaname = 'public'
    LOOP
        EXECUTE format(
            'DROP POLICY IF EXISTS %I ON %I.%I;',
            policy_record.policyname,
            policy_record.schemaname,
            policy_record.tablename
        );
    END LOOP;
    
    RAISE NOTICE 'All RLS policies dropped successfully';
END
$$;

------------------------------------------------------------------
-- Drop all grants from anon and authenticated roles
------------------------------------------------------------------
DO $$
DECLARE
    table_record RECORD;
    role_name text;
BEGIN
    -- Drop grants for both roles
    FOR role_name IN SELECT unnest(ARRAY['anon', 'authenticated'])
    LOOP
        -- Revoke all table permissions
        FOR table_record IN
            SELECT tablename
            FROM pg_tables
            WHERE schemaname = 'public'
        LOOP
            EXECUTE format(
                'REVOKE ALL ON TABLE public.%I FROM %I;',
                table_record.tablename,
                role_name
            );
        END LOOP;
        
        -- Revoke all sequence permissions
        FOR table_record IN
            SELECT c.relname
            FROM pg_class c
            JOIN pg_namespace n ON n.oid = c.relnamespace
            WHERE c.relkind = 'S'
              AND n.nspname = 'public'
        LOOP
            EXECUTE format(
                'REVOKE ALL ON SEQUENCE public.%I FROM %I;',
                table_record.relname,
                role_name
            );
        END LOOP;
    END LOOP;
    
    RAISE NOTICE 'All grants revoked from anon and authenticated roles';
END
$$;