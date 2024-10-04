import "@mantine/core/styles.css";

import Layout from './Layout/Layout.tsx';
import Home from './Pages/Home/Home.tsx';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { ProtectedRoute } from './Components/ProtectedRoute.tsx';
import { WishlistsShelf } from './Pages/WishlistsShelf/WishlistsShelf.tsx';
import Registration from "./Pages/Registration/Registration.tsx";
import Login from "./Pages/Login/Login.tsx";
import { Links } from './Consts/Links.ts';
import Wishlists from "./Pages/Wishlists/Wishlist.tsx";


export default function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path={Links.Home} element={<Layout><Home /></Layout>} />
                <Route path={`${Links.Wishlists}/:id`} element={<Layout><Wishlists /></Layout>} />
                <Route path={Links.Registration} element={<Layout><Registration /></Layout>} />
                <Route path={Links.Login} element={<Layout><Login /></Layout>} />
                <Route path={Links.WishlistsShelf} element={<Layout><WishlistsShelf /></Layout>} />
                <Route element={<ProtectedRoute />}>
                </Route>
            </Routes>
        </BrowserRouter>
    );
}