hash = require 'password-hash'
mongoose = require 'mongoose'

isEmail = (email) ->
  email.match(/^(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))$/)

UserSchema = new mongoose.Schema
  email:
    required: true
    type: String
    unique: true
    validate: [isEmail, 'Invalid email']
  password:
    required: true
    type: String
    set: hash.generate

UserSchema.statics.hash = hash.generate
UserSchema.methods.verify = (password) ->
  hash.verify password, this.password

module.exports = UserSchema