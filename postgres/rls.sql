--------------------------------------------------------------------
-- GRANT SEQUENCE USAGE FOR AUTHENTICATED ROLE
------------------------------------------------------------------
DO $$
    DECLARE
        seq text;
    BEGIN
        FOR seq IN
            SELECT c.relname
            FROM pg_class c
            JOIN pg_namespace n ON n.oid = c.relnamespace
            WHERE c.relkind = 'S'
              AND n.nspname = 'public'
        LOOP
            EXECUTE format('GRANT USAGE, SELECT, UPDATE ON SEQUENCE public.%I TO authenticated;', seq);
        END LOOP;
END
$$;

DO $$
BEGIN
    ------------------------------------------------------------------
    -- Create authenticated role if missing
    ------------------------------------------------------------------
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'authenticated') THEN
        EXECUTE 'CREATE ROLE authenticated NOLOGIN;';
    END IF;

    ------------------------------------------------------------------
    -- Set pgrst.count to 'estimated' for all users
    ------------------------------------------------------------------

    EXECUTE $f$
        ALTER ROLE authenticated SET pgrst.count = 'estimated';
        ALTER ROLE anon SET pgrst.count = 'estimated';
        ALTER ROLE web_anon SET pgrst.count = 'estimated';
    $f$;
    ------------------------------------------------------------------
    -- Helper Function: Get current user ID from JWT claims
    ------------------------------------------------------------------
    EXECUTE $func$
        CREATE OR REPLACE FUNCTION auth_user_id()
        RETURNS int AS $body$
        SELECT (current_setting('request.jwt.claims', true)::json ->> 'user_id')::int;
        $body$ LANGUAGE sql STABLE;
    $func$;

    ------------------------------------------------------------------
    -- PAY BALANCE
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.pay_balance ENABLE ROW LEVEL SECURITY;
        GRANT SELECT ON public.pay_balance TO authenticated;

        CREATE POLICY "user can view own balance"
        ON public.pay_balance
        FOR SELECT
        TO authenticated
        USING (user_id = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- PAY EXPENSE
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.pay_expense ENABLE ROW LEVEL SECURITY;
        GRANT SELECT ON public.pay_expense TO authenticated;

        CREATE POLICY "user can view own pay_expense"
        ON public.pay_expense
        FOR SELECT
        TO authenticated
        USING (user_id = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- TEAM
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.team ENABLE ROW LEVEL SECURITY;
        GRANT SELECT, INSERT, UPDATE ON public.team TO authenticated;
        GRANT SELECT ON public.team TO anon;

        CREATE POLICY "everyone can view team"
        ON public.team
        FOR SELECT
        TO authenticated, anon
        USING (true);

        CREATE POLICY "user can insert own team"
        ON public.team
        FOR INSERT
        TO authenticated
        WITH CHECK (user_id = auth_user_id());

        CREATE POLICY "user can update own team"
        ON public.team
        FOR UPDATE
        TO authenticated
        USING (user_id = auth_user_id())
        WITH CHECK (user_id = auth_user_id());
    $f$;
    
    ------------------------------------------------------------------  
      -- THEME
    ------------------------------------------------------------------

    EXECUTE $f$
      ALTER TABLE public.theme ENABLE ROW LEVEL SECURITY;
      GRANT SELECT, INSERT, UPDATE ON public.theme TO authenticated;
      GRANT SELECT ON public.theme TO anon;

      CREATE POLICY "everyone can view theme"
      ON public.theme
      FOR SELECT
      TO anon, authenticated
      USING (true);

      CREATE POLICY "user can insert own theme"
      ON public.theme
      FOR INSERT
      TO authenticated
      WITH CHECK (user_id = auth_user_id());

      CREATE POLICY "user can update own theme"
      ON public.theme
      FOR UPDATE
      TO authenticated
      USING (user_id = auth_user_id())
      WITH CHECK (user_id = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- TEAM PLAYER
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.team_player ENABLE ROW LEVEL SECURITY;
        GRANT SELECT, UPDATE ON public.team_player TO authenticated;
        GRANT SELECT ON public.team_player TO anon;

        CREATE POLICY "everyone can view team_player"
        ON public.team_player
        FOR SELECT
        TO anon, authenticated
        USING (true);

        CREATE POLICY "user can update own team_player"
        ON public.team_player
        FOR UPDATE
        TO authenticated
        USING (user_id = auth_user_id())
        WITH CHECK (user_id = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- TOUR TEAM
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.tour_team ENABLE ROW LEVEL SECURITY;
        GRANT SELECT, UPDATE ON public.tour_team TO authenticated;
        GRANT SELECT ON public.tour_team TO anon;

        CREATE POLICY "everyone can view tour_team"
        ON public.tour_team
        FOR SELECT
        TO authenticated, anon
        USING (true);

        CREATE POLICY "user can update own tour_team"
        ON public.tour_team
        FOR UPDATE
        TO authenticated
        USING (user_id = auth_user_id())
        WITH CHECK (user_id = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- USER
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public."user" ENABLE ROW LEVEL SECURITY;
        GRANT SELECT, UPDATE ON public."user" TO authenticated;
        GRANT SELECT ON public."user" TO anon;

        CREATE POLICY "user can update user"
        ON public."user"
        FOR UPDATE
        TO authenticated
        USING (id = auth_user_id())
        WITH CHECK (id = auth_user_id());

        CREATE POLICY "everyone can view user"
        ON public."user"
        FOR SELECT
        TO anon, authenticated
        USING (true);
    $f$;

    ------------------------------------------------------------------
    -- USER ACTIVITY
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.user_activity ENABLE ROW LEVEL SECURITY;
        GRANT SELECT ON public.user_activity TO authenticated;

        CREATE POLICY "user can select own user_activity"
        ON public.user_activity
        FOR SELECT
        TO authenticated
        USING (user_id = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- ACCOUNT
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.account ENABLE ROW LEVEL SECURITY;
        GRANT SELECT ON public.account TO authenticated;

        CREATE POLICY "user can view account"
        ON public.account
        FOR SELECT
        TO authenticated
        USING ("account"."userId" = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- SESSION
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.session ENABLE ROW LEVEL SECURITY;
        GRANT SELECT ON public.session TO authenticated;

        CREATE POLICY "user can view own session"
        ON public.session
        FOR SELECT
        TO authenticated
        USING ("session"."userId" = auth_user_id());
    $f$;

    ------------------------------------------------------------------
    -- BANNER
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.banner ENABLE ROW LEVEL SECURITY;
        GRANT SELECT, UPDATE ON public.banner TO authenticated;
        GRANT SELECT ON public.banner TO anon;

        CREATE POLICY "user can update banner"
        ON public.banner
        FOR UPDATE
        TO authenticated
        USING (true)
        WITH CHECK (true);

        CREATE POLICY "everyone can view banner"
        ON public.banner
        FOR SELECT
        TO anon, authenticated
        USING (true);
    $f$;

    ------------------------------------------------------------------
    -- NEWS
    ------------------------------------------------------------------
    EXECUTE $f$
        ALTER TABLE public.news ENABLE ROW LEVEL SECURITY;
        GRANT SELECT, UPDATE ON public.news TO authenticated;
        GRANT SELECT ON public.news TO anon;

        CREATE POLICY "user can update news"
        ON public.news
        FOR UPDATE
        TO authenticated
        USING (true)
        WITH CHECK (true);

        CREATE POLICY "everyone can view news"
        ON public.news
        FOR SELECT
        TO anon, authenticated
        USING (true);
    $f$;
END
$$;

DO $$
DECLARE
    t text;
BEGIN
    ------------------------------------------------------------------
    -- 2️⃣  Everyone Can SELECT Tables
    ------------------------------------------------------------------
    FOR t IN 
        SELECT unnest(ARRAY[
            'club',
            'competition',
            'match',
            'match_event',
            'pay_package',
            'player_point',
            'player_result',
            'player',
            'prize',
            'season',
            'system_config',
            'system_language',
            'system_notification',
            'tour',
            'user_prize'
        ])
    LOOP
        -- Enable RLS
        EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', t);
       
        -- Grant SELECT permission
        EXECUTE format('GRANT SELECT ON TABLE public.%I TO authenticated, anon;', t);

        -- Create Policy
        EXECUTE format(
            'CREATE POLICY all_users_can_select ON public.%I FOR SELECT TO anon, authenticated USING (true);',
            t
        );
    END LOOP;
END
$$;

-- Allow the postgres role to bypass RLS entirely
ALTER ROLE postgres BYPASSRLS;

-- Grant full privileges on all existing tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;

-- Grant full privileges on all existing sequences
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;

-- Grant full privileges on all existing functions
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO postgres;

-- Become the default owner of newly created objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON TABLES TO postgres;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON SEQUENCES TO postgres;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON FUNCTIONS TO postgres;