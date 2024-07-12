const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;

const couponSchema = new Schema({
    _id: Schema.Types.ObjectId,
    code: {
        type: String,
        required: true,
        unique: true
    },
    description: {
        type: String,
        required: true
    },
    expiryDate: {
        type: Date,
        required: true
    },
    usageCount: {
        type: Number,
        default: 0
    },
    discount: {
        type: String,
        required: true
    },
}, { collection: 'coupon' });
const CouponModel = db.model('coupon', couponSchema);

module.exports = CouponModel;
