const mongoose = require('mongoose');

const schema = new mongoose.Schema({
    name: {type : String },
    description: {type : String},
    author: {type : String},
    bookname: {type : String},
    image: {type : String},
    price: {type : Number},
});

module.exports = mongoose.model("books" , schema);