import { Navigate, Outlet } from 'react-router-dom';

export const ProtectedRoute = ({ redirectPath = '/login' }) => {
    const user = null; // намутить проверку авторизации

    if (!user) {
        return <Navigate to={redirectPath} replace />;
    }

    return <Outlet />;
};