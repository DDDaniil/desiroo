import ProductModal from "./components/ProductModal.tsx";
import {Button, Card, Center, Container, Loader, SimpleGrid, Space, Image, AppShell, TextInput} from "@mantine/core";
import { useState } from "react";
import { useWishlist } from "./useWishlist.ts";
import { IProductRequest } from "../../Api/Products.ts";
import {Select} from "@mantine/core";
import {wishlistConsts} from "./components/WishlistConsts.tsx";



function Wishlist() {
    const [isOpenModal, setIsOpenModal] = useState(false);
    const [isEdit, setIsEdit] = useState(false);
    const [productInfo, setProductInfo] = useState<IProductRequest>();
    const { handleAddEditButton, handleDeleteButton, handleSearchButton, listProducts, isLoading } = useWishlist();
    const [searchName, setSearchName] = useState('');
    const [filterPrice, setFilterPrice] = useState<string | null>('');
    const [filterImportance, setFilterImportance] = useState<string | null>('');

    return (
        <>
            <AppShell.Navbar h={'auto'} left={300} p="sm">
                <TextInput
                    label={'Name of product'}
                    placeholder={'Enter the name'}
                    value={searchName}
                    onChange={(event) => setSearchName(event.currentTarget.value)}
                />
                <Space h={'md'}/>
                <Select
                    label="Price Category"
                    data={wishlistConsts}
                    value={filterPrice}
                    clearable
                    onChange={(event) => setFilterPrice(event)}
                />
                <Space h={'md'}/>
                <Select
                    label="Gift importance"
                    data={wishlistConsts}
                    value={filterImportance}
                    clearable
                    onChange={(event) => setFilterImportance(event)}
                />
                <Space h={'md'}/>
                <Button onClick={() => handleSearchButton(searchName ?? undefined, filterPrice ?? undefined, filterImportance ?? undefined)}>
                    Search product
                </Button>
            </AppShell.Navbar>
            <Center>
                <Container display={'grid'}>
                    <SimpleGrid cols={1}>
                        {
                            isLoading
                                ? <Center><Loader type={'dots'} /></Center>
                                : listProducts?.map((item, index) => {
                                    return (
                                        <Card
                                            shadow={'xs'}
                                            radius={'lg'}
                                            style={{cursor: 'pointer'}}
                                            key={index + item.name}
                                            onClick={() => {
                                                setIsEdit(true);
                                                setIsOpenModal(true);
                                                setProductInfo({
                                                    productId: item.productId,
                                                    name: item.name,
                                                    link: item.link,
                                                    wishlistId: item.wishlistId,
                                                    priceCategory: item.priceCategory,
                                                    giftImportance: item.giftImportance,
                                                    photo: null
                                                })
                                            }}
                                        >
                                            <Image src={item.photoUrl} w={200}/>
                                            {item.name}
                                        </Card>
                                    )
                                })
                        }
                    </SimpleGrid>
                    <Space h="md"/>
                    <Button
                        onClick={() => setIsOpenModal(!isOpenModal)}
                        justify={'center'}
                    >
                        Add a new product
                    </Button>
                    <ProductModal
                        open={isOpenModal}
                        onClose={() => {
                            setIsOpenModal(!isOpenModal);
                            setIsEdit(false);
                        }}
                        onSubmit={(values, isEdit) => handleAddEditButton(values, isEdit)}
                        isEdit={isEdit}
                        handleDeleteProduct={handleDeleteButton}
                        productInfo={productInfo}
                    />
                </Container>
            </Center>
        </>
    );
}

export default Wishlist;