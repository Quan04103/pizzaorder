const CategoryModel = require('../model/category.model');

class CategoryService {
    static async getAllCategories() {
        try {
            return await CategoryModel.find();
        } catch (error) {
            throw error.message;
        }
    }

    static async getCategoryById(categoryId) {
        try {
            const category = await CategoryModel.findById(categoryId);
            return category;
        } catch (error) {
            throw error.message;
        }
    }
}

module.exports = CategoryService;