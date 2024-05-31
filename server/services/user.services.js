const UserModel = require('../model/user.model')
const jwt = require('jsonwebtoken');


class UserService {
    static async registerUser(username, password, nameProfile, number, address, email) {
        try {
            const createUser = new UserModel({ username, password, nameProfile, number, address, email });
            return await createUser.save();
        } catch (error) {
            throw new Error(error.message);
        }
    }
<<<<<<< HEAD
    static async checkUser(username) {
        try {
            return await UserModel.findOne({ username })
=======
    static async checkUser(username){
        try {
            return await UserModel.findOne({username})
>>>>>>> ca086a72241af67e7e0802b0b3fc697a1cf12ecc
        } catch (error) {
            throw error;
        }
    }
<<<<<<< HEAD
    static async generateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
=======
    static async generateToken(tokenData, secretKey, jwt_expire){
        return jwt.sign(tokenData, secretKey, {expiresIn: jwt_expire});
>>>>>>> ca086a72241af67e7e0802b0b3fc697a1cf12ecc
    }
}

module.exports = UserService;