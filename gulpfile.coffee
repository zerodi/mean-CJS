###
  Dependencies
###
gulp = require 'gulp'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
jade = require 'gulp-jade'

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
  Watch changes
###
gulp.task 'watch', ->
  gulp.watch './src/jade/**/*', ['jade']
  gulp.watch './src/stylus/**/*', ['stylus']
  gulp.watch './src/coffee/**/*', ['coffee']

###
  Main
###
gulp.task 'default', ->
  gulp.run 'coffee', 'stylus', 'jade'

gulp.task 'watch', ->
  gulp.run 'coffee', 'stylus', 'jade', 'watch'
