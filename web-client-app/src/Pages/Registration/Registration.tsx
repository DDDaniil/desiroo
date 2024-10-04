import styles from './Registration.module.scss';
import { Button, TextInput } from '@mantine/core';
import useRegistration from './useRegistration.ts';

function Registration() {
    const {
        setEmail,
        setPassword,
        validationStatus,
        handleRegisterButton
    } = useRegistration();

    return (
        <div className={styles['registration-container']}>
            <div className={styles['title']}>
                <span>Registration</span>
            </div>
            <div className={styles['description']}>
                <span>Please enter your email</span>
            </div>
            <div className={styles['input']}>
                <TextInput
                    error={validationStatus ? "" : " "}
                    placeholder={'email'}
                    onChange={(event) => setEmail(event.currentTarget.value)}
                ></TextInput>
            </div>
            <div className={styles['description']}>
                <span>Please enter your password</span>
            </div>
            <div className={styles['input']}>
                <TextInput
                    error={validationStatus ? "" : " "}
                    placeholder={'password'}
                    onChange={(event) => setPassword(event.currentTarget.value)}
                ></TextInput>
            </div>
            <div className={styles['button']}>
                <Button onClick={handleRegisterButton}>Register</Button>
            </div>
        </div>
    );
}

export default Registration;