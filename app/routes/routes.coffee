# User routes use users controller
users = require '../controllers/users'

module.exports = (app, passport) ->

  app.get '/signin', users.signin
  app.get '/signup', users.signup
  app.get 'signout', users.signout
  app.get 'users/me', users.me

  # Setting ip the users api
  app.post '/users', users.create

  # Setting up the userId param
  app.param 'userId', users.user

  # Setting up local strategy
  app.post '/users/session', passport.authenticate 'local',
    failureRedirect: '/signin'
    failureFlash: true
  , users.session

  # Setting the facebook oauth routes
  app.get '/auth/facebook', passport.authenticate 'facebook',
      scope: [
        'email'
        'user_abou_me'
      ]
      failureRedirect: '/signin'
  , users.signin

  app.get '/auth/facebook/callback', passport.authenticate 'facebook',
    failureRedirect: 'signin'
  , users.authCallback

  # Setting the github oauth routes
  app.get '/auth/github', passport.authenticate 'github',
    failureRedirect: '/signin'
  , users.signin

  app.get '/auth/github/callback', passport.authenticate 'github',
    failureRedirect: 'signin'
  , users.authCallback

  # Setting the twitter oauth routes
  app.get '/auth/twitter', passport.authenticate 'twitter',
    failureRedirect: '/signin'
  , users.signin

  app.get '/auth/twitter/callback', passport.authenticate 'twitter',
    failureRedirect: 'signin'
  , users.authCallback

  # Setting the google oauth routes
  app.get '/auth/google', passport.authenticate 'google',
    failureRedirect: '/signin'
    scope: [
      'https://www.googleapis.com/auth/userinfo.profile'
      'https://www.googleapis.com/auth/userinfo.email'
    ]
  , users.signin

  app.get '/auth/google/callback', passport.authenticate 'google',
    failureRedirect: 'signin'
  , users.authCallback

  # Setting the linkedin oauth routes
  app.get '/auth/linkedin', passport.authenticate 'linkedin',
    failureRedirect: '/signin'
    scope: [
      'r_emailaddress'
    ]
  , users.signin

  app.get '/auth/linkedin/callback', passport.authenticate 'linkedin',
    failureRedirect: 'signin'
  , users.authCallback
