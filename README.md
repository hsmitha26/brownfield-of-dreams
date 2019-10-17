# Brownfield Of Dreams

Contributors:
* [Tyler Schaffer](https://github.com/tschaffer1618)
* [Smitha Hosmani](https://github.com/hsmitha26)

A paired project completed in 10 days in Module 3 of Backend Engineering at Turing School of Software and Design.

This is the first project where we built features on an existing code base, linked [here](https://github.com/turingschool-examples/brownfield-of-dreams).  Until this project we had built only greenfield projects in Rails and Ruby.

Click [here](http://stark-everglades-18768.herokuapp.com/) to access and explore our deployed application.

## About the Project

Learning goals for this project:
* Working in an existing code base
* Resolving issues related to versioning
* Consuming APIs
* OAuth2
* Email activation (using Send Grid) to complete user registration
* Send email invitation (using Send Grid) to invite GitHub users to register on our app
* Self-referntial association.  
* [Database diagram](https://github.com/hsmitha26/brownfield-of-dreams/blob/master/db/db_diagram.png) including tables we interacted with during this project


This Ruby on Rails application organizes YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page. The logged in user can also view the videos they have bookmarked.

A logged in user can connect to their GitHub using OAuth.  After successful authentication, the user can see links to their GitHub repositories, followers and following.  Logged in users can also add friends from their list of following and followers by clicking on "Add Friend" if the friend is a user on our application's database and has a GitHub account.

## Local Setup

#### Warning: you may need to resolve versioning issues, based on your environments of rbenv, Rails, Ruby, PostgreSQL, and Node.

### Versions
* [Ruby 2.4.1](https://www.ruby-lang.org/en/documentation/installation/)
* [Rails 5.2.0](https://rubyonrails.org/)

Clone down the repo
```
$ git clone git@github.com:hsmitha26/brownfield-of-dreams.git
$ cd brownfield-of-dreams
```

Install gem dependencies
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Generate application.yml
```
$ figaro install
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```
$ bundle exec rspec
```

Set existing videos' position to zero if position is missing:
```
$ bundle exec rake update_video:position
```

You will need to setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. There will be one failing spec if you don't have this set up.

You will also need:
* API key with GitHub and have it defined within ENV['example_github_token']
* GitHub client ID defined within ENV['github_client_id']
* GitHub client secret defined within ENV['github_client_secret']

To run tests: ```bundle exec rspec```

To run the application on the local server, have two tabs open in your terminal.
* in one tab, run: ```$ rails s```
* in the other tab, run: ```$ mailcatcher```

To interact with the application, open a new window in Chrome and visit: ```localhost:3000```

To access emails sent by the app, in a separate Chrome tab/window, visit: ```localhost:1080```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)
