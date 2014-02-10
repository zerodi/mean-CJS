###
Module dependencies.
###

express = require 'express'
mongoStore = require('connect-mongo') express
flash = require 'connect-flash'
helpers = require 'view-helpers'
config = './config'

module.exports = (app, passport, db) ->
  app.set 'showStackError', true

  # Only use logger for development environment
  app.use express.logger('dev') if process.env.NODE_ENV is 'development'

  # Set views path and template engine
  app.set 'views', config.root + 'app/views'
  app.set 'view engine', 'jade'

