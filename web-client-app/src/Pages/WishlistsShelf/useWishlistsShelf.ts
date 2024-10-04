import { useCallback, useEffect, useState } from 'react';
import { WishlistsShelf, getSubscribedWishlists, getMyWishlists } from '../../Api/WishlistsShelf.ts';
import { ShelfTabs } from './types.ts';

export const useWishlistsShelf = () => {
    const [list, setList] = useState<WishlistsShelf[]>();
    const [page, setPage] = useState<number>(0);
    const [activeTab, setActiveTab] = useState<string | null>(ShelfTabs.MyWishlists);
    const [isLoading, setIsLoading] = useState<boolean>(true);

    const loadList = useCallback(async () => {
        setIsLoading(true);

        const response = activeTab == ShelfTabs.MyWishlists
            ? await getMyWishlists()
            : await getSubscribedWishlists();
        const data = response?.data;
        if (response.succeeded && data) {
            setList(data);
            setIsLoading(false);
        }
    }, [activeTab]);

    useEffect(() => {
        void loadList();
    }, [loadList, page])

    return {
        list,
        setPage,
        activeTab,
        setActiveTab,
        loadList,
        isLoading
    }
};