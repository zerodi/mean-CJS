module.exports =
  db: 'mongodb;//localhost/mean-test'
  port: 3001
  app:
    name: 'MEAN - A Modern Stack - Test'
  facebook:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/facebook/callbacc'
  twitter:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/twitter/callbacc'
  github:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/github/callbacc'
  google:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/google/callbacc'
  linkedin:
    clientID: 'APP_ID'
    clientSecret: 'APP_SECRET'
    callbackURL: 'http://localhost:3000/auth/linkedin/callbacc'