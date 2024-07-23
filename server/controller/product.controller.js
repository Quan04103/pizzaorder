const ProductService = require('../services/product.services');
require('dotenv').config();

exports.getAllProduct = async (req, res, next) => {
    try {
        const listProduct = await ProductService.getAllProduct();
        if (!listProduct) {
            throw new Error('Product not found');
        }
        res.json(listProduct);
    } catch (error) {
        next(error);
    }
};

exports.getProductByCategory = async (req, res, next) => {
    try {
        const categoryId = req.params.categoryId;
        const products = await ProductService.getProductByCategory(categoryId);
        if (!products || products.length === 0) {
            throw new Error('No products found for this category');
        }
        res.json(products);
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

exports.getProductById = async (req, res, next) => {
    try {
        const id = req.params.id; // Make sure your route uses 'id' as the parameter name
        if (!id) {
            return res.status(400).json({ message: 'Product ID is required' });
        }
        
        const product = await ProductService.getProductById(id); // Assuming ProductService handles fetching

        if (!product) {
            return res.status(404).json({ message: 'Product not found' });
        }

        res.json(product);
    } catch (error) {
        next(error);
    }
};

