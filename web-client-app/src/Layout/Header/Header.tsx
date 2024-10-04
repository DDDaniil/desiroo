import cx from 'clsx';
import { useState } from 'react';
import {
    Container,
    UnstyledButton,
    Group,
    Text,
    Button,
    Menu,
    Tabs,
    rem,
    Image, Burger, AppShellNavbar,
} from '@mantine/core';
import {
    IconLogout,
    IconSettings,
    IconChevronDown,
} from '@tabler/icons-react';
import classes from './Header.module.scss';
import { useNavigate } from "react-router-dom";
import { Links } from "../../Consts/Links.ts";
import { persistanceStorage } from "../../Root/persistanceStorage.ts";

const tabs = [
    {name: 'Home', url: Links.Home},
    {name: 'Wishlists', url: Links.WishlistsShelf},
    {name: 'Presents', url: Links.Home}
];

interface IProps {
    isNavOpen: boolean;
    toggleNavBar: () => void;
}

export function Header({ isNavOpen, toggleNavBar }: IProps) {
    const [userMenuOpened, setUserMenuOpened] = useState(false);
    const navigate = useNavigate();

    const tabsItems = tabs.map((tab) => (
        <Tabs.Tab value={tab.name} key={tab.name} onClick={() => navigate(tab.url)}>
            {tab.name}
        </Tabs.Tab>
    ));

    const navsItems = tabs.map((tab) => (
        <UnstyledButton value={tab.name} key={tab.name} onClick={() => navigate(tab.url)}
                        className={classes.control}>
            {tab.name}
        </UnstyledButton>
    ));

    return (
        <div className={classes.header}>
            <Container className={classes.mainSection} size="md">
                <Group justify="space-between">
                    <Burger opened={isNavOpen} onClick={toggleNavBar} hiddenFrom="sm" size="sm" />
                    <Image h={40} src={'/logo.png'} />
                    <Tabs
                        defaultValue="Home"
                        variant="pills"
                        visibleFrom="sm"
                    >
                        <Tabs.List>{tabsItems}</Tabs.List>
                    </Tabs>
                    {!persistanceStorage.exist('token') && (
                        <>
                            <Button onClick={() => navigate(Links.Registration)}>
                                Registration
                            </Button>
                            <Button onClick={() => navigate(Links.Login)}>
                                Login
                            </Button>
                        </>
                    )}
                    <Menu
                        width={260}
                        position="bottom-end"
                        transitionProps={{ transition: 'pop-top-right' }}
                        onClose={() => setUserMenuOpened(false)}
                        onOpen={() => setUserMenuOpened(true)}
                        withinPortal
                    >
                        {persistanceStorage.exist('token') && (
                            <>
                                <Menu.Target>
                                    <UnstyledButton
                                        className={cx(classes.user, { [classes.userActive]: userMenuOpened })}
                                    >
                                        <Group gap={7}>
                                            <Text fw={500} size="sm" lh={1} mr={3}>
                                                {persistanceStorage.get('email')}
                                            </Text>
                                            <IconChevronDown style={{ width: rem(12), height: rem(12) }} stroke={1.5} />
                                        </Group>
                                    </UnstyledButton>
                                </Menu.Target>
                                <Menu.Dropdown>
                                    <Menu.Item
                                        leftSection={
                                            <IconSettings style={{ width: rem(16), height: rem(16) }} stroke={1.5} />
                                        }
                                    >
                                        Account settings
                                    </Menu.Item>
                                    <Menu.Item
                                        leftSection={
                                            <IconLogout style={{ width: rem(16), height: rem(16) }} stroke={1.5} />
                                        }
                                        onClick={() => {
                                            persistanceStorage.delete('token');
                                            persistanceStorage.delete('email');
                                            navigate(Links.Home);
                                        }}
                                    >
                                        Logout
                                    </Menu.Item>
                                </Menu.Dropdown>
                            </>

                        )}
                    </Menu>
                </Group>
            </Container>

            <AppShellNavbar py="md" px={4}>
                {navsItems}
            </AppShellNavbar>
        </div>

    );
}