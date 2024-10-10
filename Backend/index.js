const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const books = require('./booksSchema');
 
const app = express();
app.use(cors());
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

const connectionString = "mongodb+srv://NewUser:newuser%40123dhruvi@cluster0.qyaiu.mongodb.net/BOOK";
mongoose.connect(connectionString).then(
    ()=>{
        console.log("Connection eshtablished successfully");
    

    //get by id
    // localhost:4000/get/bookname
    app.get('/get/:name' , async (req,res)=>{
        const data = await books.findOne({
            bookname : req.params.name
        });

        res.send(data);
    })
    
    //get all
    // localhost:4000/get
    app.get('/get' , async (req,res)=>{
        const ans = await books.find();
        res.send(ans);
    })
    
    //create
    // localhost:4000/books (with POST method)
    app.post('/books/addbooks' , async(req,res)=>{
        const data = new books({
            ...req.body
        });

        const ans = await data.save();
        res.send("data created successfully");
    })
    

    //update
    // localhost:4000/get/bookname (with PATCH method)
    app.patch('/get/:name' , async (req,res)=>{
        const data = await books.findOne({
            bookname : req.params.name
        })

        data.name = req.body.name;
        data.author = req.body.author;
        data.description = req.body.description;
        data.bookname = req.body.bookname;
        data.image = req.body.image;
        data.price = req.body.price;

        const ans = await data.save();
        res.send("Updated succefully");
    })
    

    //delete
    // localhost:4000/books/bookname (with DELETE method)
    app.delete('/get/:name' , async (req,res)=>{
        const ans = await books.deleteOne({
            bookname : req.params.name
        });

        res.send("deleted successfully");
    })
    

    app.listen(4000 , ()=>{
        console.log('server started at 4000');
    });
    }
)