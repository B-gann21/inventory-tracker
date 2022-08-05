# Tea Subscription: A take-home for CTD Labs

## Description

- This is a simple inventory tracking app - Users can register an account with an email and password, and once logged in they can add/remove items from their inventory, keeping track of the item's quantity and price along the way. 

- The time frame for this project was one week; all design, planning, and implementation took place from `Tuesday, August 2nd, 2020` to `Sunday, August 7th, 2022`.  

# Using the app
- Try it out for yourself in the browser: [Heroku link](https://salty-wildwood-73308.herokuapp.com/)

<details>
  <summary>Local Setup Instructions</summary>

  - Make sure you have the right versions installed:
    - Ruby 2.7.4
    - Rails 5.2.8
    - Postgres 14.3
  - Then:
    - fork and clone this repository
    - `cd` into `inventory-tracker`
    - `bundle install` to install dependencies
    - `rails db:{create,migrate}` to setup the database
    - `rails s` to start your server (runs on localhost:3000 by default)
    - You're all set to visit localhost:3000 in the browser and interact with the app!

</details>

<details>
  <summary>Running the test suite</summary>

  - This project was built using TDD, and is fully tested using RSpec. All integration/unit tests can be found under the `spec` folder.
  - From the root directory, you can run `bundle exec rspec` to run the full test suite. This will also generate a coverage folder, and running `open coverage/index.html` will allow you to view a summary of the test coverage in the browser. 
  - You can run a single test file with `bundle exec rspec path/to/file_spec.rb`

</details>
