const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;

const productSchema = new Schema({
    _id: Schema.Types.ObjectId,
    categoryId: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    name: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    image: {
        type: String,
        required: true,
    },
    more: {
        type: [String],
        required: true,
    },
    link: {
        type: String,
        required: true,
    },
    dateadded: {
        type: Date,
        required: true,
    }
}, { collection: 'product' });

const ProductModel = db.model('product', productSchema);

module.exports = ProductModel;