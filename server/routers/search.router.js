const router = require('express').Router();
const SearchController = require('../controller/search.controller');
const mongoose = require('mongoose');

// Định nghĩa route tìm kiếm sản phẩm
router.get('/search/:name', SearchController.searchProductsByName);

module.exports = router;