const mongoose = require("mongoose");

const User = mongoose.model('User', new mongoose.Schema({
    email: {
        type: String,
        unique: true,
        lowercase: true,
        required:'Please enter your email',
        match: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    },
    password: {
        type: String,
        required: 'Please enter your password',
        minlength: 6,
        maxlength:255
    }
}));

exports.User =User;