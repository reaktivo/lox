exports.login = (success = "/", fail = "/") ->
  (req, res, next) ->
    email = req.body.email
    password = req.body.password
    req.login email, password, (err, user) ->
      res.redirect (if user then success else fail)

exports.logout = (success = "/", fail = "/") ->
  (req, res, next) ->
    req.logout (err) ->
      res.redirect (if err then fail else success)