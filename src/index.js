import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter,Route, Routes } from 'react-router-dom';
import HomePage from './Pages/homepage';
import Layout from './Pages/layout';
import Books from './Pages/Books';
import AddBooks from './Pages/AddBooks';
import BookDetail from './Pages/bookDetails';
import EditBooks from './Pages/EditBooks'; 
import AboutUS from './Pages/Aboutus';


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <>
    <BrowserRouter>
      <Routes>
        <Route path='/' element={<Layout />}>
          <Route index element={<HomePage />}/>
          <Route path="/books" element={<Books />}/>
          <Route path='/books/:name' element={<BookDetail/>}></Route>
          <Route path="/books/addbooks" element={<AddBooks  />}></Route>
          <Route path="/books/edit/:name" element={<EditBooks  />}></Route>
          <Route path="/aboutUs" element={<AboutUS  />}>
        </Route>
        </Route>
      </Routes>
    </BrowserRouter>
  </>
);