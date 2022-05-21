import {Link, Routes, Route} from "react-router-dom";
import * as Auth from "./pages/auth";
import * as Post from "./pages/post";
import NotFound from "./pages/error/NotFound";
import './App.css';

function App() {
    return (
        <div className="App">
            <Routes>
                <Route path="/login" element={<Auth.Login/>}></Route>
                <Route path="/register" element={<Auth.Register/>}></Route>
                <Route path="/create" element={<Post.Create/>}></Route>
                <Route path="/update" element={<Post.Update/>}></Route>
                <Route path="/item" element={<Post.Item/>}></Route>
                <Route path="/" element={<Post.List/>}/>
                <Route path="*" element={<NotFound/>}></Route>
            </Routes>
        </div>
    );
}

export default App;
