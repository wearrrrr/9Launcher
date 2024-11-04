import * as fs from "@tauri-apps/plugin-fs";
import infoManager from "./infoManager";
import { Storage } from "../utils/storage";

const info = await infoManager.gatherInformation();

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
    public static async info(message: string, sendToConsole: boolean = true, fileLog: boolean = true) {
        console.info("%c[9L] " + message, "color: #63d3ff; font-weight: bold");
        if (fileLog) await this.sendToLogs(message, "info");
        if (sendToConsole) this.sendToConsole(message, "info");
    }
    public static async debug(message: string, sendToConsole: boolean = true, fileLog: boolean = true) {
        console.debug("[9L] " + message);
        if (fileLog) await this.sendToLogs(message, "debug");
        if (sendToConsole) this.sendToConsole(message, "debug");
    }
    public static async success(message: string, sendToConsole: boolean = true, fileLog: boolean = true) {
        console.log("%c[9L] " + message, "color: #00ff00; font-weight: bold");
        if (fileLog) await this.sendToLogs(message, "success");
        if (sendToConsole) this.sendToConsole(message, "success");
    }
    public static async fatal(message: string, fileLog: boolean = true, sendToConsole: boolean = true) {
        if (fileLog) await this.sendToLogs(message, "fatal");
        if (sendToConsole) this.sendToConsole(message, "fatal");
        throw new Error("[9L] " + message);
    }
    private static async sendToConsole(message: string, type: string) {
        let console = document.getElementById("console-output");
        if (console) {
            let log = document.createElement("span");
            log.classList.add(`log-${type}`);
            log.innerText = `[9L] ${message}\n`;
            console.appendChild(log);
        }
    }

    public static async clearConsole() {
        let internalConsole = document.getElementById("console-output");
        if (internalConsole) {
            Array.from(internalConsole.getElementsByTagName("span")).forEach((element: HTMLSpanElement) => {
                element.remove();
            });
        } else {
            console.error("Internal Console not found!");
        }
    }

    private static async sendToLogs(message: string, type: string) {
        if (Storage.get("file-logging") != "enabled") return;

        if (!(await fs.exists("9Launcher.log", { baseDir: fs.BaseDirectory.AppData }))) {
            await this.initLogFile();
        }
        let currentContents = await fs.readTextFile("9Launcher.log", { baseDir: fs.BaseDirectory.AppData });
        await fs.writeTextFile("9Launcher.log", currentContents + `${Date.now()} -> [9L] ${type}: ${message} \n`, {
            baseDir: fs.BaseDirectory.AppData,
        });
    }

    public static async initLogFile() {
        await fs.writeTextFile("9Launcher.log", "!! 9Launcher Log File !!\n", {
            baseDir: fs.BaseDirectory.AppData,
        });
        await logger.info("9Launcher started!", true);
        await logger.info("9Launcher version: " + info.version, true);
        await logger.info("9Launcher OS: " + info.OS, true);
        await logger.info("9Launcher Kernel Version: " + info.kernelVersion, true);
        await logger.info("9Launcher Architecture: " + info.architecture, true);
    }
}

logger.initLogFile();

export async function attachOnError() {
    window.onerror = function (message, source, lineno, colno, error) {
        logger.fatal(`Error: ${message} \n Source: ${source} \n Line: ${lineno} \n Col: ${colno} \n Error: ${error}`);
        // Return true to prevent the default browser error handling
        return true;
    };
}
