const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;

const categorySchema = new Schema({
    _id: Schema.Types.ObjectId,
    nameCategory: {
        type: String,
        required: true,
    },
    image: {
        type: String,
        required: true,
    }
}, { collection: 'category' });

const CategoryModel = db.model('category', categorySchema);

module.exports = CategoryModel;