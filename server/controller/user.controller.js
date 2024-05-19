const UserService = require('../services/user.services')

exports.register = async (req, res, next) => {
    try {
        const { username, password, nameProfile, number, address, email } = req.body;
        
        const successRes = await UserService.registerUser(username, password, nameProfile, number, address, email)
        
        res.json({ status: true, success: "User registered successfully" });
    } catch (error) {
        next(error); // Chuyển lỗi đến middleware xử lý lỗi
    }
}
