FROM ruby:2.6.5-alpine

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    yarn \
    tzdata

WORKDIR /app

COPY Gemfile* ./
COPY vendor ./vendor/

ARG RAILS_ENV=development
ENV RAILS_ENV=$RAILS_ENV

RUN if [ "$RAILS_ENV" = "production" ] || [ "$RAILS_ENV" = "staging" ]; then bundle install --jobs 4 --deployment --without development test; else bundle install --jobs 4 --path vendor/bundle; fi

COPY package.json* ./
COPY yarn.lock ./
RUN yarn install

COPY . /app

ARG DATABASE_URL="postgres://postgres@db"
ENV DATABASE_URL=$DATABASE_URL

ARG COMPILE_ASSETS
RUN if [ ! -z "$COMPILE_ASSETS" ] || [ "$RAILS_ENV" = "production" ] || [ "$RAILS_ENV" = "staging" ]; then bundle exec rake assets:precompile; fi

ENTRYPOINT [ "bundle", "exec" ]
