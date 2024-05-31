const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');

const { Schema } = mongoose;

const userSchema = new Schema({
    username: {
<<<<<<< HEAD
=======
        type: String,
        lowercase: true,
        required: true
    },
    password: {
        type: String,
    },
    nameProfile: {
        type: String,
        required: true,
    },
    number: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true,
    },
    email: {
>>>>>>> ca086a72241af67e7e0802b0b3fc697a1cf12ecc
        type: String,
        lowercase: true,
        required: true,
    },
<<<<<<< HEAD
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

userSchema.pre('save', async function () {
    try {
        var user = this;
        const salt = await (bcrypt.genSalt(10));
=======
}, { collection: 'user' });

userSchema.pre('save', async function(){
    try {
        var user = this;
        const salt = await(bcrypt.genSalt(10));
>>>>>>> ca086a72241af67e7e0802b0b3fc697a1cf12ecc
        const hashpass = await bcrypt.hash(user.password, salt);

        user.password = hashpass;
    } catch (error) {
        throw error;
    }
});

<<<<<<< HEAD
userSchema.methods.comparePassword = async function (userPassword) {
=======
userSchema.methods.comparePassword = async function(userPassword){
>>>>>>> ca086a72241af67e7e0802b0b3fc697a1cf12ecc
    try {
        const isMatch = await bcrypt.compare(userPassword, this.password);
        return isMatch;
    } catch (error) {
        throw error
    }
}
const UserModel = db.model('user', userSchema);

module.exports = UserModel;