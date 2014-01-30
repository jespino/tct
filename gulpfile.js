var gulp = require('gulp');
var uglify = require('gulp-uglify');
var coffee = require('gulp-coffee');
var coffeelint = require('gulp-coffeelint');
var concat = require('gulp-concat');

gulp.task('dist', function() {
  return gulp.src(['src/*.coffee'])
    .pipe(coffee())
    .pipe(concat('tct.min.js'))
    .pipe(uglify())
    .pipe(gulp.dest('dist/'));
});

gulp.task('compile', function() {
  return gulp.src(['src/*.coffee'])
    .pipe(coffee())
    .pipe(concat('tct.js'))
    .pipe(gulp.dest('dist/'));
});

gulp.task('lint', function() {
  return gulp.src(['src/*.coffee'])
    .pipe(coffeelint('coffeelint.json'))
    .pipe(coffeelint.reporter())
});

// Rerun the task when a file changes
gulp.task('watch', function () {
  gulp.watch('src/*.coffee', ['compile']);
});

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['compile', 'watch']);
