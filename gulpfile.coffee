gulp = require 'gulp'

coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
jade = require 'gulp-jade'

gulp.task 'coffee', ->
  gulp
    .src './src/coffee/**/*'
    .pipe coffee(bare: true).on 'error', console.log
    .pipe gulp.dest './public/js/'

gulp.task 'stylus', ->
  gulp
    .src './src/stylus/*'
    .pipe stylus(use: ['nib']).on 'error', console.log
    .pipe gulp.dest './public/css/'

gulp.task 'jade', ->
  LOCALS = {}
  gulp
    .src './src/jade/**/*'
    .pipe jade(locals: LOCALS).on 'error', console.log
    .pipe gulp.dest './public/views/'

gulp.task 'default', ->
  gulp.run 'coffee', 'stylus', 'jade'