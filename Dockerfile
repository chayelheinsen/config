FROM ruby:3.1.0

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  nodejs \
  postgresql-client \
  libpq-dev \ 
  libxml2-dev \
  libxslt1-dev

ENV PORT 3000
ENV APP_HOME /myapp
WORKDIR $APP_HOME

# Copy Gemfile
COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN bundle install --without production

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE $PORT

# Configure the main process to run when running the image

# Uncomment to use TLS
# CMD bundle exec rails s -b "ssl://0.0.0.0?key=${LOCALHOST_KEY_PATH}&cert=${LOCALHOST_CERT_PATH}&verify_mode=none"

# Don't use TLS
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]