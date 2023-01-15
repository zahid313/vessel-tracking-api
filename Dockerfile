# Use the official Ruby image as the base image
FROM ruby:3.2

# Install Vim
RUN apt-get update && apt-get install -y vim

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock ./

# Install the dependencies
RUN bundle install

RUN bundle exec rails db:create && bundle exec rails db:migrate

# Expose the port that the application will run on
EXPOSE 3000
# # Run the Rails server command by default when the container starts
CMD ["rails", "server", "-b", "0.0.0.0"]
