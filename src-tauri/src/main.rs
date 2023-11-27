#![cfg_attr(all(not(debug_assertions), target_os = "windows"),windows_subsystem = "windows")]

use chrono::Utc;
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
        .timestamps(ActivityTimestamps::new()
            .start(chrono::Utc::now().timestamp())
        )
    ) {
      println!("Failed to set presence: {}", why);
  }
}

static mut INITIAL_TIMESTAMP: i64 = 0;

#[tauri::command]
fn update_advanced_game_activity(discord_ipc_client: State<'_, DeclarativeDiscordIpcClient>, state: &str, details: &str) {
    unsafe {
        // Get the current timestamp
        let current_timestamp = Utc::now().timestamp();

        // Set the initial timestamp if it's the first time
        if INITIAL_TIMESTAMP == 0 {
            INITIAL_TIMESTAMP = current_timestamp;
        }

        // Update the Discord Rich Presence
        if let Err(why) = discord_ipc_client.set_activity(
            Activity::new()
                .state(state)
                .details(details)
                .assets(ActivityAssets::new().large_image("icon"))
                .timestamps(ActivityTimestamps::new().start(INITIAL_TIMESTAMP)),
        ) {
            println!("Failed to set presence: {}", why);
        }
    }
}

#[tauri::command]
fn reset_initial_timestamp() {
    unsafe {
        INITIAL_TIMESTAMP = 0;
    }
}

#[tauri::command]
fn set_activity_game(discord_ipc_client: State<'_, DeclarativeDiscordIpcClient>, state: &str, details: &str) -> i64 {
    // declare a variable for the timestamp
    let return_time = chrono::Utc::now().timestamp();

    if let Err(why) = discord_ipc_client.set_activity(
        Activity::new()
        .state(state)
            .details(details)
            .assets(ActivityAssets::new()
                .large_image("icon")
            )
            .timestamps(ActivityTimestamps::new()
                .start(return_time)
            )
        ) {
          println!("Failed to set presence: {}", why);
      }

      return return_time;
}

#[tauri::command]
fn clear_activity(discord_ipc_client: State<'_, DeclarativeDiscordIpcClient>) {
    if let Err(why) = discord_ipc_client.clear_activity() {
        println!("Failed to clear presence: {}", why);
    }
}



fn main() {
    tauri::Builder::default()
        .setup(|app| {

            let discord_ipc_client = DeclarativeDiscordIpcClient::new("1113926701735493664");
            discord_ipc_client.enable();
        
            if let Err(why) = discord_ipc_client.set_activity(
                Activity::new()
                  .state("")
                ) {
                  println!("Failed to set presence: {}", why);
              }
              app.manage(discord_ipc_client);
              Ok(())
        })
        .plugin(tauri_plugin_upload::init())
        .invoke_handler(tauri::generate_handler![set_activity_generic, set_activity_game, clear_activity, update_advanced_game_activity, reset_initial_timestamp])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}