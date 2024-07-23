const router = require('express').Router();
const ProductController = require('../controller/product.controller');
const mongoose = require('mongoose');

router.get('/getAllProduct', ProductController.getAllProduct);
router.get('/getNewestProduct', ProductController.getNewestProduct);
router.get('/getProduct/:categoryId', ProductController.getProductByCategory);
router.get('/product/:id', ProductController.getProductById);

module.exports = router;