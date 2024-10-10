import { useState } from "react";
import { useNavigate } from "react-router-dom";


function AddBooks(){
    const [data, setData] = useState({});
    const navigate = useNavigate();
    return(
        <>
            <div>
                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-control" onChange={(e)=>{
                        setData({
                            ...data, name: e.target.value
                        })
                    }} placeholder="Enter name" />
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <input type="text" class="form-control" onChange={
                        (e)=>{
                            setData({
                                ...data , description:e.target.value
                            })
                        }
                    } placeholder="Enter Book Description"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Author</label>
                    <input type="text" class="form-control" onChange={
                        (e)=>{
                            setData({
                                ...data , author:e.target.value
                            })
                        }
                    } placeholder="Enter Author"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">BookName</label>
                    <input type="text" class="form-control" onChange={
                        (e)=>{
                            setData({
                                ...data , bookname:e.target.value
                            })
                        }
                    } placeholder="Enter Book Name"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Image</label>
                    <input type="text" class="form-control" onChange={
                        (e)=>{
                            setData({
                                ...data , image:e.target.value
                            })
                        }
                    } placeholder="Enter Image url"/>
                </div>
                <div class="mb-3">
                    <label class="form-label">Price</label>
                    <input type="text" class="form-control" onChange={
                        (e)=>{
                            setData({
                                ...data , price:e.target.value
                            })
                        }
                    } placeholder="Enter price"/>
                </div>
            </div>
            <div className="mb-3">
                <button onClick={()=>{
                    const apiUrl = "http://localhost:4000/books/addbooks";

                    fetch(apiUrl , {
                        method: "POST",
                        body:JSON.stringify(data),
                        headers:{
                            "Content-Type":"application/json"
                        }
                    })
                    .then(res=>res.json())
                    .then(
                        res=>{res.navigate('/books');
                    });
                    
                }} className="btn btn-primary" name="Submit">Submit</button>
            </div>
        </>
    )
}

export default AddBooks;