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

exports.getNewestProduct = async (req, res, next) => {
    try {
        const listProduct = await ProductService.getNewestProduct();
        if (!listProduct || listProduct.length === 0) {
            return res.status(404).json({ message: 'Product newest not found' });
        }
        console.log(listProduct.length);
        res.json(listProduct);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

