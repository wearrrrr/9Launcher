type gameObject = {
    long_title: string;
    en_title: string;
    jp_title: string;
    img: string;
    img_unset: string;
    release_year: number;
    game_id: string;
};

interface ConfigPatch {
    archive: string;
}

interface thcrapConfigFile {
    console: boolean;
    dat_dump: boolean;
    patched_files_dump: boolean;
    patches: ConfigPatch[];
}

interface thcrapRepo {
    contact: string;
    id: string;
    neighbors: string[];
    patches: string[];
    servers: string[];
}

interface thcrapRepoPatch {
    id: string;
    patches: Record<string, string>;
    server: string;
}