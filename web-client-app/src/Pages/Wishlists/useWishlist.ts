import {
    createProduct,
    deleteProduct,
    editProduct,
    getWishlistItems,
    IProductRequest,
    IProductResponse
} from "../../Api/Products.ts";
import {useCallback, useEffect, useState} from "react";
import {useParams} from "react-router-dom";

export const useWishlist = () => {
    const [listProducts, setListProducts] = useState<IProductResponse[]>();
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const { id } = useParams();

    const loadListProducts = useCallback(async () => {
        setIsLoading(true);

        const response = await getWishlistItems(id ?? '');
        const data = response?.data;
        if (response.succeeded && data) {
            setListProducts(data);
            setIsLoading(false);
        }
    }, [id]);

    const handleAddEditButton = async (params: IProductRequest, isEdit: boolean) => {
        isEdit ?
            await editProduct(params).then(() => void loadListProducts()) :
            await createProduct(params).then(() => void loadListProducts());
    }

    const handleDeleteButton = async (productId?: string) => {
        if (productId) {
            await deleteProduct(productId).then(() => void loadListProducts());
        }
    }

    const handleSearchButton = async (searchName?: string, filterPrice?: string, filterCategory?: string) => {
        setIsLoading(true);

        const response = await getWishlistItems(id ?? '', searchName, filterPrice, filterCategory);
        const data = response?.data;
        if (response.succeeded && data) {
            setListProducts(data);
            setIsLoading(false);
        }
    }

    useEffect(() => {
        void loadListProducts();
    }, [loadListProducts])

    return {
        listProducts,
        isLoading,
        handleAddEditButton,
        handleDeleteButton,
        handleSearchButton,
        loadListProducts,
    }
}