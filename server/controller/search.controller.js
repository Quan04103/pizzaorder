const SearchService = require('../services/search.service');
require('dotenv').config();

exports.searchProductsByName = async (req, res, next) => {
    try {
        const name = req.params.name;
        const products = await SearchService.searchProductsByName(name);
        if (!products || products.length === 0) {
            throw new Error('Error searching for products');
        }
        res.json(products);
    } catch (error) {
        next(error);
    }
};