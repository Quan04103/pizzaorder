const ProductModel = require('../model/product.model')

class SearchService {
  static async searchProductsByName(name) {
    try {
      const products = await ProductModel.find({ name: new RegExp(name, 'i') });
      return products;
    } catch (error) {
      throw error;
    }
  }
}
  
module.exports = SearchService;