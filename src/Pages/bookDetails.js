import { useEffect, useState } from "react";
import { useNavigate, useParams , Link } from "react-router-dom";

function BookDetail(){
    const [bookdata , setBookdata] = useState([]);

    const {name} = useParams();

    const navigate = useNavigate();

    const apiUrl = "http://localhost:4000/get/"+name;

    useEffect(()=>{
        fetch(apiUrl , {method: "GET"})
        .then(res=>res.json())
        .then(res=>setBookdata(res));
    },[]);
    return(
        <>
            <table>
                <tr>
                    <td className="p-3">
                        <img src={bookdata.image} width={"200px"} height={"300px"}></img>
                    </td>
                    <tr>
                        <td className="text2">BookName:</td>
                        <td className="p-3 text3"><p>{bookdata.bookname}</p></td>
                    </tr>
                    <tr>
                        <td className="text2">Book Description:</td>
                        <td className="p-3 text3"><p>{bookdata.description}</p></td>
                    </tr>
                    <tr>
                        <th className="text2">Author Name:</th>
                        <td className="p-3 text3"><p>{bookdata.author}</p></td>
                    </tr>
                    <tr>
                        <th className="text2">Book Price:</th>
                        <td className="p-3 text3"><p>{bookdata.price}</p></td>
                    </tr>
                </tr>
            </table>

            <div>
                <Link className="btn btn-primary ms-3" to="/books">BACK</Link>
                <button className="btn btn-danger ms-3" onClick={
                    ()=>{
                        const apiUrl = 'http://localhost:4000/get/'+name;
                        fetch(apiUrl , {method: "DELETE"})
                        .then(res=>res.json())
                        .then(res=>{
                            navigate('/');
                        });

                    }
                }>Delete</button> 
                <div><Link className="btn btn-warning mt-3 ms-3" to={"/books/edit/"+bookdata.bookname}>Edit</Link></div>  
            </div>
        </>
    )
}

export default BookDetail;