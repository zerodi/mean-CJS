module.exports = (app) ->

  # Home route
  index = require '../controllers/index'
  app.get '/', index.render
