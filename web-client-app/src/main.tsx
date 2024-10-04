import React from 'react'
import { MantineProvider } from "@mantine/core";
import { colorSchemeManager, theme } from "./theme.ts";
import ReactDOM from 'react-dom/client'
import '@mantine/core/styles.css';
import App from './App.tsx';
import { ErrorBoundary } from 'react-error-boundary';
import { Notifications } from '@mantine/notifications';
import '@mantine/notifications/styles.css';


ReactDOM.createRoot(document.getElementById('root')!).render(
    <React.StrictMode>
        <ErrorBoundary fallback={<text>error</text>} onError={() => console.log('error')}>
            <MantineProvider colorSchemeManager={colorSchemeManager} theme={theme}>
                <Notifications position="top-right"/>
                <App />
            </MantineProvider>
        </ErrorBoundary>
    </React.StrictMode>,
)
