export class Storage {
    static set(key: string, value: string) {
        localStorage.setItem(key, value);
    }
    static checkByValue(value: string | null): boolean {
        if (value === null) return false;
        return Object.values(localStorage).includes(value);
    }
    static get(key: string) {
        return localStorage.getItem(key);
    }
    static remove(key: string) {
        localStorage.removeItem(key);
    }
    static clear() {
        localStorage.clear();
    }
}
