gulp = require('gulp')

gulp.task 'hello', () ->
  console.log "hello"


gulp.task 'copy-index', () ->
  gulp.src 'npm-debug.log'
      .pipe(gulp.dest('dist'))