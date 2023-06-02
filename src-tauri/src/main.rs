#![cfg_attr(all(not(debug_assertions), target_os = "windows"),windows_subsystem = "windows")]






use tauri::{
    Manager,
    State,
};

use declarative_discord_rich_presence::{
    DeclarativeDiscordIpcClient,
    activity::Activity,
    activity::Assets as ActivityAssets,
    // activity::Button as Button,
    activity::Timestamps as ActivityTimestamps,
};

#[tauri::command]
fn set_activity_generic(discord_ipc_client: State<'_, DeclarativeDiscordIpcClient>, state : &str, details: &str) {
  if let Err(why) = discord_ipc_client.set_activity(
    Activity::new()
    .state(state)
        .details(details)
        .assets(ActivityAssets::new()
            .large_image("icon")
        )
    ) {
      println!("Failed to set presence: {}", why);
  }
}

#[tauri::command]
fn set_activity_game(discord_ipc_client: State<'_, DeclarativeDiscordIpcClient>, state: &str, details: &str) {
    if let Err(why) = discord_ipc_client.set_activity(
        Activity::new()
        .state(state)
            .details(details)
            .assets(ActivityAssets::new()
                .large_image("icon")
            )
            .timestamps(ActivityTimestamps::new()
                .start(chrono::Utc::now().timestamp())
            )
        ) {
          println!("Failed to set presence: {}", why);
      }
}

fn main() {
    tauri::Builder::default()
        .setup(|app| {

            let discord_ipc_client = DeclarativeDiscordIpcClient::new("1113926701735493664");

            discord_ipc_client.enable();
        
            if let Err(why) = discord_ipc_client.set_activity(
                Activity::new()
                  .state("Something you don't want to know")
                ) {
                  println!("Failed to set presence: {}", why);
              }
              app.manage(discord_ipc_client);
              Ok(())
        })
        .plugin(tauri_plugin_upload::init())
        .invoke_handler(tauri::generate_handler![set_activity_generic, set_activity_game])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}