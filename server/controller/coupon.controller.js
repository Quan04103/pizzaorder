const CouponService  = require('../services/coupon.service');
require('dotenv').config();

exports.getAllCoupons = async (req, res, next) => {
    try {
        const listCoupon = await CouponService.getAllCoupons();
        if (!listCoupon) {
            throw new Error('Coupon not found');
        }
        res.json(listCoupon);
    } catch (error) {
        next(error);
    }
};
// tru usecount
exports.updateUsageCount = async (req, res, next) => {
    const { id } = req.params;
    try {
        const updatedCoupon = await CouponService.updateUsageCount(id);
        res.json(updatedCoupon);
    } catch (error) {
        next(error);
    }
};