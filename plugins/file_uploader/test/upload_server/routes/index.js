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

router.post('/post', function (req, res, next) {
  console.log(`${req.body}`);
  res.json({
    errCode: 0,
    errMsg: 'OK'
  });
});

router.get('/baidu', function (req, res, next) {
  console.log(`${req.body}`);
  res.redirect('http://baidu.com');
});

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

router.post('/postDelay', async function (req, res, next) {
  console.log(`${req.body}`);
  await sleep(8000);
  res.json({
    errCode: 0,
    errMsg: 'OK'
  });
});

router.get('/getTest', function (req, res, next) {
  console.log(`${req.body}`);
  res.json({
    errCode: 0,
    errMsg: 'OK'
  });
});

module.exports = router;