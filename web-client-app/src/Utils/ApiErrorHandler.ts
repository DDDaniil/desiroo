import { AxiosError } from 'axios';
import { notifications } from '@mantine/notifications';

export const apiErrorHandler = (error: Error) => {
    if (error === null || error === undefined)
        throw new Error("Undefined error");
    if (error instanceof AxiosError) {
        const response = error?.response;
        const request = error?.request;



        if (response) {
            const statusCode = response?.status;
            const errorMessage = response.data.errors[0];
            let errorTitle = 'Unknown error';

            if (statusCode === 400) {
                errorTitle = 'Request failed';
            }
            if (statusCode === 401) {
                errorTitle = 'Unauthorized';
            }
            if (statusCode === 404) {
                errorTitle = 'Not found error';
            }
            if (statusCode === 500) {
                errorTitle = 'Server error =(';
            }

            notifications.show({
                color: 'red',
                title: errorTitle,
                message: errorMessage,
            });

            return response.data;
        } else {
            if (request) {
                notifications.show({
                    color: 'red',
                    title: "Service unavailable",
                    message: '',
                })
            }
        }
    }
}