var express = require('express');
var router = express.Router();

// var multi = require('multer');
// var upload = multer({ dest: 'uploads/' })

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', {
    title: 'Express'
  });
});

// router.post('/upload', function (req, res, next) {

// });

module.exports = router;