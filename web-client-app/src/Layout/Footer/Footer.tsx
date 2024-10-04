import { Text, Container } from '@mantine/core';
import classes from './Footer.module.scss';

export function Footer() {

    return (
        <footer className={classes.footer}>
            <Container className={classes.afterFooter}>
                <Text c="dimmed" size="sm">
                    © Desiroo
                </Text>
            </Container>
        </footer>
    );
}