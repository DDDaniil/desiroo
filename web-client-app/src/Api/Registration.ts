import { ApiPaths } from '../Consts/ApiPaths.ts';
import { axiosInstance } from '../Root/AxiosConfig.ts';
import { IResponse } from './Base/Response.ts';

interface registrationRequestParams {
    email: string;
    password: string;
}

export const registerUser = async (params: registrationRequestParams) => {
    const response = await axiosInstance.post<IResponse>(ApiPaths.Register, params);
    return response?.data;
}