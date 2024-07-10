const CategoryService = require('../services/category.services');
require('dotenv').config();

exports.getAllCategories = async (req, res, next) => {
    try {
        const categories = await CategoryService.getAllCategories();
        if (!categories) {
            throw new Error('Categories not found');
        }
        res.json(categories);
    } catch (error) {
        next(error);
    }
};

exports.getCategoryById = async (req, res, next) => {
    try {
        const categoryId = req.params.categoryId;
        const category = await CategoryService.getCategoryById(categoryId);
        if (!category) {
            throw new Error('Category not found');
        }
        res.json(category);
    } catch (error) {
        next(error);
    }
};