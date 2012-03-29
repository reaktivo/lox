# Lox

Lox is a tiny mongoose based authentication middleware for [Express](http://expressjs.com).
Lox tries to provide the minimum set of features to handle users.
Lox is written in coffeescript by Marcel Miranda [<reaktivo.com>](http://reaktivo.com).

Readable documentation is located at [reaktivo.github.com/lox](http://reaktivo.github.com/lox/)


## Installation

    npm install lox


## Usage

    # Start by adding as Express middleware
    mongoDb = 'mongodb://user:password@staff.mongohq.com:1234/whatever'
    app = express.createServer()
    # Make sure to add it after session middleware
    app.use express.session(secret: "234asldkn2naodufnu4n")
    app.use lox.middleware(mongoDb)

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

## Contributing to lox

 - Check out the latest master to make sure the feature hasn’t been implemented or the bug hasn’t been fixed yet
 - Check out the issue tracker to make sure someone already hasn’t requested it and/or contributed it
 - Fork the project
 - Start a feature/bugfix branch
 - Commit and push until you are happy with your contribution
 - Make sure to add tests for it. This is important so I don’t break it in a future version unintentionally.


Copyright © 2012 Marcel Miranda. See LICENSE for further details.