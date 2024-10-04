import { ApiPaths } from '../Consts/ApiPaths.ts';
import { persistanceStorage } from '../Root/persistanceStorage.ts';
import { IResponseWith } from './Base/Response.ts';
import { axiosInstance } from '../Root/AxiosConfig.ts';

export interface WishlistsShelf {
    id: string,
    name: string
}

export const getSubscribedWishlists = async () => {
    const response = await axiosInstance.get<IResponseWith<WishlistsShelf[]>>(
        ApiPaths.GetSubscribedWishlists, {
        headers: {
            Authorization: 'bearer ' + persistanceStorage.get('token')
        }
    });
    return response?.data;
}

export const getMyWishlists = async () => {
    const response = await axiosInstance.get<IResponseWith<WishlistsShelf[]>>(
        ApiPaths.GetMyWishlists, {
            headers: {
                Authorization: 'bearer ' + persistanceStorage.get('token')
            }
        });
    return response?.data;
}