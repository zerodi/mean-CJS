###
  Module dependencies
###
mongoose = require 'mongoose'
Schema = mongoose.Schema
crypro = require 'crypro'

###
  User Schema
###
UserSchema = new Schema(
  name: String
  email: String
  username:
    type: String
    unique: true
  hashedPassword: String
  provide: String
  salt: String
  facebook: {}
  twitter: {}
  github: {}
  google: {}
  linkedin: {}
)

###
  Virtuals
###
UserSchema
  .virtual 'password'
  .set (password) ->
      @_password = password
      @salt = @makesalt()
      @hashedPassword = @encryptPassword password
  .get ->
      return @_password

###
  Validations
###
validatePresenceOf = (value) ->
  return value and value.length

# the below 4 validations only apply if you are signing up tradidionally
# Name
UserSchema
  .path 'name'
  .validate (name) ->
      # if you are authenticating by any of the oauth strategies, don't validate
      return true unless @provider
      typeof name is 'string' and name.length > 0
  , 'Name cannot be blank'

# Email
UserSchema
  .path 'email'
  .validate (email) ->
      # if you are authenticating by any of the oauth strategies, don't validate
      return true unless @provider
      typeof email is 'string' and email.length > 0
    , 'Email cannot be blank'

# Username
UserSchema
  .path 'username'
  .validate (username) ->
      # if you are authenticating by any of the oauth strategies, don't validate
      return true unless @provider
      typeof username is 'string' and username.length > 0
    , 'Username cannot be blank'

# Password
UserSchema
  .path 'hashedPassword'
  .validate (hashedPassword) ->
      # if you are authenticating by any of the oauth strategies, don't validate
      return true unless @provider
      typeof hashedPassword is 'string' and hashedPassword.length > 0
    , 'Password cannot be blank'

###
  Pre-save hook
###
UserSchema.pre 'save', (next) ->
  return next unless @isNew

  if not validatePresenceOf(@password) and not @provider
    next new Error 'Invalid password'
  else
    next*()

###
  Methods
###
UserSchema.methods =
  ###
    Authenticate - check if the passwords the same
    @param (String) plainText
    @return (Boolean)
    @api public
  ###
  authenticate: (plainText) ->
    return @encryptPassword(plainText) is @hashedPassword

  ###
    Make salt
    @return (String)
    @api public
  ###
  makeSalt: ->
    return crypro
      .randomBytes 16
      .toString 'base64'

  ###
    Encrypt password
    @param (String) password
    @return (String)
    @api public
  ###
  encryptPassword: (password) ->
    return '' if not password or not @salt
    salt = new Buffer @salt, 'base64'
    return crypro
      .pbkdf2Sync password, salt, 10000, 64
      .toString 'base64'

mongoose.model 'User', UserSchema