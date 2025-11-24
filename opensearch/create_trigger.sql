-- PLAYER
CREATE TRIGGER notify__opensearch_player
BEFORE UPDATE ON player
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- CLUB
CREATE TRIGGER notify__opensearch_club
BEFORE UPDATE ON club
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- TEAM
CREATE TRIGGER notify__opensearch_team
BEFORE UPDATE ON team
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- MATCH
CREATE TRIGGER notify__opensearch_match
BEFORE UPDATE ON match
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- PLAYER_RESULT
CREATE TRIGGER notify__opensearch_player_result
BEFORE UPDATE ON player_result
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();

-- PLAYER_POINT
CREATE TRIGGER notify__opensearch_player_point
BEFORE UPDATE ON player_point
FOR EACH ROW
EXECUTE FUNCTION notify__opensearch();
