# Provider Plus Banks API

## Running the app

```bash
docker-compose up --build
```

## Run database and migrations

```bash
docker-compose run --rm api rails db:create db:migrate
```

## How to create models

```bash
docker-compose run --rm web rails g model Joke body:text
```