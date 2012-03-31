# Lox

Lox is a tiny mongoose based authentication middleware for [Express](http://expressjs.com).
Lox tries to provide the minimum set of features to handle users.
Lox is written in coffeescript by [Marcel Miranda](http://reaktivo.com).

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

## Login and logout for the lazy

Lox also provides login and logout middleware so you can quickly add it to your express project.

    # Both the login and logout handlers receive
    # parameters for uri's to redirect to if
    # attempt is successful or failure.

    # Login
    app.post "/login", lox.routes.login("/success_uri", "/fail_uri")

    # Logout
    app.get "/logout", lox.routes.logout("/success_uri", "/fail_uri")


## Testing

Lox is written in coffeescript, so if you want to contribute, build your js and then test so you don't break anything.
Tests use mocha, so make sure you install developer dependencies beforehand.

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