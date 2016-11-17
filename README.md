Job Vacancy Application
=======================

[![Build Status](https://snap-ci.com/alejandroSchnidrig/job-vacancy/branch/develop/build_image)](https://snap-ci.com/alejandroSchnidrig/job-vacancy/branch/develop)

Once you have clone this repository, follow these steps to start working:

* Run **_bundle install --without staging production_**, to install all application dependencies
* Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
* Run **_bundle exec padrino start_ -h 0.0.0.0**, to start the application

* Run "padrino rake" when the web display "internal server error" (because db migration has not run yet)
* If you are not relying on the data in the database, a rake db:reset would re-run all migrations from scratch. Otherwise you have to make the conflicting migration recognized as already-run by adding to the schema_migrations table.

Some conventions to work on it:

* Follow existing coding conventions
* Use feature branch
* Add descriptive commits messages in English to every commit
* Write code and comments in English
* Use REST routes
