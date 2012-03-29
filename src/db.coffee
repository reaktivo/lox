connection = null
module.exports = (mongoDb) ->
  mongoose = require 'mongoose'
  connection or= mongoose.createConnection mongoDb