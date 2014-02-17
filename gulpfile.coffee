###
  Dependencies
###
gulp = require 'gulp'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
jade = require 'gulp-jade'
nodemon = require 'gulp-nodemon'
mocha = require 'gulp-mocha'
karma = require 'gulp-karma'

###
  Compile Public Coffee
###
gulp.task 'coffee', ->
  gulp
    .src './src/coffee/**/*'
    .pipe coffee(bare: true).on 'error', console.log
    .pipe gulp.dest './public/js/'

###
  Compile Public Stylus
###
gulp.task 'stylus', ->
  gulp
    .src './src/stylus/*'
    .pipe stylus(use: ['nib']).on 'error', console.log
    .pipe gulp.dest './public/css/'

###
  Compile Public Jade
###
gulp.task 'jade', ->
  LOCALS = {}
  gulp
    .src './src/jade/**/*'
    .pipe jade(locals: LOCALS).on 'error', console.log
    .pipe gulp.dest './public/views/'

###
  Run Tests
###
gulp.task 'mocha', ->
  gulp
    .src './test/mocha/**/*.coffee'
    .pipe mocha(reporters: 'nyan', compilers: 'coddee:coffee-script/register').on 'error', console.log

gulp.task 'karma', ->
  gulp
    .pipe karma(configFile: './test/karma/karma.conf.coffee')

###
  Main
###
gulp.task 'default', ->
  gulp.run 'coffee'
  gulp.run 'stylus'
  gulp.run 'jade'

  nodemon
    script: 'server.coffee'