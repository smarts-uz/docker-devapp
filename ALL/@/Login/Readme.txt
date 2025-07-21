docker login [OPTIONS] [SERVER]

docker login --username asrorz --password _password_
docker login --username asrorz --password-stdin
docker login --username asrorz --password-stdin


--password , -p		Password
--username , -u		Username


type password.txt | docker login --username asrorz --password-stdin

type token.txt | docker login --username asrorz --password-stdin
