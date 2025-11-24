-- PLAYER
CREATE TRIGGER notify__opensearch_player
BEFORE INSERT OR UPDATE ON player
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- CLUB
CREATE TRIGGER notify__opensearch_club
BEFORE INSERT OR UPDATE ON club
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- TEAM
CREATE TRIGGER notify__opensearch_team
BEFORE INSERT OR UPDATE ON team
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- MATCH
CREATE TRIGGER notify__opensearch_match
BEFORE INSERT OR UPDATE ON match
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- PLAYER_RESULT
CREATE TRIGGER notify__opensearch_player_result
BEFORE INSERT OR UPDATE ON player_result
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- PLAYER_POINT
CREATE TRIGGER notify__opensearch_player_point
BEFORE INSERT OR UPDATE ON player_point
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();
