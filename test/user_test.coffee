express = require '../node_modules/express'
request = require '../node_modules/request'
assert = require 'assert'
lox = require '../lib/lox'

port = process.env.app_port || 6789
host = "http://localhost:#{port}"
form =
  email: 'some@email.com'
  password: 'somepassword'


app = do express.createServer
app.use express.session secret: 'sdlfkjasoef28r0asdfo'
app.use lox.middleware 'mongodb://tests:tests@staff.mongohq.com:10083/tests'
app.use app.router

# Send user json if it exists, else 401 response
app.post '/login', (req, res) ->
  req.login req.body.email, req.body.password, (err, user) ->
    res.send (if user then 200 else 500)

app.get '/logout', (req, res) -> req.logout -> res.send 200

# app.listen port

describe 'Lox', ->
  describe 'lox.create', ->
    it 'should create without error', (done) ->
      lox.create form.email, form.password, done

  # describe 'req.login', ->
  #   it 'should login without error', (done) ->
  #     url = "#{host}/login"
  #     request.post {form, url}, (err, res, body) ->
  #       assert res.statusCode == 200, "Status code == 200"
  #       do done

  describe 'lox.getUser', ->
    it 'should find the created user', (done) ->
      lox.getUser form.email, (err, user) ->
        assert user.email == form.email, "Found user"
        do done

  describe 'lox.destroy', ->
    it 'should destroy without error', (done) ->
      lox.destroy form.email, done
