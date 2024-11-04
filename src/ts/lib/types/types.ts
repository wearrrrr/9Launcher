export type payloadJSON = {
    payload: {
        gameID: string;
        updatedData: string;
    };
};

export type gameObject = {
    long_title: string;
    en_title: string;
    jp_title: string;
    img: string;
    img_unset: string;
    release_year: number;
    game_id: string;
};

export enum returnCode {
    SUCCESS = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3,
    DEBUG = 4,
    FATAL = 5,
    TRUE = 6,
    FALSE = 7,
}
