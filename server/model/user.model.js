const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');

const { Schema } = mongoose;

const userSchema = new Schema({
    username: {
        type: String,
        lowercase: true,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
    nameProfile: {
        type: String,
        required: true,
    },
    number: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        lowercase: true,
        required: true,
    },
}, { collection: 'user' });

userSchema.pre('save', async function (next) {
    // Kiểm tra xem trường 'password' có được sửa đổi không
    if (!this.isModified('password')) {
        return next();
    }
    try {
        var user = this;
        const salt = await (bcrypt.genSalt(10));
        const hashpass = await bcrypt.hash(user.password, salt);
        user.password = hashpass;
    } catch (error) {
        throw error;
    }
});

userSchema.methods.comparePassword = async function (userPassword) {
    try {
        const isMatch = await bcrypt.compare(userPassword, this.password);
        return isMatch;
    } catch (error) {
        throw error
    }
}
const UserModel = db.model('user', userSchema);

module.exports = UserModel;