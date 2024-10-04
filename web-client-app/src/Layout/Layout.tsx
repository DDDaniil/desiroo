import { AppShell } from '@mantine/core';
import { useDisclosure } from '@mantine/hooks';
import { ReactElement } from 'react';
import { Header } from './Header/Header.tsx';
import { Footer } from './Footer/Footer.tsx';

type IProps = {
    children: ReactElement;
};

const Layout: React.FC<IProps> = ({ children }) => {
    const [opened, { toggle }] = useDisclosure();

    return (
        <AppShell
            header={{ height: 60 }}
            navbar={{ width: 300, breakpoint: 'sm', collapsed: { desktop: true, mobile: !opened } }}
            padding="md"
        >
            <AppShell.Header>
                <Header isNavOpen={opened} toggleNavBar={toggle}/>
            </AppShell.Header>

            <AppShell.Main>
                {children}
            </AppShell.Main>

            <AppShell.Footer>
                <Footer />
            </AppShell.Footer>
        </AppShell>
    );

}

export default Layout;
