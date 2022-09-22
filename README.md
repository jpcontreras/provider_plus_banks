# Provider Plus Banks API

## Running the app
```bash
docker-compose up --build
```

## Run database and migrations
```bash
docker-compose run --rm api rails db:create db:migrate
```

## Prepare test database
```bash
docker-compose run --rm api rails db:test:prepare
```

## How to create models
```bash
docker-compose run --rm api rails g model Joke body:text
```

## Run all unit tests
```bash
docker-compose run --rm api rspec
```