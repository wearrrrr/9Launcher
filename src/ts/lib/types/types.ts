export type payloadJSON = {
    payload: {
        gameID: string,
        updatedData: string,
    }
}

export enum returnCode {
    SUCCESS = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3,
    DEBUG = 4,
    FATAL = 5,
}

