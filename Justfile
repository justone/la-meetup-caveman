# Shows available recipies
help:
    just --list

# Run application
run:
    clojure -M -m meetup.main

# Start nREPL server
nrepl:
    clojure -M:dev -m nrepl.cmdline

# Check formating
format_check:
    clojure -M:format -m cljfmt.main check src dev test

# Reformat code
format:
    clojure -M:format -m cljfmt.main fix src dev test

# Lint the code with clj-kondo
lint:
    clojure -M:lint -m clj-kondo.main --lint .

# Run tests
test:
    clojure -M:dev -m kaocha.runner

# Start development database
start-db:
    docker compose up -d

# Stop development database
stop-db:
    docker compose down

# Connect to the local postgres database
psql:
    PGPASSFILE=.pgpass psql -h localhost -U postgres "dbname=postgres options=--search_path=prehistoric"

# Download MyBatis and Postgres driver for migrations
setup-migration:
    rm migrations/mybatis-migrations.zip
    curl -L -o migrations/mybatis-migrations.zip https://github.com/mybatis/migrations/releases/download/mybatis-migrations-3.4.0/mybatis-migrations-3.4.0-bundle.zip
    unzip -o -d migrations migrations/mybatis-migrations.zip
    curl -L -o migrations/drivers/postgresql-42.7.5.jar https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.5/postgresql-42.7.5.jar

# Run MyBatis migrate command
[working-directory: 'migrations']
migrate *args:
    ./mybatis-migrations-3.4.0/bin/migrate {{args}}
