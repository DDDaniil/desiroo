import {Button, FileInput, Modal, Select, Space, TextInput} from '@mantine/core';
import {useForm} from '@mantine/form';
import {IProductRequest} from "../../../Api/Products.ts";
import {useParams} from "react-router-dom";
import {useEffect, useState} from "react";
import {wishlistConsts} from "./WishlistConsts.tsx";

interface ProductModalProps {
    open: boolean;
    onClose: () => void;
    onSubmit: (values: IProductRequest, isEdit: boolean) => void;
    isEdit: boolean;
    handleDeleteProduct: (productId?: string) => void;
    productInfo?: IProductRequest;
}

const ProductModal: React.FC<ProductModalProps> = ({ open, onClose, onSubmit, isEdit, handleDeleteProduct, productInfo }) => {
    const { id } = useParams();
    const [showDelete, setShowDelete] = useState(false)
    const form = useForm({
        initialValues: {
            name: '',
            link: '',
            priceCategory: 'low',
            giftImportance: 'low',
            wishlistId: id,
            productId: '',
            photo: null,
        } as IProductRequest,
        validate: {
            name: (value) => (value.length < 3 ? 'Name must have at least 3 letters' : null),
            link: (value) => (/(http[s]?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&/=]*)/gi.test(value) ?
                null : 'Invalid link'),
            photo: (value) => !value ? 'Photo is required' : null
        },
    });

    useEffect(() => {
        if (productInfo) {
            form.setValues({
                name: productInfo.name,
                link: productInfo.link,
                priceCategory: productInfo.priceCategory,
                giftImportance: productInfo.giftImportance,
                wishlistId: id,
                productId: productInfo.productId,
                photo: productInfo.photo,
            })
        }
    }, [productInfo]);

    useEffect(() => {
        setShowDelete(isEdit);
    }, [isEdit]);

    return (
        <Modal opened={open} onClose={onClose} title="Product Details">
            <form onSubmit={form.onSubmit((values) => {
                onSubmit(values, isEdit);
                onClose();
            })}>
                <FileInput
                    withAsterisk
                    label='Select a photo'
                    {...form.getInputProps('photo')}
                />
                <TextInput
                    label="Product Name"
                    withAsterisk
                    placeholder="A name length of more than 3 is required"
                    {...form.getInputProps('name')}
                />
                <TextInput
                    label="Product Link"
                    withAsterisk
                    placeholder="The link must be working"
                    {...form.getInputProps('link')}
                />
                <Select
                    label="Price Category"
                    data={wishlistConsts}
                    withAsterisk
                    {...form.getInputProps('priceCategory')}
                />
                <Select
                    label="Gift importance"
                    data={wishlistConsts}
                    withAsterisk
                    {...form.getInputProps('giftImportance')}
                />
                <Space h='md'/>
                {isEdit ? <Button type='submit'>Update</Button> : <Button type='submit'>Add</Button>}
                <Space h="md"/>
                {showDelete && <Button onClick={() => {
                    handleDeleteProduct(productInfo?.productId);
                    onClose();
                }}>
                    Delete
                </Button>}
            </form>
        </Modal>

    );
};

export default ProductModal;