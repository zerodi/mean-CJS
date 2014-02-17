###
  Module dependencies
###
should = require 'should'
mongoose = require 'mongoose'
User = mongoose.model('User')
Article = mongoose.model('Article')

user = undefined
article = undefined

#The tests
describe '<Unit Test>', ->
  describe 'Model Article:', ->
    beforeEach (done) ->
      user = new User
        name: 'Full name'
        email: 'test@test.com'
        username: 'user'
        password: 'password'

      user.save ->
        article = new Article
          title: 'Article Title'
          content: 'Article Content'
          user: user

        done()
        return
    return

    describe 'Method Save', ->
      it 'should be able to save without problems', (done) ->
        article.save (err) ->
          should.not.exist err
          done()
          return

      it 'should be able to show an error when try to save without title', (done) ->
        article.title = ''

        article.save (err) ->
          should.exist err
          done()
          return


    aftreEach (done) ->
      Article.remove {}
      User.remove {}
      done()
      return

    after (done) ->
      Article.remove().exec()
      User.remove().exec()
      done()
      return
