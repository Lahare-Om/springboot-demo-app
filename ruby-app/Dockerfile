FROM ruby:3.2-alpine
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
EXPOSE 8080
CMD ["bundle", "exec", "ruby", "app.rb"]
