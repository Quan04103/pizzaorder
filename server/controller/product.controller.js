const ProductService = require('../services/product.services');
require('dotenv').config();

exports.getProduct = async (req, res, next) => {
    try {
        const listProduct = await ProductService.getProduct();
        if (!listProduct) {
            throw new Error('Product not found');
        }
        res.json(listProduct);
    } catch (error) {
        next(error);
    }
};
