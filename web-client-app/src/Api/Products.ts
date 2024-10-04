import { ApiPaths } from '../Consts/ApiPaths.ts';
import {IResponse, IResponseWith} from './Base/Response.ts';
import { axiosInstance } from '../Root/AxiosConfig.ts';
import { persistanceStorage } from "../Root/persistanceStorage.ts";

export interface IProductRequest {
    productId: string,
    name: string,
    link: string,
    wishlistId: string,
    priceCategory: string,
    giftImportance: string,
    photo: File | null
}

export interface IProductResponse {
    productId: string,
    name: string,
    link: string,
    wishlistId: string,
    priceCategory: string,
    giftImportance: string,
    photoUrl: string,
}

export const createProduct = async (params: IProductRequest) => {
    const bodyFormData = new FormData();
    bodyFormData.append('productId', params.productId);
    bodyFormData.append('name', params.name);
    bodyFormData.append('link', params.link);
    bodyFormData.append('wishlistId', params.wishlistId);
    bodyFormData.append('priceCategory', params.priceCategory);
    bodyFormData.append('giftImportance', params.giftImportance);
    bodyFormData.append('photo', params.photo!);
    const response = await axiosInstance.post<IResponse>(ApiPaths.CreateProduct, bodyFormData,
        {
            headers: {
                Authorization: 'bearer ' + persistanceStorage.get('token'),
                'Content-Type': 'multipart/form-data'
            }
        });

    return response?.data;
}

export const editProduct = async (params: IProductRequest) => {
    const bodyFormData = new FormData();
    bodyFormData.append('productId', params.productId);
    bodyFormData.append('name', params.name);
    bodyFormData.append('link', params.link);
    bodyFormData.append('wishlistId', params.wishlistId);
    bodyFormData.append('priceCategory', params.priceCategory);
    bodyFormData.append('giftImportance', params.giftImportance);
    bodyFormData.append('photo', params.photo!);

    const response = await axiosInstance.put<IResponse>(ApiPaths.EditProduct, bodyFormData,
        {
            headers: {
                Authorization: 'bearer ' + persistanceStorage.get('token'),
                'Content-Type': 'multipart/form-data'
            }
        });

    return response?.data;
}

export const deleteProduct = async (productId: string) => {
    const params = {
        productId: productId,
    }

    const response = await axiosInstance.post<IResponse>(ApiPaths.DeleteProduct, params,
        {
            headers: {
                Authorization: 'bearer ' + persistanceStorage.get('token')
            }
        });

    return response?.data;
}

export const getWishlistItems = async (wishlistId: string, searchName?: string, filterPrice?: string, filterImportance?: string) => {
    const response = await axiosInstance.get<IResponseWith<IProductResponse[]>>(ApiPaths.GetWishlistItems,
        {
            headers: {
                Authorization: 'bearer ' + persistanceStorage.get('token')
            },
            params: {
                wishlistId: wishlistId,
                searchName: searchName,
                filterPrice: filterPrice,
                filterImportance: filterImportance,
            }
        });

    return response?.data;
}