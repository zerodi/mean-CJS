path = require 'path'
rootPath = path.normalize __dirname + '/../..'

module.exports =
  root: rootPath
  port: process.env.PORT or 3000
  db: process.env.MONGOHQ_URL
  templateEngine: 'jade'

  # The secret should be a non guessable string that
  # is used to compute a session hash
  sessionSecret: 'MEAN'
  sessionCollection: 'sessions'