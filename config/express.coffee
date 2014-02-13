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
  app.set 'views', __dirname + '/app/views/'
  app.set 'view engine', 'jade'
  console.log config.root
  # Enable jsonp
  app.enable 'jsonp callback'

  app.configure ->
    # The cookieParser should be above session
    app.use express.cookieParser()

    # Request body parsing middleware should be above methodOverride
    app.use express.urlencoded()
    app.use express.json()
    app.use express.methodOverride()

    # Express/Mongo session storage
    app.use express.session
      secret: config.sessionSecret
      store: new mongoStore
        db: db.connection.db
        collection: config.sessionCollection

    # Connect flash for flash messages
    app.use flash()

    # Dynamic helpers
    # app.use helpers(config.app.name)

    # User passport session
    app.use passport.initialize()
    app.use passport.session()

    # Routes should be at the last
    app.use app.router

    # Setting the fav icon and static folder
    app.use express.favicon()
    app.use express.static(config.root + 'public')

    # Assume "not found in the error msgs is a 404. This is somewhat
    # silly, but valid, you can do whatever you like, set properties,
    # use instanceof etc.
    app.use (err, req, res, next) ->
      # Treat as 404
      return next() if ~err.message.indexOf('not found')

      # Log it
      console.error err.stack

      # Error page
      res
        .status 500
        .render '500',
            error: err.stack

    # Assume 404 since no middleware responded
    app.use (req, res, next) ->
      res
        .status 404
        .render '404',
            url: req.originalUrl
            error: 'Not found'
