import { WebviewWindow } from "@tauri-apps/api/window";
import type { WindowOptions } from "@tauri-apps/api/window";

export async function spawnWebview(id: string, opts: WindowOptions) {
    return new WebviewWindow(id, opts);
}