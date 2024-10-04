import styles from './Login.module.scss';
import { Button, TextInput } from "@mantine/core";
import { useLogin } from './useLogin.ts';



function Login() {
    const {
        setEmail,
        setPassword,
        validationStatus,
        handleLoginButton
    } = useLogin();

    return (
        <div className={styles['login-container']}>
            <div className={styles['title']}>
                <span>Login</span>
            </div>
            <div className={styles['description']}>
                <span>Please enter your email</span>
            </div>
            <div className={styles['input']}>
                <TextInput
                    error={validationStatus ? '' : ' '}
                    placeholder={'email'}
                    onChange={(event) => setEmail(event.currentTarget.value)}
                ></TextInput>
            </div>
            <div className={styles['description']}>
                <span>Please enter your password</span>
            </div>
            <div className={styles['input']}>
                <TextInput
                    error={validationStatus ? '' : ' '}
                    placeholder={'password'}
                    onChange={(event) => setPassword(event.currentTarget.value)}
                ></TextInput>
            </div>
            {
                validationStatus ? '' : <text style={{color: 'red'}}>The email or password is incorrect, try again</text>
            }
            <div className={styles['button']}>
                <Button onClick={handleLoginButton}>Login</Button>
            </div>
        </div>
    );
}

export default Login;