gulp = require('gulp')
sass = require('gulp-sass')
connect = require('gulp-connect')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
rename = require("gulp-rename");
imagemin = require('gulp-imagemin')

# 将01，02 合并为vendor.js, 然后输出，然后压缩，然后重命名，然后输出
gulp.task 'script', () ->
  gulp.src ['javascripts/01.js', 'javascripts/02.js']
      .pipe(concat('vendor.js'))
      .pipe(gulp.dest('dist/js'))
      .pipe(uglify())
      .pipe(rename('vendor.min.js'))
      .pipe(gulp.dest('dist/js'))


gulp.task 'server', () ->
  connect.server
    root:'dist'
    livereload:true

gulp.task 'hello', () ->
  console.log "hello"


gulp.task 'copy-index', () ->
  gulp.src 'index.html'
      .pipe(gulp.dest('dist'))
      .pipe(connect.reload())

# 复制images下面的所有格式为jpg的图片
gulp.task 'images', () ->
  gulp.src 'images/*.jpg'
      .pipe(gulp.dest('dist/images'))

# 使用'images/*' 则复制下面目录下面所有文件，会复制文件夹但不会复制文件夹下面的文件。
# 'images/*/*' 则会复制images下面的目录，及目录下面的所有文件，要是还有目录，则需要添加匹配
# 'images/**/*' 则会递归复制images下面的文件夹及内容

# 复制多个扩展名图片，注意逗号后面不能够有空格
gulp.task 'image-extend', () ->
  gulp.src 'images/*.{jpg,gif}'
      .pipe(imagemin())
      .pipe(gulp.dest('dist/images'))

# 复制多个目录下面的文件到某个目录, !json/select-*.json 为要排除的文件，前面加‘!’
gulp.task 'data', () ->
  gulp.src ['xml/*.xml', 'json/*.json', '!json/select-*.json']
      .pipe(gulp.dest('dist/data'))


# 按照数组去执行对应任务
gulp.task 'bulid', ['hello', 'images', 'data'], () ->
  console.log "all do"

# 监视对应文件，有变动则执行对应任务
gulp.task 'watch', () ->
  gulp.watch 'index.html', ['copy-index']
  gulp.watch 'images/**/*.{jpg,gif}', ['images']
  gulp.watch ['xml/*.xml', 'json/*.json', '!json.select-*.json'], ['data']


# 使用sass插件变异scss文件生成css，移动到对应文件夹
gulp.task 'sass', () ->
  gulp.src 'stylesheets/**/*.scss'
      .pipe(sass())
      .pipe(gulp.dest('dist/css'))

# 使用gulp命令直接执行这些任务
gulp.task 'default', ['server', 'watch']

