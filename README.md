# Lox

[![Greenkeeper badge](https://badges.greenkeeper.io/reaktivo/lox.svg)](https://greenkeeper.io/)

Lox is a tiny mongoose based authentication middleware for [Express](http://expressjs.com).
It tries to provide the minimum set of features to handle user authentication.
Lox is written in coffeescript by [Marcel Miranda](http://reaktivo.com).

[Source Code](https://github.com/reaktivo/lox) - [Documentation](http://reaktivo.github.com/lox/)


## Installation

    npm install lox


## Usage

    # Create express app
    app = express.createServer()

    # Make sure to add the session middleware
    app.use express.session(secret: "234asldkn2naodufnu4n")

    # Create an instance of mongoose
    mongoose = require 'mongoose'
    mongoDb = mongoose.createConnection 'mongodb://user:password@staff.mongohq.com:1234/whatever'

    # Then use the lox middleware
    app.use lox(mongoDb)

    # or just pass a mongodb connection string directly
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

    # You can also access the user from a view
    # via the 'user' local


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


## Extending the User Model

The default User model that comes with lox only contains the `email` and `password` fields with corresponding validation and hashing features.
You can extend it by passing a second parameter to the lox function, which receives the UserSchema as an argument. For more info check out
Mongoose's [plugin functionality](http://mongoosejs.com/docs/plugins.html)

    lox = require 'lox'

    extendFn = (UserSchema) ->
      UserSchema.add {
        name: String
        age: Number
      }

    app.use lox(mongoDb, extendFn)

## Version History

 - 0.4.1 Force trimmed and lowercased email
 - 0.4.0 Adds functionality to extend User Schema
 - 0.3.4 Updated to latest Mongoose (2.6.8)
 - 0.3.3 Correctly expose User Schema via lox.Schema
 - 0.3.1 Fixed error requiring db
 - 0.3.0 Allows sharing a mongoose instance when calling the lox method


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