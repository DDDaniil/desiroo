import { createTheme, localStorageColorSchemeManager } from "@mantine/core";

export const theme = createTheme({
    primaryColor: "red",
    primaryShade: 4
});

export const colorSchemeManager = localStorageColorSchemeManager({
    key: 'color-scheme',
});