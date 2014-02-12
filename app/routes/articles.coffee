# Articles routes use articles controller
articles = require '../controllers/articles'
authorization = require './middlewares/authorization'

# Article authorization helpers
hasAuthorization = (req, res, next) ->
  return res.send 401, 'User is not authorized' if req.article.user.id isnt req.user.id
  next()

module.exports = (app) ->
  app.get '/articles', articles.all
  app.post '/articles', authorization.requireLogin, articles.create
  app.get '/articles/:articleId', articles.show
  app.put '/articles/:articleId', authorization.requireLogin, hasAuthorization, articles.update
  app.del '/articles/:articleId', authorization.requireLogin, hasAuthorization, articles.destroy

  # Finish with setting up the articleId param
  app.param 'articleId', articles.article