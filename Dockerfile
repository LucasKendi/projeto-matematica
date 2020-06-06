# Dockerfile - Development environment
FROM ruby:2.7 

RUN mkdir /projeto
WORKDIR /projeto
COPY Gemfile /projeto/Gemfile
COPY Gemfile.lock /projeto/Gemfile.lock

# nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn postgresql-client

# rails
RUN gem install bundler:1.17.3
RUN bundle install

COPY . /projeto

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]