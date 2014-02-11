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
  Create an article
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

###
  Update an article
###
exports.update = (req, res) ->
  article = req.article

  article = _.assign(article, req.body)

  article.save (err) ->
    if err
      return res.send 'users/signup',
        errors: err.errors
        article: article
    else
      res.jsonp article

###
  Delete an article
###
exports.destroy = (req, res) ->
  article = req.article

  article.remove (err) ->
    if err
      return res.send 'users/signup',
        errors: err.errors
        article: article
    else
      res.jsonp(article)

###
  Show an article
###
exports.show = (req, res) ->
  res.jsonp req.article

###
  List of Articles
###
exports.all = (req, res) ->
  Article
    .find()
    .sort '-created'
    .populate 'user', 'name username'
    .exec (err, articles) ->
          if (err)
            res.render 'error',
              status: 500
          else
            res.jsonp articles