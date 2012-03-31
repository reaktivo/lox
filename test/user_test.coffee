assert = require 'assert'
lox = require '../lib/lox'
middleware = lox 'mongodb://tests:tests@staff.mongohq.com:10083/tests'

describe 'Lox', ->

  # Mock user
  form =
    email: 'some@email.com'
    password: 'somepassword'

  # Mock request
  req =
    session:
      destroy: -> # session destroyed

  describe 'lox.create', ->
    it 'should create without error', (done) ->
      lox.create form.email, form.password, done

  describe 'req.login', ->
    it 'should login without error', (done) ->
      # Simulate request flow with req, res, next
      middleware req, null, (err) ->
        done err if err
        req.login form.user, form.password, (err, user) ->
          assert(user.email == form.email, "User logged in")
          done(err)

  describe 'req.logout', ->
    it 'should logout without error', (done) ->
      # Simulate request flow with req, res, next
      middleware req, null, (err) ->
        done err if err
        req.logout done

  describe 'lox.getUser', ->
    it 'should find the created user', (done) ->
      lox.getUser form.email, (err, user) ->
        assert user.email == form.email, "Found user"
        do done

  describe 'lox.destroy', ->
    it 'should destroy without error', (done) ->
      lox.destroy form.email, done
