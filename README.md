Mabouya
=====

### Installing

1. Clone this repo
2. Tested with Ruby 1.9.3 but should work with Ruby 2.1
3. Install gems with `bundle install`


### Loading dataset

1. Configure database.yml as needed and create the database
2. Run the migrations
3. Run `HitPopulator.populate_database`. This will populate the database with 1,000,000 records from 2014-05-01 to 2014-06-01 and takes about 3 minutes to complete on my machine

### Running the tests

Tests are written with RSpec.

1. Populate the test database from `HitPopulator`
2. `rake spec`
3. The Angular javascript is untested since it is trivial.

### Starting the server

1. I've only tested using the built in webrick server. Use `rails server` to start it.

### Accessing the frontend

1. It's at localhost:3000/


### The JSON API

1. [GET] /top_urls
2. [GET] /top_referrers
