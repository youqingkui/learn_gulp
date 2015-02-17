gulp = require('gulp')

gulp.task 'hello', () ->
  console.log "hello"


gulp.task 'copy-index', () ->
  gulp.src 'index.html'
      .pipe(gulp.dest('dist'))

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
      .pipe(gulp.dest('dist/images'))

# 复制多个目录下面的文件到某个目录, !json/select-*.json 为要排除的文件，前面加‘!’
gulp.task 'data', () ->
  gulp.src ['xml/*.xml', 'json/*.json', '!json/select-*.json']
      .pipe(gulp.dest('dist/data'))


# 按照数组去执行对应任务
gulp.task 'bulid', ['hello', 'images', 'data'], () ->
  console.log "all do"



