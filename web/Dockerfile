FROM ruby:3.0.2
ENV RAILS_ENV=production
RUN apt update && apt install -y nodejs libpq-dev imagemagick libmagickwand-dev 
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler:2.2.22
COPY . .
RUN bundle install
EXPOSE 3000
