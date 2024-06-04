const router = require('express').Router();
const ProductController = require('../controller/product.controller');
const mongoose = require('mongoose');

router.get('/getProduct', ProductController.getProduct);
router.get('/getNewestProduct', ProductController.getNewestProduct);

module.exports = router;