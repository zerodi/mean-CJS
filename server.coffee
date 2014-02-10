###
  Module dependencies
###

express = require 'express'
fs = require 'fs'
passport = require 'passport'
logger = require 'mean-logger'

###
  Main application entry file.
  Please note that the order of loading is important.
###

# Load configurations
# Set the node enviornment variable if not set before
process.env.NODE_ENV = process.env.NODE_ENV or 'development'

# Initializing system variables
config = require './config/config'
mongoose = require 'mongoose'

db = mongoose.connect config.db

# Bootstrap models
models_path = __dirname + '/app/models'
walk = (path) ->
  fs
    .readdirSync path
    .forEach (file) ->
        newPath = path + '/' + file
        stat = fs.statSync newPath
        if stat.isFile()
          require newPath if /(.*)\.(js$|coffee$)/.test file
        else walk newPath if stat.isDirectory()

walk models_path

# Bootstrap passport config
require('./config/passport') passport

app = express

# Express settings
require('./config') app, passport, db

# Bootstrap routes
routes_path = __dirname + '/app/routes'
walk = (path) ->
  fs
    .readdirSync path
    .forEach (file) ->
        newPath = path + '/' + file
        stat = fs.statSync newPath
        if stat.isFile()
          require(newPath) app, passport if /(.*)\.(js$|coffee$)/.test file
        else walk newPath if stat.isDirectory() and file isnt 'middlewares'

walk routes_path

# start the app by listening on <port>
port = process.env.PORT or config.port
app.listen port
console.log 'Express app started on port ' + port

# Initializing logger
logger.init app, passport, mongoose

# Expose app
exports = module.exports = app
