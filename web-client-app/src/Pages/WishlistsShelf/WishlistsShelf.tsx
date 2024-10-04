import { Card, Center, Container, Loader, SimpleGrid, Space, Tabs } from '@mantine/core';
import { useWishlistsShelf } from './useWishlistsShelf.ts';
import { useNavigate } from 'react-router-dom';
import { Links } from '../../Consts/Links.ts';
import { ShelfTabs } from './types.ts';

export const WishlistsShelf = () => {
    const navigate = useNavigate();
    const {
        list,
        isLoading,
        activeTab,
        setActiveTab
    } = useWishlistsShelf();

    const navigateToWishlist = (id: string) => {
        navigate(`${Links.Wishlists}/${id}`);
    }

    return (
        <Center>
            <Container>
                <Tabs value={activeTab} onChange={setActiveTab}
                      variant={'outline'} radius={'lg'}>
                    <Tabs.List grow>
                        <Tabs.Tab value={ShelfTabs.MyWishlists}>
                            My Wishlists
                        </Tabs.Tab>
                        <Tabs.Tab value={ShelfTabs.Subscribed}>
                            Subscribed
                        </Tabs.Tab>
                    </Tabs.List>
                </Tabs>
                <Space h="md"/>
                <SimpleGrid cols={1}>
                    {
                        isLoading
                            ? <Center><Loader type={'dots'} /></Center>
                            : list?.map((item, index) => {
                                return (
                                    <Card onClick={() => navigateToWishlist(item.id)}
                                          shadow={'xs'}
                                          radius={'lg'}
                                          style={{cursor: 'pointer'}}
                                          key={index + item.name}>
                                        {item.name}
                                    </Card>
                                )
                            })
                    }

                </SimpleGrid>
            </Container>
        </Center>
    );
};