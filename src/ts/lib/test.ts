import { Command } from "@tauri-apps/api/shell";
import { appDataDir, homeDir, join } from "@tauri-apps/api/path";
import { open } from "@tauri-apps/api/dialog";

let home = await homeDir();
let appData = await appDataDir();
let linkPath = await join(appData, "wine-link");
let winePath = await open({title: "Select Wine Path", multiple: false, defaultPath: home}); // `multiple: false` forbids multiple selections.
if (winePath != null && typeof winePath != "object") { // null when user cancels dialog, object (string array) when user makes multiple selections.
  let createLink = new Command("ln", ["-sf", winePath, linkPath]);
  let link = await createLink.execute();
  // TODO: Handle the response.
  console.log(link.code, link.signal, link.stderr, link.stdout);
  let runWine = new Command("wine", ["--version"], { cwd: "$HOME" }); // `cwd` (current working directory) can be important for some programs.
  runWine.on("close", (code, signal) => {
    console.log("Wine closed with code", code, "and signal", signal);
  })
  let wine = runWine.execute();  
  console.log("Wine PID:", wine.pid);
}