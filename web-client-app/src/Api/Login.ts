import { ApiPaths } from '../Consts/ApiPaths.ts';
import { axiosInstance } from '../Root/AxiosConfig.ts';
import { IResponseWith } from './Base/Response.ts';

interface loginRequestParams {
    email: string;
    password: string;
}

export const loginUser = async (params: loginRequestParams) : Promise<IResponseWith<string>> => {
    const response = await axiosInstance.post<IResponseWith<string>>(ApiPaths.Login, params);
    return response?.data
}