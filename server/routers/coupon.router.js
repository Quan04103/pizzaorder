const router = require('express').Router();
const CouponController = require('../controller/coupon.controller');
const mongoose = require('mongoose');

router.get('/getAllCoupons', CouponController.getAllCoupons);
// tru usecount
router.put('/updateUsageCount/:id', CouponController.updateUsageCount);
module.exports = router;