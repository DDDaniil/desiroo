interface IPersistanceStorage {
    get: (name: string) => string | null;
    set: (name: string, value: string) => void;
    delete: (name: string) => void;
    exist: (name: string) => boolean
}

export const persistanceStorage: IPersistanceStorage = {
    get(name) {
        return localStorage.getItem(name);
    },

    set(name, value) {
        localStorage.setItem(name, value);
    },

    delete(name) {
        localStorage.removeItem(name)
    },

    exist(name) {
        return !!localStorage.getItem(name);
    }
};