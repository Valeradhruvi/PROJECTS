// import { useEffect, useState } from "react";
// import { useNavigate, useParams } from "react-router-dom";


// function EditBooks(){
//     const [data, setData] = useState({});
//     const navigate = useNavigate();

//     const {name} = useParams();

//     return(
//         <>
//             <div>
//                 <div class="mb-3">
//                     <label class="form-label">Name</label>
//                     <input type="text" value={data.name} class="form-control" onChange={(e)=>{
//                         setData({
//                             ...data, name: e.target.value
//                         })
//                     }} placeholder="Enter name" />
//                 </div>
//                 <div class="mb-3">
//                     <label class="form-label">Description</label>
//                     <input type="text" value={data.description} class="form-control" onChange={
//                         (e)=>{
//                             setData({
//                                 ...data , description:e.target.value
//                             })
//                         }
//                     } placeholder="Enter Book Description"/>
//                 </div>
//                 <div class="mb-3">
//                     <label class="form-label">Author</label>
//                     <input type="text" value={data.author} class="form-control" onChange={
//                         (e)=>{
//                             setData({
//                                 ...data , author:e.target.value
//                             })
//                         }
//                     } placeholder="Enter Author"/>
//                 </div>
//                 <div class="mb-3">
//                     <label class="form-label">BookName</label>
//                     <input type="text" value={data.bookname} class="form-control" onChange={
//                         (e)=>{
//                             setData({
//                                 ...data , bookname:e.target.value
//                             })
//                         }
//                     } placeholder="Enter Book Name"/>
//                 </div>
//                 <div class="mb-3">
//                     <label class="form-label">Image</label>
//                     <input type="text" value={data.image} class="form-control" onChange={
//                         (e)=>{
//                             setData({
//                                 ...data , image:e.target.value
//                             })
//                         }
//                     } placeholder="Enter Image url"/>
//                 </div>
//                 <div class="mb-3">
//                     <label class="form-label">Price</label>
//                     <input type="text" value={data.price} class="form-control" onChange={
//                         (e)=>{
//                             setData({
//                                 ...data , price:e.target.value
//                             })
//                         }
//                     } placeholder="Enter price"/>
//                 </div>
//             </div>
//             <div className="mb-3">
//                 <button onClick={()=>{
//                     const apiUrl = "http://localhost:4000/get/"+name;

//                     fetch(apiUrl , {
//                         method: "PATCH",
//                         body:JSON.stringify(data),
//                         headers:{
//                             "Content-Type":"application/json"
//                         }
//                     })
//                     .then(res=>res.json())
//                     .then(
//                         res=>{navigate("/books");
//                     });
                    
//                 }} className="btn btn-primary">Edit</button>
//             </div>
//         </>
//     );
// }

// export default EditBooks;

import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

function EditBooks() {
    const [data, setData] = useState({
        name: "",
        description: "",
        author: "",
        bookname: "",
        image: "",
        price: ""
    });
    const navigate = useNavigate();
    const { name } = useParams();

    // Fetch existing data when the component loads
    useEffect(() => {
        const fetchData = async () => {
            const apiUrl = "http://localhost:4000/get/"+name;
            try {
                const response = await fetch(apiUrl);
                const result = await response.json();
                setData(result);
            } catch (error) {
                console.error("Error fetching the book data:", error);
            }
        };
        fetchData();
    }, [name]);

    return (
        <>
            <div>
                <div className="mb-3">
                    <label className="form-label">Name</label>
                    <input
                        type="text"
                        value={data.name}
                        className="form-control"
                        onChange={(e) => setData({ ...data, name: e.target.value })}
                        placeholder="Enter name"
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Description</label>
                    <input
                        type="text"
                        value={data.description}
                        className="form-control"
                        onChange={(e) => setData({ ...data, description: e.target.value })}
                        placeholder="Enter Book Description"
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Author</label>
                    <input
                        type="text"
                        value={data.author}
                        className="form-control"
                        onChange={(e) => setData({ ...data, author: e.target.value })}
                        placeholder="Enter Author"
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Book Name</label>
                    <input
                        type="text"
                        value={data.bookname}
                        className="form-control"
                        onChange={(e) => setData({ ...data, bookname: e.target.value })}
                        placeholder="Enter Book Name"
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Image</label>
                    <input
                        type="text"
                        value={data.image}
                        className="form-control"
                        onChange={(e) => setData({ ...data, image: e.target.value })}
                        placeholder="Enter Image URL"
                    />
                </div>
                <div className="mb-3">
                    <label className="form-label">Price</label>
                    <input
                        type="text"
                        value={data.price}
                        className="form-control"
                        onChange={(e) => setData({ ...data, price: e.target.value })}
                        placeholder="Enter price"
                    />
                </div>
            </div>
            <div className="mb-3">
                <button
                    onClick={() => {
                        const apiUrl = `http://localhost:4000/get/${name}`;
                        fetch(apiUrl, {
                            method: "PATCH",
                            body: JSON.stringify(data),
                            headers: {
                                "Content-Type": "application/json"
                            }
                        })
                            .then((res) => res.json())
                            .then(() => {
                                navigate("/books");
                            })
                            .catch((error) => {
                                console.error("Error updating the book data:", error);
                            });
                    }}
                    className="btn btn-primary"
                >
                    Edit
                </button>
            </div>
        </>
    );
}

export default EditBooks;
