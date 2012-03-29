User = null
connection = null

exports.middleware = (mongoDb) ->

  connection = exports.connection = require('./db')(mongoDb)
  User = exports.User = require('./user')(connection)

  (req, res, next) ->
    unless req.session
      next new Error "Express Session middleware required for auth"

    lookForUser = (callback) ->
      if (userSession = req.session.userSession)
        getUser userSession, (err, user) ->
          req.user = user
          callback err, user
      else do callback

    req.login = (email, password = "", callback) ->
      getUser email, (err, user) ->
        callback err if err
        if user?.verify(password)
          req.session.userSession = user.email
        lookForUser (err, user) -> callback(err, user)

    req.logout = (callback) ->
      req.user = null
      do req.session.destroy
      do callback

    lookForUser next

exports.getUser = getUser = (query, callback) ->
  if typeof query is "string"
    query = email: query
  User.findOne query, callback

exports.create = (email, password, callback) ->
  new User({email, password}).save (err) -> callback(err)

exports.destroy = (query, callback) ->
  getUser query, (err, user) ->
    if user then user.remove callback(null, user)
    else callback err

exports.find = (query, callback) ->
  unless callback
    callback = query
    query = {}
  User.find query, (err, users) -> callback(err, users)