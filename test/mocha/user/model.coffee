###
  Module dependencies
###
should = require 'should'
mongoose = require 'mongoose'
User = mongoose.model 'User'

#Globals
user = undefined
user2 = undefined

#The tests
describe '<Unit Test>', ->
  describe 'Model User:', ->
    before (done) ->
      user = new User
        name: 'Full name'
        email: 'test@test.com'
        username: 'user'
        password: 'password'

      user2 = new User
        name: 'Full name'
        email: 'test@test.com'
        username: 'user'
        password: 'password'

      done()
      return

    describe 'Method Save', ->
      it 'should begin with no users', (done) ->
        User.find {}, (err, users) ->
          users.should.have.length(0)
          done()
          return
        return

      it 'should be able to save without problems', (done) ->
        user.save done
        return

      it 'should fail to save an existing user again', (done) ->
        user.save()
        return user2.save (err) ->
          should.exist err
          done()
          return

      it 'should be able to show an error when try to save without name', (done) ->
        user.name = ''
        return user.save (err) ->
          should.exist err
          done()
          return
      return

    after (done) ->
      User.remove().exec()
      done()
      return
    return
  return