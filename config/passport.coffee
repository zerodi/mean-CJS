mongoose = require 'mongoose'
LocalStrategy = require('passport-local').Strategy
TwitterStrategy = require('passport-twitter').Strategy
FacebookStrategy = require('passport-facebook').Strategy
GitHubStrategy = require('passport-github').Strategy
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
LinkedinStrategy = require('passport-linkedin').Strategy
User = mongoose.model('User')
config = require './config'

module.exports = (passport) ->

  # Serialize the user id to push into the session
  passport.serializeUser (user, done) ->
    done null, user.id

  # Deserialize the user object based on a preserialized token
  # which is the user id
  passport.deserializeUser (id, done) ->
    User.findOne
      _id: id
    , '-salt -hashedPassword', (err, user) ->
        done err, user

  # Use Local strategy
  passport.use new LocalStrategy
    usernameField: 'email'
    passwordField: 'password'
  , (email, password, done) ->
      User.findOne
        email: email
      , (err, user) ->
          return done err if err
          unless user
            return done null, false,
              message: 'Unknown user'
          unless user.authenticate password
            return done null, false,
              message: 'Invalid password'
          done null, user

  # Use twitter strategy
  passport.use new TwitterStrategy
    consumerKey: config.twitter.clientID
    consumerSecret: config.twitter.clientSecret
    callbackUrl: config.twitter.callbackURL
  , (token, tokenSecret, profile, done) ->
    User.findOne
      'twitter.id_str': profile.id
    , (err, user) ->
      return done err if err
      unless user
        user = new User
          name: profile.displayName
          username: profile.username
          provider: 'twitter'
          twitter: profile._json
        user.save (err) ->
          console.log err if err
          return done err, user
      else
        done err, user

  # Use facebook strategy
  passport.use new FacebookStrategy
    clientID: config.facebook.clientID
    clientSecret: config.facebook.clientSecret
    callbackUrl: config.facebook.callbackURL
  , (accessToken, refreshToken, profile, done) ->
    User.findOne
      'facebook.id': profile.id
    , (err, user) ->
      return done err if err
      unless user
        user = new User
          name: profile.displayName
          email: profile.emails[0].value
          username: profile.username
          provider: 'facebook'
          facebook: profile._json
        user.save (err) ->
          console.log err if err
          done err, user
      else
        done err, user

  # Use github strategy
  passport.use new GitHubStrategy
    clientID: config.github.clientID
    clientSecret: config.github.clientSecret
    callbackUrl: config.github.callbackURL
  , (accessToken, refreshToken, profile, done) ->
    User.findOne
      'github.id': profile.id
    , (err, user) ->
      return done err if err
      unless user
        user = new User
          name: profile.displayName
          email: profile.emails[0].value
          username: profile.username
          provider: 'github'
          github: profile._json
        user.save (err) ->
          console.log err if err
          done err, user
      else
        done err, user

  # Use google strategy
  passport.use new GoogleStrategy
    clientID: config.google.clientID
    clientSecret: config.google.clientSecret
    callbackUrl: config.google.callbackURL
  , (accessToken, refreshToken, profile, done) ->
    User.findOne
      'google.id': profile.id
    , (err, user) ->
      return done err if err
      unless user
        user = new User
          name: profile.displayName
          email: profile.emails[0].value
          username: profile.username
          provider: 'google'
          google: profile._json
        user.save (err) ->
          console.log err if err
          done err, user
      else
        done err, user

  # Use linkedin strategy
  passport.use new LinkedinStrategy
    consumerKey: config.linkedin.clientID
    consumerSecret: config.linkedin.clientSecret
    callbackUrl: config.linkedin.callbackURL
    profileFields: [
      'id'
      'first-name'
      'last-name'
      'email-address'
    ]
  , (accessToken, refreshToken, profile, done) ->
    User.findOne
      'linkedin.id_str': profile.id
    , (err, user) ->
      return done err if err
      unless user
        user = new User
          name: profile.displayName
          username: profile.username
          provider: 'linkedin'
        user.save (err) ->
          console.log err if err
          done err, user
      else
        done err, user