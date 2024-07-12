const router = require('express').Router();
const CategoryController = require('../controller/category.controller');
const mongoose = require('mongoose');


router.get('/getAllCategories', CategoryController.getAllCategories);
router.get('/getCategory/:categoryId', CategoryController.getCategoryById);

module.exports = router;