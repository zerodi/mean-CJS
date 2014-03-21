module.exports =
  db: 'mongodb://localhost/coffee'
  app:
    name: 'MEAN - A Modern Stack - Production'
  facebook:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/facebook/callback'
  twitter:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/twitter/callback'
  github:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/github/callback'
  google:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/google/callback'
  linkedin:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/linkedin/callback'
