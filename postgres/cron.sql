-- 1️⃣ Har 5 daqiqada (00, 05, 10, 15, ...)
SELECT cron.schedule( 
  'update_tour_status',
  '0-59/5 * * * *',
  $$
  SELECT update__tour__status_by_datetime_start();
  SELECT update__tour__status_by_datetime_end();
  $$
);

-- 2️⃣ Har 5 daqiqada, lekin 1 daqiqa keyin (01, 06, 11, 16, ...)
SELECT cron.schedule(
  'insert__team_player_copy_team_player__cron',
  '1-59/5 * * * *',
  $$
  SELECT insert__team_player_copy_team_player__cron();
  $$
);



SELECT cron.schedule(
  'update_eskiz_token',
  '0 */20 * * *',
  $$SELECT http__refresh_token();$$
);


SELECT cron.schedule(
  'update_t__order__from__t__point',    -- unique job name
  '*/5 * * * *',                         -- every 5 minutes
  $$SELECT t__order__from__t__point();$$
);


SELECT * FROM cron.job;

UPDATE cron.job SET nodename = '';
