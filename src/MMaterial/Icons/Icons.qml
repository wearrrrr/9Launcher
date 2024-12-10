pragma Singleton

import QtQuick

QtObject{
    id: _root

    property QtObject heavy: QtObject {
        id: _heavyRoot

        readonly property string iconBasePath: Qt.resolvedUrl("./assets/svg/")

        readonly property IconData logo: IconData { path: _heavyRoot.iconBasePath + "logo.svg"; type: IconData.Heavy }
        readonly property IconData accountBalance: IconData { path: _heavyRoot.iconBasePath + "account_balance.svg"; type: IconData.Heavy }
        readonly property IconData accountBox: IconData { path: _heavyRoot.iconBasePath + "account_box.svg"; type: IconData.Heavy }
        readonly property IconData accountCircle: IconData { path: _heavyRoot.iconBasePath + "account_circle.svg"; type: IconData.Heavy }
        readonly property IconData adb: IconData { path: _heavyRoot.iconBasePath + "adb.svg"; type: IconData.Heavy }
        readonly property IconData add: IconData { path: _heavyRoot.iconBasePath + "add.svg"; type: IconData.Heavy }
        readonly property IconData addAPhoto: IconData { path: _heavyRoot.iconBasePath + "add_a_photo.svg"; type: IconData.Heavy }
        readonly property IconData addBox: IconData { path: _heavyRoot.iconBasePath + "add_box.svg"; type: IconData.Heavy }
        readonly property IconData addBusiness: IconData { path: _heavyRoot.iconBasePath + "add_business.svg"; type: IconData.Heavy }
        readonly property IconData addCard: IconData { path: _heavyRoot.iconBasePath + "add_card.svg"; type: IconData.Heavy }
        readonly property IconData addCircle: IconData { path: _heavyRoot.iconBasePath + "add_circle.svg"; type: IconData.Heavy }
        readonly property IconData addPhotoAlternate: IconData { path: _heavyRoot.iconBasePath + "add_photo_alternate.svg"; type: IconData.Heavy }
        readonly property IconData addShoppingCart: IconData { path: _heavyRoot.iconBasePath + "add_shopping_cart.svg"; type: IconData.Heavy }
        readonly property IconData air: IconData { path: _heavyRoot.iconBasePath + "air.svg"; type: IconData.Heavy }
        readonly property IconData alarm: IconData { path: _heavyRoot.iconBasePath + "alarm.svg"; type: IconData.Heavy }
        readonly property IconData analytics: IconData { path: _heavyRoot.iconBasePath + "analytics.svg"; type: IconData.Heavy }
        readonly property IconData android: IconData { path: _heavyRoot.iconBasePath + "android.svg"; type: IconData.Heavy }
        readonly property IconData apps: IconData { path: _heavyRoot.iconBasePath + "apps.svg"; type: IconData.Heavy }
        readonly property IconData arrowBack: IconData { path: _heavyRoot.iconBasePath + "arrow_back.svg"; type: IconData.Heavy }
        readonly property IconData arrowDownward: IconData { path: _heavyRoot.iconBasePath + "arrow_downward.svg"; type: IconData.Heavy }
        readonly property IconData arrowDropDown: IconData { path: _heavyRoot.iconBasePath + "arrow_drop_down.svg"; type: IconData.Heavy }
        readonly property IconData arrowDropUp: IconData { path: _heavyRoot.iconBasePath + "arrow_drop_up.svg"; type: IconData.Heavy }
        readonly property IconData arrowForward: IconData { path: _heavyRoot.iconBasePath + "arrow_forward.svg"; type: IconData.Heavy }
        readonly property IconData arrowRight: IconData { path: _heavyRoot.iconBasePath + "arrow_right.svg"; type: IconData.Heavy }
        readonly property IconData atr: IconData { path: _heavyRoot.iconBasePath + "atr.svg"; type: IconData.Heavy }
        readonly property IconData attachMoney: IconData { path: _heavyRoot.iconBasePath + "attach_money.svg"; type: IconData.Heavy }
        readonly property IconData autorenew: IconData { path: _heavyRoot.iconBasePath + "autorenew.svg"; type: IconData.Heavy }
        readonly property IconData backspace: IconData { path: _heavyRoot.iconBasePath + "backspace.svg"; type: IconData.Heavy }
        readonly property IconData badge: IconData { path: _heavyRoot.iconBasePath + "badge.svg"; type: IconData.Heavy }
        readonly property IconData barChart: IconData { path: _heavyRoot.iconBasePath + "bar_chart.svg"; type: IconData.Heavy }
        readonly property IconData barcodeScanner: IconData { path: _heavyRoot.iconBasePath + "barcode_scanner.svg"; type: IconData.Heavy }
        readonly property IconData batteryChargingFull: IconData { path: _heavyRoot.iconBasePath + "battery_charging_full.svg"; type: IconData.Heavy }
        readonly property IconData batteryFull: IconData { path: _heavyRoot.iconBasePath + "battery_full.svg"; type: IconData.Heavy }
        readonly property IconData batteryFullAlt: IconData { path: _heavyRoot.iconBasePath + "battery_full_alt.svg"; type: IconData.Heavy }
        readonly property IconData bluetooth: IconData { path: _heavyRoot.iconBasePath + "bluetooth.svg"; type: IconData.Heavy }
        readonly property IconData bookmark: IconData { path: _heavyRoot.iconBasePath + "bookmark.svg"; type: IconData.Heavy }
        readonly property IconData brush: IconData { path: _heavyRoot.iconBasePath + "brush.svg"; type: IconData.Heavy }
        readonly property IconData build: IconData { path: _heavyRoot.iconBasePath + "build.svg"; type: IconData.Heavy }
        readonly property IconData cable: IconData { path: _heavyRoot.iconBasePath + "cable.svg"; type: IconData.Heavy }
        readonly property IconData cake: IconData { path: _heavyRoot.iconBasePath + "cake.svg"; type: IconData.Heavy }
        readonly property IconData calculate: IconData { path: _heavyRoot.iconBasePath + "calculate.svg"; type: IconData.Heavy }
        readonly property IconData calendarMonth: IconData { path: _heavyRoot.iconBasePath + "calendar_month.svg"; type: IconData.Heavy }
        readonly property IconData calendarToday: IconData { path: _heavyRoot.iconBasePath + "calendar_today.svg"; type: IconData.Heavy }
        readonly property IconData call: IconData { path: _heavyRoot.iconBasePath + "call.svg"; type: IconData.Heavy }
        readonly property IconData camera: IconData { path: _heavyRoot.iconBasePath + "camera.svg"; type: IconData.Heavy }
        readonly property IconData campaign: IconData { path: _heavyRoot.iconBasePath + "campaign.svg"; type: IconData.Heavy }
        readonly property IconData cancel: IconData { path: _heavyRoot.iconBasePath + "cancel.svg"; type: IconData.Heavy }
        readonly property IconData cast: IconData { path: _heavyRoot.iconBasePath + "cast.svg"; type: IconData.Heavy }
        readonly property IconData category: IconData { path: _heavyRoot.iconBasePath + "category.svg"; type: IconData.Heavy }
        readonly property IconData celebration: IconData { path: _heavyRoot.iconBasePath + "celebration.svg"; type: IconData.Heavy }
        readonly property IconData chat: IconData { path: _heavyRoot.iconBasePath + "chat.svg"; type: IconData.Heavy }
        readonly property IconData chatBubble: IconData { path: _heavyRoot.iconBasePath + "chat_bubble.svg"; type: IconData.Heavy }
        readonly property IconData check: IconData { path: _heavyRoot.iconBasePath + "check.svg"; type: IconData.Heavy }
        readonly property IconData checkBox: IconData { path: _heavyRoot.iconBasePath + "check_box.svg"; type: IconData.Heavy }
        readonly property IconData checkBoxOutlineBlank: IconData { path: _heavyRoot.iconBasePath + "check_box_outline_blank.svg"; type: IconData.Heavy }
        readonly property IconData checkCircle: IconData { path: _heavyRoot.iconBasePath + "check_circle.svg"; type: IconData.Heavy }
        readonly property IconData chevronLeft: IconData { path: _heavyRoot.iconBasePath + "chevron_left.svg"; type: IconData.Heavy }
        readonly property IconData chevronRight: IconData { path: _heavyRoot.iconBasePath + "chevron_right.svg"; type: IconData.Heavy }
        readonly property IconData circle: IconData { path: _heavyRoot.iconBasePath + "circle.svg"; type: IconData.Heavy }
        readonly property IconData close: IconData { path: _heavyRoot.iconBasePath + "close.svg"; type: IconData.Heavy }
        readonly property IconData code: IconData { path: _heavyRoot.iconBasePath + "code.svg"; type: IconData.Heavy }
        readonly property IconData computer: IconData { path: _heavyRoot.iconBasePath + "computer.svg"; type: IconData.Heavy }
        readonly property IconData construction: IconData { path: _heavyRoot.iconBasePath + "construction.svg"; type: IconData.Heavy }
        readonly property IconData contactSupport: IconData { path: _heavyRoot.iconBasePath + "contact_support.svg"; type: IconData.Heavy }
        readonly property IconData contentCopy: IconData { path: _heavyRoot.iconBasePath + "content_copy.svg"; type: IconData.Heavy }
        readonly property IconData creditCard: IconData { path: _heavyRoot.iconBasePath + "credit_card.svg"; type: IconData.Heavy }
        readonly property IconData cropFree: IconData { path: _heavyRoot.iconBasePath + "crop_free.svg"; type: IconData.Heavy }
        readonly property IconData currencyBitcoin: IconData { path: _heavyRoot.iconBasePath + "currency_bitcoin.svg"; type: IconData.Heavy }
        readonly property IconData darkMode: IconData { path: _heavyRoot.iconBasePath + "dark_mode.svg"; type: IconData.Heavy }
        readonly property IconData dashboard: IconData { path: _heavyRoot.iconBasePath + "dashboard.svg"; type: IconData.Heavy }
        readonly property IconData database: IconData { path: _heavyRoot.iconBasePath + "database.svg"; type: IconData.Heavy }
        readonly property IconData deleteElement: IconData { path: _heavyRoot.iconBasePath + "delete.svg"; type: IconData.Heavy }
        readonly property IconData deleteForever: IconData { path: _heavyRoot.iconBasePath + "delete_forever.svg"; type: IconData.Heavy }
        readonly property IconData description: IconData { path: _heavyRoot.iconBasePath + "description.svg"; type: IconData.Heavy }
        readonly property IconData devices: IconData { path: _heavyRoot.iconBasePath + "devices.svg"; type: IconData.Heavy }
        readonly property IconData directionsCar: IconData { path: _heavyRoot.iconBasePath + "directions_car.svg"; type: IconData.Heavy }
        readonly property IconData domain: IconData { path: _heavyRoot.iconBasePath + "domain.svg"; type: IconData.Heavy }
        readonly property IconData doneAll: IconData { path: _heavyRoot.iconBasePath + "done_all.svg"; type: IconData.Heavy }
        readonly property IconData download: IconData { path: _heavyRoot.iconBasePath + "download.svg"; type: IconData.Heavy }
        readonly property IconData downloadForOffline: IconData { path: _heavyRoot.iconBasePath + "download_for_offline.svg"; type: IconData.Heavy }
        readonly property IconData draw: IconData { path: _heavyRoot.iconBasePath + "draw.svg"; type: IconData.Heavy }
        readonly property IconData eco: IconData { path: _heavyRoot.iconBasePath + "eco.svg"; type: IconData.Heavy }
        readonly property IconData edit: IconData { path: _heavyRoot.iconBasePath + "edit.svg"; type: IconData.Heavy }
        readonly property IconData editNote: IconData { path: _heavyRoot.iconBasePath + "edit_note.svg"; type: IconData.Heavy }
        readonly property IconData electricBolt: IconData { path: _heavyRoot.iconBasePath + "electric_bolt.svg"; type: IconData.Heavy }
        readonly property IconData emojiObjects: IconData { path: _heavyRoot.iconBasePath + "emoji_objects.svg"; type: IconData.Heavy }
        readonly property IconData engineering: IconData { path: _heavyRoot.iconBasePath + "engineering.svg"; type: IconData.Heavy }
        readonly property IconData error: IconData { path: _heavyRoot.iconBasePath + "error.svg"; type: IconData.Heavy }
        readonly property IconData euro: IconData { path: _heavyRoot.iconBasePath + "euro.svg"; type: IconData.Heavy }
        readonly property IconData event: IconData { path: _heavyRoot.iconBasePath + "event.svg"; type: IconData.Heavy }
        readonly property IconData explore: IconData { path: _heavyRoot.iconBasePath + "explore.svg"; type: IconData.Heavy }
        readonly property IconData extension: IconData { path: _heavyRoot.iconBasePath + "extension.svg"; type: IconData.Heavy }
        readonly property IconData familiarFaceAndZone: IconData { path: _heavyRoot.iconBasePath + "familiar_face_and_zone.svg"; type: IconData.Heavy }
        readonly property IconData fastForward: IconData { path: _heavyRoot.iconBasePath + "fast_forward.svg"; type: IconData.Heavy }
        readonly property IconData fastRewind: IconData { path: _heavyRoot.iconBasePath + "fast_rewind.svg"; type: IconData.Heavy }
        readonly property IconData favorite: IconData { path: _heavyRoot.iconBasePath + "favorite.svg"; type: IconData.Heavy }
        readonly property IconData fileCopy: IconData { path: _heavyRoot.iconBasePath + "file_copy.svg"; type: IconData.Heavy }
        readonly property IconData filterAlt: IconData { path: _heavyRoot.iconBasePath + "filter_alt.svg"; type: IconData.Heavy }
        readonly property IconData filterList: IconData { path: _heavyRoot.iconBasePath + "filter_list.svg"; type: IconData.Heavy }
        readonly property IconData finance: IconData { path: _heavyRoot.iconBasePath + "finance.svg"; type: IconData.Heavy }
        readonly property IconData fingerprint: IconData { path: _heavyRoot.iconBasePath + "fingerprint.svg"; type: IconData.Heavy }
        readonly property IconData flag: IconData { path: _heavyRoot.iconBasePath + "flag.svg"; type: IconData.Heavy }
        readonly property IconData flashOn: IconData { path: _heavyRoot.iconBasePath + "flash_on.svg"; type: IconData.Heavy }
        readonly property IconData flashlightOn: IconData { path: _heavyRoot.iconBasePath + "flashlight_on.svg"; type: IconData.Heavy }
        readonly property IconData flight: IconData { path: _heavyRoot.iconBasePath + "flight.svg"; type: IconData.Heavy }
        readonly property IconData folder: IconData { path: _heavyRoot.iconBasePath + "folder.svg"; type: IconData.Heavy }
        readonly property IconData folderOpen: IconData { path: _heavyRoot.iconBasePath + "folder_open.svg"; type: IconData.Heavy }
        readonly property IconData forum: IconData { path: _heavyRoot.iconBasePath + "forum.svg"; type: IconData.Heavy }
        readonly property IconData gridOn: IconData { path: _heavyRoot.iconBasePath + "grid_on.svg"; type: IconData.Heavy }
        readonly property IconData gridView: IconData { path: _heavyRoot.iconBasePath + "grid_view.svg"; type: IconData.Heavy }
        readonly property IconData group: IconData { path: _heavyRoot.iconBasePath + "group.svg"; type: IconData.Heavy }
        readonly property IconData groupAdd: IconData { path: _heavyRoot.iconBasePath + "group_add.svg"; type: IconData.Heavy }
        readonly property IconData groups: IconData { path: _heavyRoot.iconBasePath + "groups.svg"; type: IconData.Heavy }
        readonly property IconData handyman: IconData { path: _heavyRoot.iconBasePath + "handyman.svg"; type: IconData.Heavy }
        readonly property IconData headphones: IconData { path: _heavyRoot.iconBasePath + "headphones.svg"; type: IconData.Heavy }
        readonly property IconData hearing: IconData { path: _heavyRoot.iconBasePath + "hearing.svg"; type: IconData.Heavy }
        readonly property IconData help: IconData { path: _heavyRoot.iconBasePath + "help.svg"; type: IconData.Heavy }
        readonly property IconData history: IconData { path: _heavyRoot.iconBasePath + "history.svg"; type: IconData.Heavy }
        readonly property IconData home: IconData { path: _heavyRoot.iconBasePath + "home.svg"; type: IconData.Heavy }
        readonly property IconData homePin: IconData { path: _heavyRoot.iconBasePath + "home_pin.svg"; type: IconData.Heavy }
        readonly property IconData image: IconData { path: _heavyRoot.iconBasePath + "image.svg"; type: IconData.Heavy }
        readonly property IconData imagesmode: IconData { path: _heavyRoot.iconBasePath + "imagesmode.svg"; type: IconData.Heavy }
        readonly property IconData info: IconData { path: _heavyRoot.iconBasePath + "info.svg"; type: IconData.Heavy }
        readonly property IconData inventory: IconData { path: _heavyRoot.iconBasePath + "inventory.svg"; type: IconData.Heavy }
        readonly property IconData inventory2: IconData { path: _heavyRoot.iconBasePath + "inventory_2.svg"; type: IconData.Heavy }
        readonly property IconData keyboardArrowDown: IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_down.svg"; type: IconData.Heavy }
        readonly property IconData keyboardArrowLeft: IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_left.svg"; type: IconData.Heavy }
        readonly property IconData keyboardArrowRight: IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_right.svg"; type: IconData.Heavy }
        readonly property IconData keyboardArrowUp: IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_up.svg"; type: IconData.Heavy }
        readonly property IconData label: IconData { path: _heavyRoot.iconBasePath + "label.svg"; type: IconData.Heavy }
        readonly property IconData landscape: IconData { path: _heavyRoot.iconBasePath + "landscape.svg"; type: IconData.Heavy }
        readonly property IconData language: IconData { path: _heavyRoot.iconBasePath + "language.svg"; type: IconData.Heavy }
        readonly property IconData leaderboard: IconData { path: _heavyRoot.iconBasePath + "leaderboard.svg"; type: IconData.Heavy }
        readonly property IconData lightMode: IconData { path: _heavyRoot.iconBasePath + "light_mode.svg"; type: IconData.Heavy }
        readonly property IconData lightbulb: IconData { path: _heavyRoot.iconBasePath + "lightbulb.svg"; type: IconData.Heavy }
        readonly property IconData link: IconData { path: _heavyRoot.iconBasePath + "link.svg"; type: IconData.Heavy }
        readonly property IconData list: IconData { path: _heavyRoot.iconBasePath + "list.svg"; type: IconData.Heavy }
        readonly property IconData localCafe: IconData { path: _heavyRoot.iconBasePath + "local_cafe.svg"; type: IconData.Heavy }
        readonly property IconData localMall: IconData { path: _heavyRoot.iconBasePath + "local_mall.svg"; type: IconData.Heavy }
        readonly property IconData locationOn: IconData { path: _heavyRoot.iconBasePath + "location_on.svg"; type: IconData.Heavy }
        readonly property IconData lock: IconData { path: _heavyRoot.iconBasePath + "lock.svg"; type: IconData.Heavy }
        readonly property IconData lockOpen: IconData { path: _heavyRoot.iconBasePath + "lock_open.svg"; type: IconData.Heavy }
        readonly property IconData login: IconData { path: _heavyRoot.iconBasePath + "login.svg"; type: IconData.Heavy }
        readonly property IconData logout: IconData { path: _heavyRoot.iconBasePath + "logout.svg"; type: IconData.Heavy }
        readonly property IconData loyalty: IconData { path: _heavyRoot.iconBasePath + "loyalty.svg"; type: IconData.Heavy }
        readonly property IconData mail: IconData { path: _heavyRoot.iconBasePath + "mail.svg"; type: IconData.Heavy }
        readonly property IconData manageAccounts: IconData { path: _heavyRoot.iconBasePath + "manage_accounts.svg"; type: IconData.Heavy }
        readonly property IconData map: IconData { path: _heavyRoot.iconBasePath + "map.svg"; type: IconData.Heavy }
        readonly property IconData menu: IconData { path: _heavyRoot.iconBasePath + "menu.svg"; type: IconData.Heavy }
        readonly property IconData mic: IconData { path: _heavyRoot.iconBasePath + "mic.svg"; type: IconData.Heavy }
        readonly property IconData modeComment: IconData { path: _heavyRoot.iconBasePath + "mode_comment.svg"; type: IconData.Heavy }
        readonly property IconData monitoring: IconData { path: _heavyRoot.iconBasePath + "monitoring.svg"; type: IconData.Heavy }
        readonly property IconData moreHoriz: IconData { path: _heavyRoot.iconBasePath + "more_horiz.svg"; type: IconData.Heavy }
        readonly property IconData moreVert: IconData { path: _heavyRoot.iconBasePath + "more_vert.svg"; type: IconData.Heavy }
        readonly property IconData movie: IconData { path: _heavyRoot.iconBasePath + "movie.svg"; type: IconData.Heavy }
        readonly property IconData musicNote: IconData { path: _heavyRoot.iconBasePath + "music_note.svg"; type: IconData.Heavy }
        readonly property IconData myLocation: IconData { path: _heavyRoot.iconBasePath + "my_location.svg"; type: IconData.Heavy }
        readonly property IconData navigation: IconData { path: _heavyRoot.iconBasePath + "navigation.svg"; type: IconData.Heavy }
        readonly property IconData nearMe: IconData { path: _heavyRoot.iconBasePath + "near_me.svg"; type: IconData.Heavy }
        readonly property IconData nestEcoLeaf: IconData { path: _heavyRoot.iconBasePath + "nest_eco_leaf.svg"; type: IconData.Heavy }
        readonly property IconData nestRemoteComfortSensor: IconData { path: _heavyRoot.iconBasePath + "nest_remote_comfort_sensor.svg"; type: IconData.Heavy }
        readonly property IconData nightlight: IconData { path: _heavyRoot.iconBasePath + "nightlight.svg"; type: IconData.Heavy }
        readonly property IconData notifications: IconData { path: _heavyRoot.iconBasePath + "notifications.svg"; type: IconData.Heavy }
        readonly property IconData openInNew: IconData { path: _heavyRoot.iconBasePath + "open_in_new.svg"; type: IconData.Heavy }
        readonly property IconData paid: IconData { path: _heavyRoot.iconBasePath + "paid.svg"; type: IconData.Heavy }
        readonly property IconData palette: IconData { path: _heavyRoot.iconBasePath + "palette.svg"; type: IconData.Heavy }
        readonly property IconData pause: IconData { path: _heavyRoot.iconBasePath + "pause.svg"; type: IconData.Heavy }
        readonly property IconData pauseCircle: IconData { path: _heavyRoot.iconBasePath + "pause_circle.svg"; type: IconData.Heavy }
        readonly property IconData person: IconData { path: _heavyRoot.iconBasePath + "person.svg"; type: IconData.Heavy }
        readonly property IconData personAdd: IconData { path: _heavyRoot.iconBasePath + "person_add.svg"; type: IconData.Heavy }
        readonly property IconData personPin: IconData { path: _heavyRoot.iconBasePath + "person_pin.svg"; type: IconData.Heavy }
        readonly property IconData pets: IconData { path: _heavyRoot.iconBasePath + "pets.svg"; type: IconData.Heavy }
        readonly property IconData phoneIphone: IconData { path: _heavyRoot.iconBasePath + "phone_iphone.svg"; type: IconData.Heavy }
        readonly property IconData photoCamera: IconData { path: _heavyRoot.iconBasePath + "photo_camera.svg"; type: IconData.Heavy }
        readonly property IconData photoLibrary: IconData { path: _heavyRoot.iconBasePath + "photo_library.svg"; type: IconData.Heavy }
        readonly property IconData pictureAsPdf: IconData { path: _heavyRoot.iconBasePath + "picture_as_pdf.svg"; type: IconData.Heavy }
        readonly property IconData pinDrop: IconData { path: _heavyRoot.iconBasePath + "pin_drop.svg"; type: IconData.Heavy }
        readonly property IconData playArrow: IconData { path: _heavyRoot.iconBasePath + "play_arrow.svg"; type: IconData.Heavy }
        readonly property IconData playCircle: IconData { path: _heavyRoot.iconBasePath + "play_circle.svg"; type: IconData.Heavy }
        readonly property IconData power: IconData { path: _heavyRoot.iconBasePath + "power.svg"; type: IconData.Heavy }
        readonly property IconData printElement: IconData { path: _heavyRoot.iconBasePath + "print.svg"; type: IconData.Heavy }
        readonly property IconData priorityHigh: IconData { path: _heavyRoot.iconBasePath + "priority_high.svg"; type: IconData.Heavy }
        readonly property IconData publicElement: IconData { path: _heavyRoot.iconBasePath + "public.svg"; type: IconData.Heavy }
        readonly property IconData qrCode: IconData { path: _heavyRoot.iconBasePath + "qr_code.svg"; type: IconData.Heavy }
        readonly property IconData qrCode2: IconData { path: _heavyRoot.iconBasePath + "qr_code_2.svg"; type: IconData.Heavy }
        readonly property IconData qrCodeScanner: IconData { path: _heavyRoot.iconBasePath + "qr_code_scanner.svg"; type: IconData.Heavy }
        readonly property IconData queryStats: IconData { path: _heavyRoot.iconBasePath + "query_stats.svg"; type: IconData.Heavy }
        readonly property IconData questionMark: IconData { path: _heavyRoot.iconBasePath + "question_mark.svg"; type: IconData.Heavy }
        readonly property IconData radar: IconData { path: _heavyRoot.iconBasePath + "radar.svg"; type: IconData.Heavy }
        readonly property IconData refresh: IconData { path: _heavyRoot.iconBasePath + "refresh.svg"; type: IconData.Heavy }
        readonly property IconData remove: IconData { path: _heavyRoot.iconBasePath + "remove.svg"; type: IconData.Heavy }
        readonly property IconData repeat: IconData { path: _heavyRoot.iconBasePath + "repeat.svg"; type: IconData.Heavy }
        readonly property IconData replay: IconData { path: _heavyRoot.iconBasePath + "replay.svg"; type: IconData.Heavy }
        readonly property IconData report: IconData { path: _heavyRoot.iconBasePath + "report.svg"; type: IconData.Heavy }
        readonly property IconData restartAlt: IconData { path: _heavyRoot.iconBasePath + "restart_alt.svg"; type: IconData.Heavy }
        readonly property IconData restaurant: IconData { path: _heavyRoot.iconBasePath + "restaurant.svg"; type: IconData.Heavy }
        readonly property IconData restaurantMenu: IconData { path: _heavyRoot.iconBasePath + "restaurant_menu.svg"; type: IconData.Heavy }
        readonly property IconData rocketLaunch: IconData { path: _heavyRoot.iconBasePath + "rocket_launch.svg"; type: IconData.Heavy }
        readonly property IconData rssFeed: IconData { path: _heavyRoot.iconBasePath + "rss_feed.svg"; type: IconData.Heavy }
        readonly property IconData save: IconData { path: _heavyRoot.iconBasePath + "save.svg"; type: IconData.Heavy }
        readonly property IconData savings: IconData { path: _heavyRoot.iconBasePath + "savings.svg"; type: IconData.Heavy }
        readonly property IconData schedule: IconData { path: _heavyRoot.iconBasePath + "schedule.svg"; type: IconData.Heavy }
        readonly property IconData school: IconData { path: _heavyRoot.iconBasePath + "school.svg"; type: IconData.Heavy }
        readonly property IconData science: IconData { path: _heavyRoot.iconBasePath + "science.svg"; type: IconData.Heavy }
        readonly property IconData search: IconData { path: _heavyRoot.iconBasePath + "search.svg"; type: IconData.Heavy }
        readonly property IconData security: IconData { path: _heavyRoot.iconBasePath + "security.svg"; type: IconData.Heavy }
        readonly property IconData sell: IconData { path: _heavyRoot.iconBasePath + "sell.svg"; type: IconData.Heavy }
        readonly property IconData send: IconData { path: _heavyRoot.iconBasePath + "send.svg"; type: IconData.Heavy }
        readonly property IconData settings: IconData { path: _heavyRoot.iconBasePath + "settings.svg"; type: IconData.Heavy }
        readonly property IconData share: IconData { path: _heavyRoot.iconBasePath + "share.svg"; type: IconData.Heavy }
        readonly property IconData shoppingBag: IconData { path: _heavyRoot.iconBasePath + "shopping_bag.svg"; type: IconData.Heavy }
        readonly property IconData shoppingCart: IconData { path: _heavyRoot.iconBasePath + "shopping_cart.svg"; type: IconData.Heavy }
        readonly property IconData shuffle: IconData { path: _heavyRoot.iconBasePath + "shuffle.svg"; type: IconData.Heavy }
        readonly property IconData signalCellularAlt: IconData { path: _heavyRoot.iconBasePath + "signal_cellular_alt.svg"; type: IconData.Heavy }
        readonly property IconData skipNext: IconData { path: _heavyRoot.iconBasePath + "skip_next.svg"; type: IconData.Heavy }
        readonly property IconData skipPrevious: IconData { path: _heavyRoot.iconBasePath + "skip_previous.svg"; type: IconData.Heavy }
        readonly property IconData smartphone: IconData { path: _heavyRoot.iconBasePath + "smartphone.svg"; type: IconData.Heavy }
        readonly property IconData sort: IconData { path: _heavyRoot.iconBasePath + "sort.svg"; type: IconData.Heavy }
        readonly property IconData sportsEsports: IconData { path: _heavyRoot.iconBasePath + "sports_esports.svg"; type: IconData.Heavy }
        readonly property IconData sportsSoccer: IconData { path: _heavyRoot.iconBasePath + "sports_soccer.svg"; type: IconData.Heavy }
        readonly property IconData stadiaController: IconData { path: _heavyRoot.iconBasePath + "stadia_controller.svg"; type: IconData.Heavy }
        readonly property IconData star: IconData { path: _heavyRoot.iconBasePath + "star.svg"; type: IconData.Heavy }
        readonly property IconData stop: IconData { path: _heavyRoot.iconBasePath + "stop.svg"; type: IconData.Heavy }
        readonly property IconData stopCircle: IconData { path: _heavyRoot.iconBasePath + "stop_circle.svg"; type: IconData.Heavy }
        readonly property IconData storage: IconData { path: _heavyRoot.iconBasePath + "storage.svg"; type: IconData.Heavy }
        readonly property IconData store: IconData { path: _heavyRoot.iconBasePath + "store.svg"; type: IconData.Heavy }
        readonly property IconData storefront: IconData { path: _heavyRoot.iconBasePath + "storefront.svg"; type: IconData.Heavy }
        readonly property IconData subscriptions: IconData { path: _heavyRoot.iconBasePath + "subscriptions.svg"; type: IconData.Heavy }
        readonly property IconData sync: IconData { path: _heavyRoot.iconBasePath + "sync.svg"; type: IconData.Heavy }
        readonly property IconData taskAlt: IconData { path: _heavyRoot.iconBasePath + "task_alt.svg"; type: IconData.Heavy }
        readonly property IconData theaters: IconData { path: _heavyRoot.iconBasePath + "theaters.svg"; type: IconData.Heavy }
        readonly property IconData thumbUp: IconData { path: _heavyRoot.iconBasePath + "thumb_up.svg"; type: IconData.Heavy }
        readonly property IconData timeline: IconData { path: _heavyRoot.iconBasePath + "timeline.svg"; type: IconData.Heavy }
        readonly property IconData timer: IconData { path: _heavyRoot.iconBasePath + "timer.svg"; type: IconData.Heavy }
        readonly property IconData touchApp: IconData { path: _heavyRoot.iconBasePath + "touch_app.svg"; type: IconData.Heavy }
        readonly property IconData trendingDown: IconData { path: _heavyRoot.iconBasePath + "trending_down.svg"; type: IconData.Heavy }
        readonly property IconData trendingUp: IconData { path: _heavyRoot.iconBasePath + "trending_up.svg"; type: IconData.Heavy }
        readonly property IconData tune: IconData { path: _heavyRoot.iconBasePath + "tune.svg"; type: IconData.Heavy }
        readonly property IconData undo: IconData { path: _heavyRoot.iconBasePath + "undo.svg"; type: IconData.Heavy }
        readonly property IconData update: IconData { path: _heavyRoot.iconBasePath + "update.svg"; type: IconData.Heavy }
        readonly property IconData uploadFile: IconData { path: _heavyRoot.iconBasePath + "upload_file.svg"; type: IconData.Heavy }
        readonly property IconData usb: IconData { path: _heavyRoot.iconBasePath + "usb.svg"; type: IconData.Heavy }
        readonly property IconData verified: IconData { path: _heavyRoot.iconBasePath + "verified.svg"; type: IconData.Heavy }
        readonly property IconData verifiedUser: IconData { path: _heavyRoot.iconBasePath + "verified_user.svg"; type: IconData.Heavy }
        readonly property IconData videoLibrary: IconData { path: _heavyRoot.iconBasePath + "video_library.svg"; type: IconData.Heavy }
        readonly property IconData videocam: IconData { path: _heavyRoot.iconBasePath + "videocam.svg"; type: IconData.Heavy }
        readonly property IconData visibility: IconData { path: _heavyRoot.iconBasePath + "visibility.svg"; type: IconData.Heavy }
        readonly property IconData visibilityOff: IconData { path: _heavyRoot.iconBasePath + "visibility_off.svg"; type: IconData.Heavy }
        readonly property IconData volumeOff: IconData { path: _heavyRoot.iconBasePath + "volume_off.svg"; type: IconData.Heavy }
        readonly property IconData volumeUp: IconData { path: _heavyRoot.iconBasePath + "volume_up.svg"; type: IconData.Heavy }
        readonly property IconData wallet: IconData { path: _heavyRoot.iconBasePath + "wallet.svg"; type: IconData.Heavy }
        readonly property IconData wallpaper: IconData { path: _heavyRoot.iconBasePath + "wallpaper.svg"; type: IconData.Heavy }
        readonly property IconData warning: IconData { path: _heavyRoot.iconBasePath + "warning.svg"; type: IconData.Heavy }
        readonly property IconData wbSunny: IconData { path: _heavyRoot.iconBasePath + "wb_sunny.svg"; type: IconData.Heavy }
        readonly property IconData whereToVote: IconData { path: _heavyRoot.iconBasePath + "where_to_vote.svg"; type: IconData.Heavy }
        readonly property IconData widgets: IconData { path: _heavyRoot.iconBasePath + "widgets.svg"; type: IconData.Heavy }
        readonly property IconData wifi: IconData { path: _heavyRoot.iconBasePath + "wifi.svg"; type: IconData.Heavy }
        readonly property IconData wifiOff: IconData { path: _heavyRoot.iconBasePath + "wifi_off.svg"; type: IconData.Heavy }
        readonly property IconData work: IconData { path: _heavyRoot.iconBasePath + "work.svg"; type: IconData.Heavy }
        readonly property IconData dashedCircle: IconData { path: _heavyRoot.iconBasePath + "dashedCircle.svg"; type: IconData.Heavy }
        readonly property IconData colorize: IconData { path: _heavyRoot.iconBasePath + "colorize.svg"; type: IconData.Heavy }


        function getAll() : list<string> {
            return _root.getPropertyNames(this);
        }
    }

    property QtObject light: QtObject {
        readonly property IconData inventory2: IconData { path: '\ue900'; type: IconData.Light }
        readonly property IconData keyboardArrowDown: IconData { path: '\ue901'; type: IconData.Light }
        readonly property IconData keyboardArrowLeft: IconData { path: '\ue902'; type: IconData.Light }
        readonly property IconData keyboardArrowRight: IconData { path: '\ue903'; type: IconData.Light }
        readonly property IconData keyboardArrowUp: IconData { path: '\ue904'; type: IconData.Light }
        readonly property IconData label: IconData { path: '\ue905'; type: IconData.Light }
        readonly property IconData landscape: IconData { path: '\ue906'; type: IconData.Light }
        readonly property IconData language: IconData { path: '\ue907'; type: IconData.Light }
        readonly property IconData leaderboard: IconData { path: '\ue908'; type: IconData.Light }
        readonly property IconData lightMode: IconData { path: '\ue909'; type: IconData.Light }
        readonly property IconData lightbulb: IconData { path: '\ue90a'; type: IconData.Light }
        readonly property IconData link: IconData { path: '\ue90b'; type: IconData.Light }
        readonly property IconData list: IconData { path: '\ue90c'; type: IconData.Light }
        readonly property IconData localCafe: IconData { path: '\ue90d'; type: IconData.Light }
        readonly property IconData localMall: IconData { path: '\ue90e'; type: IconData.Light }
        readonly property IconData locationOn: IconData { path: '\ue90f'; type: IconData.Light }
        readonly property IconData lock: IconData { path: '\ue910'; type: IconData.Light }
        readonly property IconData lockOpen: IconData { path: '\ue911'; type: IconData.Light }
        readonly property IconData login: IconData { path: '\ue912'; type: IconData.Light }
        readonly property IconData logout: IconData { path: '\ue913'; type: IconData.Light }
        readonly property IconData loyalty: IconData { path: '\ue914'; type: IconData.Light }
        readonly property IconData mail: IconData { path: '\ue915'; type: IconData.Light }
        readonly property IconData manageAccounts: IconData { path: '\ue916'; type: IconData.Light }
        readonly property IconData map: IconData { path: '\ue917'; type: IconData.Light }
        readonly property IconData menu: IconData { path: '\ue918'; type: IconData.Light }
        readonly property IconData mic: IconData { path: '\ue919'; type: IconData.Light }
        readonly property IconData modeComment: IconData { path: '\ue91a'; type: IconData.Light }
        readonly property IconData monitoring: IconData { path: '\ue91b'; type: IconData.Light }
        readonly property IconData moreHoriz: IconData { path: '\ue91c'; type: IconData.Light }
        readonly property IconData moreVert: IconData { path: '\ue91d'; type: IconData.Light }
        readonly property IconData movie: IconData { path: '\ue91e'; type: IconData.Light }
        readonly property IconData musicNote: IconData { path: '\ue91f'; type: IconData.Light }
        readonly property IconData myLocation: IconData { path: '\ue920'; type: IconData.Light }
        readonly property IconData navigation: IconData { path: '\ue921'; type: IconData.Light }
        readonly property IconData nearMe: IconData { path: '\ue922'; type: IconData.Light }
        readonly property IconData nestEcoLeaf: IconData { path: '\ue923'; type: IconData.Light }
        readonly property IconData nestRemoteComfortSensor: IconData { path: '\ue924'; type: IconData.Light }
        readonly property IconData nightlight: IconData { path: '\ue925'; type: IconData.Light }
        readonly property IconData notifications: IconData { path: '\ue926'; type: IconData.Light }
        readonly property IconData openInNew: IconData { path: '\ue927'; type: IconData.Light }
        readonly property IconData paid: IconData { path: '\ue928'; type: IconData.Light }
        readonly property IconData palette: IconData { path: '\ue929'; type: IconData.Light }
        readonly property IconData pause: IconData { path: '\ue92a'; type: IconData.Light }
        readonly property IconData pauseCircle: IconData { path: '\ue92b'; type: IconData.Light }
        readonly property IconData person: IconData { path: '\ue92c'; type: IconData.Light }
        readonly property IconData personAdd: IconData { path: '\ue92d'; type: IconData.Light }
        readonly property IconData personPin: IconData { path: '\ue92e'; type: IconData.Light }
        readonly property IconData pets: IconData { path: '\ue92f'; type: IconData.Light }
        readonly property IconData phoneIphone: IconData { path: '\ue930'; type: IconData.Light }
        readonly property IconData photoCamera: IconData { path: '\ue931'; type: IconData.Light }
        readonly property IconData photoLibrary: IconData { path: '\ue932'; type: IconData.Light }
        readonly property IconData pictureAsPdf: IconData { path: '\ue933'; type: IconData.Light }
        readonly property IconData pinDrop: IconData { path: '\ue934'; type: IconData.Light }
        readonly property IconData playArrow: IconData { path: '\ue935'; type: IconData.Light }
        readonly property IconData playCircle: IconData { path: '\ue936'; type: IconData.Light }
        readonly property IconData power: IconData { path: '\ue937'; type: IconData.Light }
        readonly property IconData printElement: IconData { path: '\ue938'; type: IconData.Light }
        readonly property IconData priorityHigh: IconData { path: '\ue939'; type: IconData.Light }
        readonly property IconData publicElement: IconData { path: '\ue93a'; type: IconData.Light }
        readonly property IconData qrCode: IconData { path: '\ue93b'; type: IconData.Light }
        readonly property IconData qrCode2: IconData { path: '\ue93c'; type: IconData.Light }
        readonly property IconData qrCodeScanner: IconData { path: '\ue93d'; type: IconData.Light }
        readonly property IconData queryStats: IconData { path: '\ue93e'; type: IconData.Light }
        readonly property IconData questionMark: IconData { path: '\ue93f'; type: IconData.Light }
        readonly property IconData radar: IconData { path: '\ue940'; type: IconData.Light }
        readonly property IconData refresh: IconData { path: '\ue941'; type: IconData.Light }
        readonly property IconData remove: IconData { path: '\ue942'; type: IconData.Light }
        readonly property IconData repeat: IconData { path: '\ue943'; type: IconData.Light }
        readonly property IconData replay: IconData { path: '\ue944'; type: IconData.Light }
        readonly property IconData report: IconData { path: '\ue945'; type: IconData.Light }
        readonly property IconData restartAlt: IconData { path: '\ue946'; type: IconData.Light }
        readonly property IconData restaurant: IconData { path: '\ue947'; type: IconData.Light }
        readonly property IconData restaurantMenu: IconData { path: '\ue948'; type: IconData.Light }
        readonly property IconData rocketLaunch: IconData { path: '\ue949'; type: IconData.Light }
        readonly property IconData rssFeed: IconData { path: '\ue94a'; type: IconData.Light }
        readonly property IconData save: IconData { path: '\ue94b'; type: IconData.Light }
        readonly property IconData savings: IconData { path: '\ue94c'; type: IconData.Light }
        readonly property IconData schedule: IconData { path: '\ue94d'; type: IconData.Light }
        readonly property IconData school: IconData { path: '\ue94e'; type: IconData.Light }
        readonly property IconData science: IconData { path: '\ue94f'; type: IconData.Light }
        readonly property IconData search: IconData { path: '\ue950'; type: IconData.Light }
        readonly property IconData security: IconData { path: '\ue951'; type: IconData.Light }
        readonly property IconData sell: IconData { path: '\ue952'; type: IconData.Light }
        readonly property IconData send: IconData { path: '\ue953'; type: IconData.Light }
        readonly property IconData settings: IconData { path: '\ue954'; type: IconData.Light }
        readonly property IconData share: IconData { path: '\ue955'; type: IconData.Light }
        readonly property IconData shoppingBag: IconData { path: '\ue956'; type: IconData.Light }
        readonly property IconData shoppingCart: IconData { path: '\ue957'; type: IconData.Light }
        readonly property IconData shuffle: IconData { path: '\ue958'; type: IconData.Light }
        readonly property IconData signalCellularAlt: IconData { path: '\ue959'; type: IconData.Light }
        readonly property IconData skipNext: IconData { path: '\ue95a'; type: IconData.Light }
        readonly property IconData skipPrevious: IconData { path: '\ue95b'; type: IconData.Light }
        readonly property IconData smartphone: IconData { path: '\ue95c'; type: IconData.Light }
        readonly property IconData sort: IconData { path: '\ue95d'; type: IconData.Light }
        readonly property IconData sportsEsports: IconData { path: '\ue95e'; type: IconData.Light }
        readonly property IconData sportsSoccer: IconData { path: '\ue95f'; type: IconData.Light }
        readonly property IconData stadiaController: IconData { path: '\ue960'; type: IconData.Light }
        readonly property IconData star: IconData { path: '\ue961'; type: IconData.Light }
        readonly property IconData stop: IconData { path: '\ue962'; type: IconData.Light }
        readonly property IconData stopCircle: IconData { path: '\ue963'; type: IconData.Light }
        readonly property IconData storage: IconData { path: '\ue964'; type: IconData.Light }
        readonly property IconData store: IconData { path: '\ue965'; type: IconData.Light }
        readonly property IconData storefront: IconData { path: '\ue966'; type: IconData.Light }
        readonly property IconData subscriptions: IconData { path: '\ue967'; type: IconData.Light }
        readonly property IconData sync: IconData { path: '\ue968'; type: IconData.Light }
        readonly property IconData taskAlt: IconData { path: '\ue969'; type: IconData.Light }
        readonly property IconData theaters: IconData { path: '\ue96a'; type: IconData.Light }
        readonly property IconData thumbUp: IconData { path: '\ue96b'; type: IconData.Light }
        readonly property IconData timeline: IconData { path: '\ue96c'; type: IconData.Light }
        readonly property IconData timer: IconData { path: '\ue96d'; type: IconData.Light }
        readonly property IconData touchApp: IconData { path: '\ue96e'; type: IconData.Light }
        readonly property IconData trendingDown: IconData { path: '\ue96f'; type: IconData.Light }
        readonly property IconData trendingUp: IconData { path: '\ue970'; type: IconData.Light }
        readonly property IconData tune: IconData { path: '\ue971'; type: IconData.Light }
        readonly property IconData undo: IconData { path: '\ue972'; type: IconData.Light }
        readonly property IconData update: IconData { path: '\ue973'; type: IconData.Light }
        readonly property IconData uploadFile: IconData { path: '\ue974'; type: IconData.Light }
        readonly property IconData usb: IconData { path: '\ue975'; type: IconData.Light }
        readonly property IconData verified: IconData { path: '\ue976'; type: IconData.Light }
        readonly property IconData verifiedUser: IconData { path: '\ue977'; type: IconData.Light }
        readonly property IconData videoLibrary: IconData { path: '\ue978'; type: IconData.Light }
        readonly property IconData videocam: IconData { path: '\ue979'; type: IconData.Light }
        readonly property IconData visibility: IconData { path: '\ue97a'; type: IconData.Light }
        readonly property IconData visibilityOff: IconData { path: '\ue97b'; type: IconData.Light }
        readonly property IconData volumeOff: IconData { path: '\ue97c'; type: IconData.Light }
        readonly property IconData volumeUp: IconData { path: '\ue97d'; type: IconData.Light }
        readonly property IconData wallet: IconData { path: '\ue97e'; type: IconData.Light }
        readonly property IconData wallpaper: IconData { path: '\ue97f'; type: IconData.Light }
        readonly property IconData warning: IconData { path: '\ue980'; type: IconData.Light }
        readonly property IconData wbSunny: IconData { path: '\ue981'; type: IconData.Light }
        readonly property IconData whereToVote: IconData { path: '\ue982'; type: IconData.Light }
        readonly property IconData widgets: IconData { path: '\ue983'; type: IconData.Light }
        readonly property IconData wifi: IconData { path: '\ue984'; type: IconData.Light }
        readonly property IconData wifiOff: IconData { path: '\ue985'; type: IconData.Light }
        readonly property IconData work: IconData { path: '\ue986'; type: IconData.Light }
        readonly property IconData accountBalance: IconData { path: '\ue987'; type: IconData.Light }
        readonly property IconData accountBox: IconData { path: '\ue988'; type: IconData.Light }
        readonly property IconData accountCircle: IconData { path: '\ue989'; type: IconData.Light }
        readonly property IconData adb: IconData { path: '\ue98a'; type: IconData.Light }
        readonly property IconData add: IconData { path: '\ue98b'; type: IconData.Light }
        readonly property IconData addAPhoto: IconData { path: '\ue98c'; type: IconData.Light }
        readonly property IconData addBox: IconData { path: '\ue98d'; type: IconData.Light }
        readonly property IconData addBusiness: IconData { path: '\ue98e'; type: IconData.Light }
        readonly property IconData addCard: IconData { path: '\ue98f'; type: IconData.Light }
        readonly property IconData addCircle: IconData { path: '\ue990'; type: IconData.Light }
        readonly property IconData addPhotoAlternate: IconData { path: '\ue991'; type: IconData.Light }
        readonly property IconData addShoppingCart: IconData { path: '\ue992'; type: IconData.Light }
        readonly property IconData air: IconData { path: '\ue993'; type: IconData.Light }
        readonly property IconData alarm: IconData { path: '\ue994'; type: IconData.Light }
        readonly property IconData analytics: IconData { path: '\ue995'; type: IconData.Light }
        readonly property IconData android: IconData { path: '\ue996'; type: IconData.Light }
        readonly property IconData apps: IconData { path: '\ue997'; type: IconData.Light }
        readonly property IconData arrowBack: IconData { path: '\ue998'; type: IconData.Light }
        readonly property IconData arrowDownward: IconData { path: '\ue999'; type: IconData.Light }
        readonly property IconData arrowDropDown: IconData { path: '\ue99a'; type: IconData.Light }
        readonly property IconData arrowDropUp: IconData { path: '\ue99b'; type: IconData.Light }
        readonly property IconData arrowForward: IconData { path: '\ue99c'; type: IconData.Light }
        readonly property IconData arrowRight: IconData { path: '\ue99d'; type: IconData.Light }
        readonly property IconData atr: IconData { path: '\ue99e'; type: IconData.Light }
        readonly property IconData attachMoney: IconData { path: '\ue99f'; type: IconData.Light }
        readonly property IconData autorenew: IconData { path: '\ue9a0'; type: IconData.Light }
        readonly property IconData backspace: IconData { path: '\ue9a1'; type: IconData.Light }
        readonly property IconData badge: IconData { path: '\ue9a2'; type: IconData.Light }
        readonly property IconData barChart: IconData { path: '\ue9a3'; type: IconData.Light }
        readonly property IconData barcodeScanner: IconData { path: '\ue9a4'; type: IconData.Light }
        readonly property IconData batteryChargingFull: IconData { path: '\ue9a5'; type: IconData.Light }
        readonly property IconData batteryFull: IconData { path: '\ue9a6'; type: IconData.Light }
        readonly property IconData batteryFullAlt: IconData { path: '\ue9a7'; type: IconData.Light }
        readonly property IconData bluetooth: IconData { path: '\ue9a8'; type: IconData.Light }
        readonly property IconData bookmark: IconData { path: '\ue9a9'; type: IconData.Light }
        readonly property IconData brush: IconData { path: '\ue9aa'; type: IconData.Light }
        readonly property IconData build: IconData { path: '\ue9ab'; type: IconData.Light }
        readonly property IconData cable: IconData { path: '\ue9ac'; type: IconData.Light }
        readonly property IconData cake: IconData { path: '\ue9ad'; type: IconData.Light }
        readonly property IconData calculate: IconData { path: '\ue9ae'; type: IconData.Light }
        readonly property IconData calendarMonth: IconData { path: '\ue9af'; type: IconData.Light }
        readonly property IconData calendarToday: IconData { path: '\ue9b0'; type: IconData.Light }
        readonly property IconData call: IconData { path: '\ue9b1'; type: IconData.Light }
        readonly property IconData camera: IconData { path: '\ue9b2'; type: IconData.Light }
        readonly property IconData campaign: IconData { path: '\ue9b3'; type: IconData.Light }
        readonly property IconData cancel: IconData { path: '\ue9b4'; type: IconData.Light }
        readonly property IconData cast: IconData { path: '\ue9b5'; type: IconData.Light }
        readonly property IconData category: IconData { path: '\ue9b6'; type: IconData.Light }
        readonly property IconData celebration: IconData { path: '\ue9b7'; type: IconData.Light }
        readonly property IconData chat: IconData { path: '\ue9b8'; type: IconData.Light }
        readonly property IconData chatBubble: IconData { path: '\ue9b9'; type: IconData.Light }
        readonly property IconData check: IconData { path: '\ue9ba'; type: IconData.Light }
        readonly property IconData checkBox: IconData { path: '\ue9bb'; type: IconData.Light }
        readonly property IconData checkBoxOutlineBlank: IconData { path: '\ue9bc'; type: IconData.Light }
        readonly property IconData checkCircle: IconData { path: '\ue9bd'; type: IconData.Light }
        readonly property IconData chevronLeft: IconData { path: '\ue9be'; type: IconData.Light }
        readonly property IconData chevronRight: IconData { path: '\ue9bf'; type: IconData.Light }
        readonly property IconData circle: IconData { path: '\ue9c0'; type: IconData.Light }
        readonly property IconData close: IconData { path: '\ue9c1'; type: IconData.Light }
        readonly property IconData code: IconData { path: '\ue9c2'; type: IconData.Light }
        readonly property IconData computer: IconData { path: '\ue9c3'; type: IconData.Light }
        readonly property IconData construction: IconData { path: '\ue9c4'; type: IconData.Light }
        readonly property IconData contactSupport: IconData { path: '\ue9c5'; type: IconData.Light }
        readonly property IconData contentCopy: IconData { path: '\ue9c6'; type: IconData.Light }
        readonly property IconData creditCard: IconData { path: '\ue9c7'; type: IconData.Light }
        readonly property IconData cropFree: IconData { path: '\ue9c8'; type: IconData.Light }
        readonly property IconData currencyBitcoin: IconData { path: '\ue9c9'; type: IconData.Light }
        readonly property IconData darkMode: IconData { path: '\ue9ca'; type: IconData.Light }
        readonly property IconData dashboard: IconData { path: '\ue9cb'; type: IconData.Light }
        readonly property IconData database: IconData { path: '\ue9cc'; type: IconData.Light }
        readonly property IconData deleteElement: IconData { path: '\ue9cd'; type: IconData.Light }
        readonly property IconData deleteForever: IconData { path: '\ue9ce'; type: IconData.Light }
        readonly property IconData description: IconData { path: '\ue9cf'; type: IconData.Light }
        readonly property IconData devices: IconData { path: '\ue9d0'; type: IconData.Light }
        readonly property IconData directionsCar: IconData { path: '\ue9d1'; type: IconData.Light }
        readonly property IconData domain: IconData { path: '\ue9d2'; type: IconData.Light }
        readonly property IconData doneAll: IconData { path: '\ue9d3'; type: IconData.Light }
        readonly property IconData download: IconData { path: '\ue9d4'; type: IconData.Light }
        readonly property IconData downloadForOffline: IconData { path: '\ue9d5'; type: IconData.Light }
        readonly property IconData draw: IconData { path: '\ue9d6'; type: IconData.Light }
        readonly property IconData eco: IconData { path: '\ue9d7'; type: IconData.Light }
        readonly property IconData edit: IconData { path: '\ue9d8'; type: IconData.Light }
        readonly property IconData editNote: IconData { path: '\ue9d9'; type: IconData.Light }
        readonly property IconData electricBolt: IconData { path: '\ue9da'; type: IconData.Light }
        readonly property IconData emojiObjects: IconData { path: '\ue9db'; type: IconData.Light }
        readonly property IconData engineering: IconData { path: '\ue9dc'; type: IconData.Light }
        readonly property IconData error: IconData { path: '\ue9dd'; type: IconData.Light }
        readonly property IconData euro: IconData { path: '\ue9de'; type: IconData.Light }
        readonly property IconData event: IconData { path: '\ue9df'; type: IconData.Light }
        readonly property IconData explore: IconData { path: '\ue9e0'; type: IconData.Light }
        readonly property IconData extension: IconData { path: '\ue9e1'; type: IconData.Light }
        readonly property IconData familiarFaceAndZone: IconData { path: '\ue9e2'; type: IconData.Light }
        readonly property IconData fastForward: IconData { path: '\ue9e3'; type: IconData.Light }
        readonly property IconData fastRewind: IconData { path: '\ue9e4'; type: IconData.Light }
        readonly property IconData favorite: IconData { path: '\ue9e5'; type: IconData.Light }
        readonly property IconData fileCopy: IconData { path: '\ue9e6'; type: IconData.Light }
        readonly property IconData filterAlt: IconData { path: '\ue9e7'; type: IconData.Light }
        readonly property IconData filterList: IconData { path: '\ue9e8'; type: IconData.Light }
        readonly property IconData finance: IconData { path: '\ue9e9'; type: IconData.Light }
        readonly property IconData fingerprint: IconData { path: '\ue9ea'; type: IconData.Light }
        readonly property IconData flag: IconData { path: '\ue9eb'; type: IconData.Light }
        readonly property IconData flashOn: IconData { path: '\ue9ec'; type: IconData.Light }
        readonly property IconData flashlightOn: IconData { path: '\ue9ed'; type: IconData.Light }
        readonly property IconData flight: IconData { path: '\ue9ee'; type: IconData.Light }
        readonly property IconData folder: IconData { path: '\ue9ef'; type: IconData.Light }
        readonly property IconData folderOpen: IconData { path: '\ue9f0'; type: IconData.Light }
        readonly property IconData forum: IconData { path: '\ue9f1'; type: IconData.Light }
        readonly property IconData gridOn: IconData { path: '\ue9f2'; type: IconData.Light }
        readonly property IconData gridView: IconData { path: '\ue9f3'; type: IconData.Light }
        readonly property IconData group: IconData { path: '\ue9f4'; type: IconData.Light }
        readonly property IconData groupAdd: IconData { path: '\ue9f5'; type: IconData.Light }
        readonly property IconData groups: IconData { path: '\ue9f6'; type: IconData.Light }
        readonly property IconData handyman: IconData { path: '\ue9f7'; type: IconData.Light }
        readonly property IconData headphones: IconData { path: '\ue9f8'; type: IconData.Light }
        readonly property IconData hearing: IconData { path: '\ue9f9'; type: IconData.Light }
        readonly property IconData help: IconData { path: '\ue9fa'; type: IconData.Light }
        readonly property IconData history: IconData { path: '\ue9fb'; type: IconData.Light }
        readonly property IconData home: IconData { path: '\ue9fc'; type: IconData.Light }
        readonly property IconData homePin: IconData { path: '\ue9fd'; type: IconData.Light }
        readonly property IconData image: IconData { path: '\ue9fe'; type: IconData.Light }
        readonly property IconData imagesmode: IconData { path: '\ue9ff'; type: IconData.Light }
        readonly property IconData info: IconData { path: '\uea00'; type: IconData.Light }
        readonly property IconData inventory: IconData { path: '\uea01'; type: IconData.Light }
        readonly property IconData colorize: IconData { path: '\uea02'; type: IconData.Light }

        function getAll() : list<string> {
            return _root.getPropertyNames(this);
        }
    }

    function getAll() : list<string> {
        let heavyList = _root.heavy.getAll();
        let lightList = _root.light.getAll();

        let combinedList = heavyList.slice();
        for (let i = 0; i < lightList.length; i++) {
           if (combinedList.indexOf(lightList[i]) === -1) {
                combinedList.push(lightList[i]);
            }
        }
        return combinedList;
    }

    function getPropertyNames(iconContainer: QtObject) : list<string> {
        var names = [];
        for (var key in iconContainer) {
            if (iconContainer.hasOwnProperty(key) && typeof iconContainer[key] == "object") {
                names.push(key);
            }
        }
        return names;
    }
}
