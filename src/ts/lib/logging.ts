import { path } from "@tauri-apps/api";
import * as fs from "@tauri-apps/api/fs";

export class logger {
    public static async error(message: string, fileLog: boolean = true) {
        console.error("[9L] " + message);
        if (fileLog) await this.sendToLogs(message, "error");
        this.sendToConsole(message, "error");
    }
    public static async warn(message: string, fileLog: boolean = true) {
        console.warn("[9L] " + message);
        if (fileLog) await this.sendToLogs(message, "warn");
        this.sendToConsole(message, "warn");
    }
    public static async info(message: string, fileLog: boolean = true) {
        console.info("%c[9L] " + message, "color: #63d3ff; font-weight: bold");
        if (fileLog) await this.sendToLogs(message, "info");
        this.sendToConsole(message, "info");
    }
    public static async debug(message: string, fileLog: boolean = true) {
        console.debug("[9L] " + message);
        if (fileLog) await this.sendToLogs(message, "debug");
        this.sendToConsole(message, "debug");
    }
    public static async success(message: string, fileLog: boolean = true) {
        console.log("%c[9L] " + message, "color: #00ff00; font-weight: bold");
        if (fileLog) await this.sendToLogs(message, "success");
        this.sendToConsole(message, "success");
    }
    public static async fatal(message: string, fileLog: boolean = true) {
        console.error("%c[9L] Critical Error: " + message, "font-weight: bold; font-size: 150%");
        if (fileLog) await this.sendToLogs(message, "fatal-error");
        this.sendToConsole(message, "fatal-error");
    }
    private static async sendToConsole(message: string, type: string) {
        let console = document.getElementById("console-output");
        if (console) {
            let log = document.createElement('span');
            log.classList.add(`log-${type}`);
            log.innerText = `[9L] ${message}\n`;
            console.appendChild(log);
        }
    }

    private static async sendToLogs(message: string, type: string) {
        if (localStorage.getItem("file-logging") != "enabled") return
        let log = {
            "message": message,
            "type": type
        }
        if (!await fs.exists(await path.appDataDir() + "9Launcher.log")) {
            await fs.writeTextFile("9Launcher.log", "!! 9Launcher Log File !!\n", { dir: fs.BaseDirectory.AppData })
            let currentContents = await fs.readTextFile(await path.appDataDir() + "9Launcher.log")
            await fs.writeTextFile("9Launcher.log", currentContents + `${log.type}: ${log.message} \n`, { dir: fs.BaseDirectory.AppData })
        } else {
            let currentContents = await fs.readTextFile(await path.appDataDir() + "9Launcher.log")
            await fs.writeTextFile("9Launcher.log", currentContents + `${log.type}: ${log.message} \n`, { dir: fs.BaseDirectory.AppData })
        }
    }
}