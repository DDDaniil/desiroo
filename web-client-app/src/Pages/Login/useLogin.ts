import { useState } from 'react';
import { loginUser } from '../../Api/Login.ts';
import { useNavigate } from 'react-router-dom';
import { Links } from '../../Consts/Links.ts';
import { persistanceStorage } from "../../Root/persistanceStorage.ts";

export const useLogin = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [validationStatus, setValidationStatus] = useState(true);
    const navigate = useNavigate();

    const handleLoginButton = async () => {
        const response = await loginUser({ email, password });
        const token = response?.data;
        if (response?.succeeded && token) {
            persistanceStorage.set('token', token);
            persistanceStorage.set('email', email);
            navigate(Links.Home)
        } else {
            setValidationStatus(false);
        }
    }

    return {
        setEmail,
        setPassword,
        validationStatus,
        handleLoginButton
    }
}