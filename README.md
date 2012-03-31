# Lox

Lox is a tiny mongoose based authentication middleware for [Express](http://expressjs.com).
Lox tries to provide the minimum set of features to handle users.
Lox is written in coffeescript by Marcel Miranda [<reaktivo.com>](http://reaktivo.com).

[Source Code](https://github.com/reaktivo/lox) - [Documentation](http://reaktivo.github.com/lox/)


## Installation

    npm install lox


## Usage

    # Create express app
    app = express.createServer()

    # Make sure to add the session middleware
    app.use express.session(secret: "234asldkn2naodufnu4n")

    # Then use the lox middleware
    app.use lox('mongodb://user:password@staff.mongohq.com:1234/whatever')

    # Create a user
    lox.create email, password, (err) ->
      # err != undefined if user could not be created

    # Delete a user
    lox.destroy email, (err, user) ->
      # user.lastWords()

    # Get list of all users
    lox.find (err, users) ->
      # do something with users array

    # Get access to logged in user
    app.get '/who', (req, res) ->
      res.send req.user or "No user logged in"

    # Create session (login)
    app.post '/login', (req, res, next) ->
      email = req.body.email
      password = req.body.password
      req.login email, password, (err, user) ->
        if user then res.send "logged in as #{user.email}"
        else res.send  "not logged in"

    # Destroy session (logout)
    app.get '/logout', (req, res, next) ->
      req.logout -> res.redirect '/'

## Testing

As I said before, Lox is written in coffee-script, so I you want to contribute to it, you have to build your js and test you don't break anything
Tests use mocha are written in coffee-script also, so make sure you install developer dependencies beforehand.

    npm install --dev
    npm test

You can checkout the latest build status at [Travis CI](http://travis-ci.org/#!/reaktivo/lox).

## Contributing to lox

 - Check out the latest master to make sure the feature hasn’t been implemented or the bug hasn’t been fixed yet
 - Check out the issue tracker to make sure someone already hasn’t requested it and/or contributed it
 - Fork the project
 - Start a feature/bugfix branch
 - Commit and push until you are happy with your contribution
 - Make sure to add tests for it. This is important so I don’t break it in a future version unintentionally.


Copyright © 2012 Marcel Miranda. See LICENSE for further details.