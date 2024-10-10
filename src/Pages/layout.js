import { Link, Outlet } from "react-router-dom";
import './Style.css';

function Layout(){
    return(
        <>
            <div className="container-fluid h-auto w-auto" class="generalBackground">
                <div className="row generalBackground2">
                    <div className="col-2"></div>
                    <div className="col-8">
                    <nav class="navbar navbar-expand-lg">
                            <div class="container-fluid">
                            <a class="navbar-brand" href="#"><img src="https://img.freepik.com/premium-vector/book-logo-template-design-education-icon-sign-symbol_752732-614.jpg" height={"70px"} width={"70px"}/></a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class=" d-flex justify-content-end" id="navbarSupportedContent">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item me-4 text">
                                    <Link className="nav-link" to='/'>HOME</Link>
                                </li>
                                <li class="nav-item me-4 text">
                                    <Link className="nav-link" to='/books'>BOOKS</Link>
                                </li>
                                <li class="nav-item me-4 text">
                                    <Link className="nav-link" to='/books/addBooks'>ADD BOOKS</Link>
                                </li>
                                <li class="nav-item me-4 text">
                                    <Link className="nav-link" to='/aboutUs'>ABOUT US</Link>
                                </li>
                            </ul>
                            {/* <form class="d-flex" role="search">
                                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"/>
                                <button class="btn btn-outline-success" type="submit">Search</button>
                            </form> */}
                            </div>
                        </div>
                        </nav>
                    </div>
                </div>
                <div className="row generalBackground" >
                    <div className="col-2"></div>
                    <div className="col-8">
                        <Outlet/>
                    </div>
                </div>
                <div className="row generalBackground mt-5" style={{width: "auto"}}>
                    <div className="col-2"></div>
                    <div className="col-8 w-100 d-flex justify-content-center" style={{backgroundColor: "brown"}}>
                        <p class="text mt-3">
                            A BookStore WebApp by Dhruvi Valera <hr/> <br/>
                        </p>
                    </div>
                </div>
            </div>
        </>
    )
}

export default Layout;