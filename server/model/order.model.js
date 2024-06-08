const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;

const orderSchema = new Schema({
    iduser: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    listorder: [
        { idproduct: Schema.Types.ObjectId, quantity: Number }
    ],
    price: {
        type: Number,
        required: true,
    },
    dateadded: {
        type: Date,
        required: true,
    }
}, { collection: 'order' });

const OrderModel = db.model('order', orderSchema);

module.exports = OrderModel;