var express = require('express');
var router = express.Router();

/*Get home page*/
router.get('/', (req, res, next) => {
    res.render('index', {title: 'Express'});
});

module.exports = router;