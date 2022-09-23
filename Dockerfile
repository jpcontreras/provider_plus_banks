FROM ruby:2.7.6-alpine

RUN apk add \
    build-base \
    postgresql-dev \
    tzdata \
    nodejs

WORKDIR /app
COPY Gemfile* .
RUN bundle install