var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var multer = require('multer')
var upload = multer({
  dest: 'uploads/'
})

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
  extended: false
}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

app.get('/hello2', function (req, res, next) {
  res.json('hello22222');
})

app.post('/upload', upload.single('logs'), function (req, res, next) {
  // req.files is array of `photos` files
  // req.body will contain the text fields, if there were any
  console.log(`111 req.files = ${JSON.stringify(req.files, null, '  ')}`)
  console.log(`111 req.body = ${JSON.stringify(req.body, null, '  ')}`)
  res.json({
    code: 0,
    errMsg: 'no error.'
  })
})

app.post('/uploadFiles', upload.array('logs'), function (req, res, next) {
  // req.files is array of `photos` files
  // req.body will contain the text fields, if there were any
  console.log(`111 req.files = ${JSON.stringify(req.files, null, '  ')}`)
  console.log(`111 req.body = ${JSON.stringify(req.body, null, '  ')}`)
  res.json({
    code: 0,
    errMsg: 'no error.2'
  })
})

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;