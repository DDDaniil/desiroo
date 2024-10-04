import { useState } from 'react';
import { Links } from '../../Consts/Links.ts';
import { useNavigate } from 'react-router-dom';
import { loginUser } from "../../Api/Login.ts";
import { persistanceStorage } from "../../Root/persistanceStorage.ts";
import { registerUser } from '../../Api/Registration.ts';

const useRegistration = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [validationStatus, setValidationStatus] = useState(true);
    const navigate = useNavigate();

    const handleRegisterButton = async () => {
        const response = await registerUser({ email, password });
        if (!(response && response?.succeeded)) {
            setValidationStatus(false);
            return;
        }

        const loginResponse = await loginUser({ email, password });
        const loginData = loginResponse?.data;

        if (!(loginResponse && loginData)) {
            setValidationStatus(false);
            return;
        }

        persistanceStorage.set('email', email);
        persistanceStorage.set('token', loginData);
        navigate(Links.Home)
    }

    return {
        setEmail,
        setPassword,
        validationStatus,
        handleRegisterButton
    }
}

export default useRegistration;