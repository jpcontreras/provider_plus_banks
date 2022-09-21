FROM ruby:2.7.0-alpine3.10

RUN apk add \
    build-base \
    postgresql-dev \
    tzdata \
    nodejs

WORKDIR /app
COPY Gemfile* .
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]