const CouponModel = require('../model/coupon.model');


class CouponService {
  
    static async getAllCoupons() {
        try {
            return await CouponModel.find();
        } catch (error) {
            throw error.message;
        }
    }

    static async updateUsageCount(id) {
        try {
            const coupon = await CouponModel.findById(id);
            if (!coupon) {
                throw new Error('Coupon not found');
            }

            coupon.usageCount -= 1;
            if (coupon.usageCount < 0) coupon.usageCount = 0; // Đảm bảo usageCount không âm
            await coupon.save();

            return coupon;
        } catch (error) {
            throw error.message;
        }
    }


}

module.exports = CouponService;