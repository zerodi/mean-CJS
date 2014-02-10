###
  Module dependencies
###
mongoose = require 'mongoose'
Article = mongoose.model 'Article'
_ = require 'lodash'

###
  Find article by id
###

exports.article = (req, res, next, id) ->
  Article.load id, (err, article) ->
    return next err if err
    return next new Error('Failed to load article ' + id) unless article
    req.article = article
    next()

###
  Create a article
###

exports.create = (req, res) ->
  article = new Article req.body
  article.user = req.user

  article.save (err) ->
    if err
      return res.send 'users/signup',
        errors: err.errors
        article: article
    else
      res.jsonp article
