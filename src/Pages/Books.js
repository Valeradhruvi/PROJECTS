import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import AddBooks from "./AddBooks";

function Books() {
  const [data, setData] = useState([]);

    const apiUrl = "http://localhost:4000/get";

    useEffect(()=>{
        fetch(apiUrl, {method:"GET"})
        .then(res=>res.json())
        .then(res=>setData(res));
    },[]);


  let formattedBooks = data.map((book) => (
    <>
      <div className="card alert alert-danger" id="background" style={{width:200, height: 380,margin: '1rem',  float:"left" , marginLeft: "65px" }}>
      <div className="card-body" id="text">
        <img src={book.image} style={{height:"150px", width:"150px"} }/>
        <h5 className="card-title" style={{fontWeight: "bolder",  fontVariantCaps:"petite-caps"}}>{book.bookname}</h5>
        <p className="card-text ">Price: ${book.price}</p>
        <div><Link className="btn btn-info" to={"/books/"+book.bookname}>Read More</Link></div>
      </div>
    </div>
   
    </>
  ));

  return (
    <div style={{}}>
      <div style={{fontSize:"10mm" , color: "black" , fontFamily: "times new roman"}} className="d-flex justify-content-center mt-2">Books List</div>      
       <div style={{}}>
       {formattedBooks}  </div> 
    </div>
  );
}

export default Books;
