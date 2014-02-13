# Utilize Lo-Dash utility library
_ = require 'lodash'

# Extend the base configuration in all.coffee with environment
# specific configuraion

module.exports = _.assign(
  require(__dirname + '/../config/env/all.coffee')
  require(__dirname + '/../config/env/' + process.env.NODE_ENV + '.coffee') or {}
  )