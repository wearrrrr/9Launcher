import { path } from "@tauri-apps/api";
import * as fs from "@tauri-apps/api/fs";

export class logger {
    constructor() {}
    public static async error(message: string) {
        console.error("[9L] " + message);
        await this.sendToLogs(message, "error");
    }
    public static async warn(message: string) {
        console.warn("[9L] " + message);
        await this.sendToLogs(message, "warn");
    }
    public static async info(message: string) {
        console.info("%c[9L] " + message, "color: #63d3ff; font-weight: bold");
        await this.sendToLogs(message, "info");
    }
    public static async debug(message: string) {
        console.debug("[9L] " + message);
        await this.sendToLogs(message, "debug");
    }
    public static async success(message: string) {
        console.log("%c[9L] " + message, "color: limegreen; font-weight: bold");
        await this.sendToLogs(message, "success");
    }
    public static async fatal(message: string) {
        console.error("%c[9L] Critical Error: " + message, "font-weight: bold; font-size: 150%");
        await this.sendToLogs(message, "fatal-error");
    }
    private static async sendToLogs(message: string, type: string) {
        if (localStorage.getItem("file-logging") != "enabled") return
        let log = {
            "message": message,
            "type": type
        }
        if (!await fs.exists(await path.appDataDir() + "9Launcher.log")) {
            await fs.writeTextFile("9Launcher.log", "!! 9Launcher Log File !!\n", { dir: fs.BaseDirectory.AppLocalData })
            let currentContents = await fs.readTextFile(await path.appDataDir() + "9Launcher.log")
            await fs.writeTextFile("9Launcher.log", currentContents + `${log.type}: ${log.message} \n`, { dir: fs.BaseDirectory.AppLocalData })
        } else {
            let currentContents = await fs.readTextFile(await path.appDataDir() + "9Launcher.log")
            await fs.writeTextFile("9Launcher.log", currentContents + `${log.type}: ${log.message} \n`, { dir: fs.BaseDirectory.AppLocalData })
        }
    }
}