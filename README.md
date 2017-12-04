# Bicimas

An app for those who use the Bicicas bike-sharing service in Castellón de la Plana, Spain. Provides supplementary information about the status of stations and individual bicycles. Try it out at [https://bicimas.herokuapp.com](https://bicimas.herokuapp.com)!

## Contributing

### Getting Started

* Getting the code
  * Run `git clone git@github.com:lbraun/bicimas.git`

* Installing dependencies
  * Make sure you have installed everything listed in the dependencies section below.
  * Install gem dependencies:
    * Install bundler by running `gem install bundler` from the project's root directory.
    * Install all required gems by running `bundle install`.

* Creating the database
  * Run `rake db:create` from the project's root directory.

* Initializing the database
  * Run `rake db:migrate` from the project's root directory.

* Running the app locally
  * Run `rails s` from the project's root directory.
  * Go to http://localhost:3000 in your web browser

* Deploying
  * Run `git push heroku master` from the project's root directory.

### Testing

* Running all tests
    * Run `rake` without any arguments from the project's root directory.

### Conventions
* Ruby: https://github.com/bbatsov/ruby-style-guide
* RSpec: https://github.com/reachlocal/rspec-style-guide
* Commit messages: http://chris.beams.io/posts/git-commit/#seven-rules

## Dependencies

* Ruby version 2.4.2 ([installation guide](https://www.ruby-lang.org/en/documentation/installation/))

* PostgreSQL version 10.1 ([installation guide](https://wiki.postgresql.org/wiki/Detailed_installation_guides))
