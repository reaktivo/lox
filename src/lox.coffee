User = null
connection = null

setUser = (req, callback) ->
  if (req.session.user)
    getUser req.session.user, (err, user) ->
      req.user = user
      callback err, user
  else do callback

exports.middleware = (mongoDb) ->
  connection = exports.connection = require('./db')(mongoDb)
  User = exports.User = require('./user')(connection)

  (req, res, next) ->
    unless req.session
      next new Error "Express Session middleware required for auth"
    req.login = login(req)
    req.logout = logout(req)
    setUser req, next

exports.login = login = (req) ->
  (email, password = "", callback) ->
    getUser email, (err, user) ->
      callback err if err
      if user?.verify(password)
        req.session.user = user.email
      setUser req, (err, user) ->
        callback(err, user)

exports.logout = logout = (req) ->
  (callback) ->
    req.user = null
    do req.session.destroy
    do callback

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