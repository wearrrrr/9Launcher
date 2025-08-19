pragma Singleton

import QtQuick

import MMaterial.Media as Media

QtObject{
    id: _root

	readonly property Media.IconSet heavy: Media.IconSet {
        id: _heavyRoot

		readonly property string iconBasePath: "qrc:/MMaterial/Media/assets/svg/"

		logo: Media.IconData { path: _heavyRoot.iconBasePath + "logo.svg"; type: Media.IconData.Heavy }
		accountBalance: Media.IconData { path: _heavyRoot.iconBasePath + "account_balance.svg"; type: Media.IconData.Heavy }
		accountBox: Media.IconData { path: _heavyRoot.iconBasePath + "account_box.svg"; type: Media.IconData.Heavy }
		accountCircle: Media.IconData { path: _heavyRoot.iconBasePath + "account_circle.svg"; type: Media.IconData.Heavy }
		adb: Media.IconData { path: _heavyRoot.iconBasePath + "adb.svg"; type: Media.IconData.Heavy }
		add: Media.IconData { path: _heavyRoot.iconBasePath + "add.svg"; type: Media.IconData.Heavy }
		addAPhoto: Media.IconData { path: _heavyRoot.iconBasePath + "add_a_photo.svg"; type: Media.IconData.Heavy }
		addBox: Media.IconData { path: _heavyRoot.iconBasePath + "add_box.svg"; type: Media.IconData.Heavy }
		addBusiness: Media.IconData { path: _heavyRoot.iconBasePath + "add_business.svg"; type: Media.IconData.Heavy }
		addCard: Media.IconData { path: _heavyRoot.iconBasePath + "add_card.svg"; type: Media.IconData.Heavy }
		addCircle: Media.IconData { path: _heavyRoot.iconBasePath + "add_circle.svg"; type: Media.IconData.Heavy }
		addPhotoAlternate: Media.IconData { path: _heavyRoot.iconBasePath + "add_photo_alternate.svg"; type: Media.IconData.Heavy }
		addShoppingCart: Media.IconData { path: _heavyRoot.iconBasePath + "add_shopping_cart.svg"; type: Media.IconData.Heavy }
		air: Media.IconData { path: _heavyRoot.iconBasePath + "air.svg"; type: Media.IconData.Heavy }
		alarm: Media.IconData { path: _heavyRoot.iconBasePath + "alarm.svg"; type: Media.IconData.Heavy }
		analytics: Media.IconData { path: _heavyRoot.iconBasePath + "analytics.svg"; type: Media.IconData.Heavy }
		android: Media.IconData { path: _heavyRoot.iconBasePath + "android.svg"; type: Media.IconData.Heavy }
		apps: Media.IconData { path: _heavyRoot.iconBasePath + "apps.svg"; type: Media.IconData.Heavy }
		arrowBack: Media.IconData { path: _heavyRoot.iconBasePath + "arrow_back.svg"; type: Media.IconData.Heavy }
		arrowDownward: Media.IconData { path: _heavyRoot.iconBasePath + "arrow_downward.svg"; type: Media.IconData.Heavy }
		arrowDropDown: Media.IconData { path: _heavyRoot.iconBasePath + "arrow_drop_down.svg"; type: Media.IconData.Heavy }
		arrowDropUp: Media.IconData { path: _heavyRoot.iconBasePath + "arrow_drop_up.svg"; type: Media.IconData.Heavy }
		arrowForward: Media.IconData { path: _heavyRoot.iconBasePath + "arrow_forward.svg"; type: Media.IconData.Heavy }
		arrowRight: Media.IconData { path: _heavyRoot.iconBasePath + "arrow_right.svg"; type: Media.IconData.Heavy }
		atr: Media.IconData { path: _heavyRoot.iconBasePath + "atr.svg"; type: Media.IconData.Heavy }
		attachMoney: Media.IconData { path: _heavyRoot.iconBasePath + "attach_money.svg"; type: Media.IconData.Heavy }
		autorenew: Media.IconData { path: _heavyRoot.iconBasePath + "autorenew.svg"; type: Media.IconData.Heavy }
		backspace: Media.IconData { path: _heavyRoot.iconBasePath + "backspace.svg"; type: Media.IconData.Heavy }
		badge: Media.IconData { path: _heavyRoot.iconBasePath + "badge.svg"; type: Media.IconData.Heavy }
		barChart: Media.IconData { path: _heavyRoot.iconBasePath + "bar_chart.svg"; type: Media.IconData.Heavy }
		barcodeScanner: Media.IconData { path: _heavyRoot.iconBasePath + "barcode_scanner.svg"; type: Media.IconData.Heavy }
		batteryChargingFull: Media.IconData { path: _heavyRoot.iconBasePath + "battery_charging_full.svg"; type: Media.IconData.Heavy }
		batteryFull: Media.IconData { path: _heavyRoot.iconBasePath + "battery_full.svg"; type: Media.IconData.Heavy }
		batteryFullAlt: Media.IconData { path: _heavyRoot.iconBasePath + "battery_full_alt.svg"; type: Media.IconData.Heavy }
		bluetooth: Media.IconData { path: _heavyRoot.iconBasePath + "bluetooth.svg"; type: Media.IconData.Heavy }
		bookmark: Media.IconData { path: _heavyRoot.iconBasePath + "bookmark.svg"; type: Media.IconData.Heavy }
		brush: Media.IconData { path: _heavyRoot.iconBasePath + "brush.svg"; type: Media.IconData.Heavy }
		build: Media.IconData { path: _heavyRoot.iconBasePath + "build.svg"; type: Media.IconData.Heavy }
		cable: Media.IconData { path: _heavyRoot.iconBasePath + "cable.svg"; type: Media.IconData.Heavy }
		cake: Media.IconData { path: _heavyRoot.iconBasePath + "cake.svg"; type: Media.IconData.Heavy }
		calculate: Media.IconData { path: _heavyRoot.iconBasePath + "calculate.svg"; type: Media.IconData.Heavy }
		calendarMonth: Media.IconData { path: _heavyRoot.iconBasePath + "calendar_month.svg"; type: Media.IconData.Heavy }
		calendarToday: Media.IconData { path: _heavyRoot.iconBasePath + "calendar_today.svg"; type: Media.IconData.Heavy }
		call: Media.IconData { path: _heavyRoot.iconBasePath + "call.svg"; type: Media.IconData.Heavy }
		camera: Media.IconData { path: _heavyRoot.iconBasePath + "camera.svg"; type: Media.IconData.Heavy }
		campaign: Media.IconData { path: _heavyRoot.iconBasePath + "campaign.svg"; type: Media.IconData.Heavy }
		cancel: Media.IconData { path: _heavyRoot.iconBasePath + "cancel.svg"; type: Media.IconData.Heavy }
		cast: Media.IconData { path: _heavyRoot.iconBasePath + "cast.svg"; type: Media.IconData.Heavy }
		category: Media.IconData { path: _heavyRoot.iconBasePath + "category.svg"; type: Media.IconData.Heavy }
		celebration: Media.IconData { path: _heavyRoot.iconBasePath + "celebration.svg"; type: Media.IconData.Heavy }
		chat: Media.IconData { path: _heavyRoot.iconBasePath + "chat.svg"; type: Media.IconData.Heavy }
		chatBubble: Media.IconData { path: _heavyRoot.iconBasePath + "chat_bubble.svg"; type: Media.IconData.Heavy }
		check: Media.IconData { path: _heavyRoot.iconBasePath + "check.svg"; type: Media.IconData.Heavy }
		checkBox: Media.IconData { path: _heavyRoot.iconBasePath + "check_box.svg"; type: Media.IconData.Heavy }
		checkBoxOutlineBlank: Media.IconData { path: _heavyRoot.iconBasePath + "check_box_outline_blank.svg"; type: Media.IconData.Heavy }
		checkCircle: Media.IconData { path: _heavyRoot.iconBasePath + "check_circle.svg"; type: Media.IconData.Heavy }
		chevronLeft: Media.IconData { path: _heavyRoot.iconBasePath + "chevron_left.svg"; type: Media.IconData.Heavy }
		chevronRight: Media.IconData { path: _heavyRoot.iconBasePath + "chevron_right.svg"; type: Media.IconData.Heavy }
		circle: Media.IconData { path: _heavyRoot.iconBasePath + "circle.svg"; type: Media.IconData.Heavy }
		close: Media.IconData { path: _heavyRoot.iconBasePath + "close.svg"; type: Media.IconData.Heavy }
		code: Media.IconData { path: _heavyRoot.iconBasePath + "code.svg"; type: Media.IconData.Heavy }
		computer: Media.IconData { path: _heavyRoot.iconBasePath + "computer.svg"; type: Media.IconData.Heavy }
		construction: Media.IconData { path: _heavyRoot.iconBasePath + "construction.svg"; type: Media.IconData.Heavy }
		contactSupport: Media.IconData { path: _heavyRoot.iconBasePath + "contact_support.svg"; type: Media.IconData.Heavy }
		contentCopy: Media.IconData { path: _heavyRoot.iconBasePath + "content_copy.svg"; type: Media.IconData.Heavy }
		creditCard: Media.IconData { path: _heavyRoot.iconBasePath + "credit_card.svg"; type: Media.IconData.Heavy }
		cropFree: Media.IconData { path: _heavyRoot.iconBasePath + "crop_free.svg"; type: Media.IconData.Heavy }
		currencyBitcoin: Media.IconData { path: _heavyRoot.iconBasePath + "currency_bitcoin.svg"; type: Media.IconData.Heavy }
		darkMode: Media.IconData { path: _heavyRoot.iconBasePath + "dark_mode.svg"; type: Media.IconData.Heavy }
		dashboard: Media.IconData { path: _heavyRoot.iconBasePath + "dashboard.svg"; type: Media.IconData.Heavy }
		database: Media.IconData { path: _heavyRoot.iconBasePath + "database.svg"; type: Media.IconData.Heavy }
		deleteElement: Media.IconData { path: _heavyRoot.iconBasePath + "delete.svg"; type: Media.IconData.Heavy }
		deleteForever: Media.IconData { path: _heavyRoot.iconBasePath + "delete_forever.svg"; type: Media.IconData.Heavy }
		description: Media.IconData { path: _heavyRoot.iconBasePath + "description.svg"; type: Media.IconData.Heavy }
		devices: Media.IconData { path: _heavyRoot.iconBasePath + "devices.svg"; type: Media.IconData.Heavy }
		directionsCar: Media.IconData { path: _heavyRoot.iconBasePath + "directions_car.svg"; type: Media.IconData.Heavy }
		domain: Media.IconData { path: _heavyRoot.iconBasePath + "domain.svg"; type: Media.IconData.Heavy }
		doneAll: Media.IconData { path: _heavyRoot.iconBasePath + "done_all.svg"; type: Media.IconData.Heavy }
		download: Media.IconData { path: _heavyRoot.iconBasePath + "download.svg"; type: Media.IconData.Heavy }
		downloadForOffline: Media.IconData { path: _heavyRoot.iconBasePath + "download_for_offline.svg"; type: Media.IconData.Heavy }
		draw: Media.IconData { path: _heavyRoot.iconBasePath + "draw.svg"; type: Media.IconData.Heavy }
		eco: Media.IconData { path: _heavyRoot.iconBasePath + "eco.svg"; type: Media.IconData.Heavy }
		edit: Media.IconData { path: _heavyRoot.iconBasePath + "edit.svg"; type: Media.IconData.Heavy }
		editNote: Media.IconData { path: _heavyRoot.iconBasePath + "edit_note.svg"; type: Media.IconData.Heavy }
		electricBolt: Media.IconData { path: _heavyRoot.iconBasePath + "electric_bolt.svg"; type: Media.IconData.Heavy }
		emojiObjects: Media.IconData { path: _heavyRoot.iconBasePath + "emoji_objects.svg"; type: Media.IconData.Heavy }
		engineering: Media.IconData { path: _heavyRoot.iconBasePath + "engineering.svg"; type: Media.IconData.Heavy }
		error: Media.IconData { path: _heavyRoot.iconBasePath + "error.svg"; type: Media.IconData.Heavy }
		euro: Media.IconData { path: _heavyRoot.iconBasePath + "euro.svg"; type: Media.IconData.Heavy }
		event: Media.IconData { path: _heavyRoot.iconBasePath + "event.svg"; type: Media.IconData.Heavy }
		explore: Media.IconData { path: _heavyRoot.iconBasePath + "explore.svg"; type: Media.IconData.Heavy }
		extension: Media.IconData { path: _heavyRoot.iconBasePath + "extension.svg"; type: Media.IconData.Heavy }
		familiarFaceAndZone: Media.IconData { path: _heavyRoot.iconBasePath + "familiar_face_and_zone.svg"; type: Media.IconData.Heavy }
		fastForward: Media.IconData { path: _heavyRoot.iconBasePath + "fast_forward.svg"; type: Media.IconData.Heavy }
		fastRewind: Media.IconData { path: _heavyRoot.iconBasePath + "fast_rewind.svg"; type: Media.IconData.Heavy }
		favorite: Media.IconData { path: _heavyRoot.iconBasePath + "favorite.svg"; type: Media.IconData.Heavy }
		fileCopy: Media.IconData { path: _heavyRoot.iconBasePath + "file_copy.svg"; type: Media.IconData.Heavy }
		filterAlt: Media.IconData { path: _heavyRoot.iconBasePath + "filter_alt.svg"; type: Media.IconData.Heavy }
		filterList: Media.IconData { path: _heavyRoot.iconBasePath + "filter_list.svg"; type: Media.IconData.Heavy }
		finance: Media.IconData { path: _heavyRoot.iconBasePath + "finance.svg"; type: Media.IconData.Heavy }
		fingerprint: Media.IconData { path: _heavyRoot.iconBasePath + "fingerprint.svg"; type: Media.IconData.Heavy }
		flag: Media.IconData { path: _heavyRoot.iconBasePath + "flag.svg"; type: Media.IconData.Heavy }
		flashOn: Media.IconData { path: _heavyRoot.iconBasePath + "flash_on.svg"; type: Media.IconData.Heavy }
		flashlightOn: Media.IconData { path: _heavyRoot.iconBasePath + "flashlight_on.svg"; type: Media.IconData.Heavy }
		flight: Media.IconData { path: _heavyRoot.iconBasePath + "flight.svg"; type: Media.IconData.Heavy }
		folder: Media.IconData { path: _heavyRoot.iconBasePath + "folder.svg"; type: Media.IconData.Heavy }
		folderOpen: Media.IconData { path: _heavyRoot.iconBasePath + "folder_open.svg"; type: Media.IconData.Heavy }
		forum: Media.IconData { path: _heavyRoot.iconBasePath + "forum.svg"; type: Media.IconData.Heavy }
		gridOn: Media.IconData { path: _heavyRoot.iconBasePath + "grid_on.svg"; type: Media.IconData.Heavy }
		gridView: Media.IconData { path: _heavyRoot.iconBasePath + "grid_view.svg"; type: Media.IconData.Heavy }
		group: Media.IconData { path: _heavyRoot.iconBasePath + "group.svg"; type: Media.IconData.Heavy }
		groupAdd: Media.IconData { path: _heavyRoot.iconBasePath + "group_add.svg"; type: Media.IconData.Heavy }
		groups: Media.IconData { path: _heavyRoot.iconBasePath + "groups.svg"; type: Media.IconData.Heavy }
		handyman: Media.IconData { path: _heavyRoot.iconBasePath + "handyman.svg"; type: Media.IconData.Heavy }
		headphones: Media.IconData { path: _heavyRoot.iconBasePath + "headphones.svg"; type: Media.IconData.Heavy }
		hearing: Media.IconData { path: _heavyRoot.iconBasePath + "hearing.svg"; type: Media.IconData.Heavy }
		help: Media.IconData { path: _heavyRoot.iconBasePath + "help.svg"; type: Media.IconData.Heavy }
		history: Media.IconData { path: _heavyRoot.iconBasePath + "history.svg"; type: Media.IconData.Heavy }
		home: Media.IconData { path: _heavyRoot.iconBasePath + "home.svg"; type: Media.IconData.Heavy }
		homePin: Media.IconData { path: _heavyRoot.iconBasePath + "home_pin.svg"; type: Media.IconData.Heavy }
		image: Media.IconData { path: _heavyRoot.iconBasePath + "image.svg"; type: Media.IconData.Heavy }
		imagesmode: Media.IconData { path: _heavyRoot.iconBasePath + "imagesmode.svg"; type: Media.IconData.Heavy }
		info: Media.IconData { path: _heavyRoot.iconBasePath + "info.svg"; type: Media.IconData.Heavy }
		inventory: Media.IconData { path: _heavyRoot.iconBasePath + "inventory.svg"; type: Media.IconData.Heavy }
		inventory2: Media.IconData { path: _heavyRoot.iconBasePath + "inventory_2.svg"; type: Media.IconData.Heavy }
		keyboardArrowDown: Media.IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_down.svg"; type: Media.IconData.Heavy }
		keyboardArrowLeft: Media.IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_left.svg"; type: Media.IconData.Heavy }
		keyboardArrowRight: Media.IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_right.svg"; type: Media.IconData.Heavy }
		keyboardArrowUp: Media.IconData { path: _heavyRoot.iconBasePath + "keyboard_arrow_up.svg"; type: Media.IconData.Heavy }
		label: Media.IconData { path: _heavyRoot.iconBasePath + "label.svg"; type: Media.IconData.Heavy }
		landscape: Media.IconData { path: _heavyRoot.iconBasePath + "landscape.svg"; type: Media.IconData.Heavy }
		language: Media.IconData { path: _heavyRoot.iconBasePath + "language.svg"; type: Media.IconData.Heavy }
		leaderboard: Media.IconData { path: _heavyRoot.iconBasePath + "leaderboard.svg"; type: Media.IconData.Heavy }
		lightMode: Media.IconData { path: _heavyRoot.iconBasePath + "light_mode.svg"; type: Media.IconData.Heavy }
		lightbulb: Media.IconData { path: _heavyRoot.iconBasePath + "lightbulb.svg"; type: Media.IconData.Heavy }
		link: Media.IconData { path: _heavyRoot.iconBasePath + "link.svg"; type: Media.IconData.Heavy }
		list: Media.IconData { path: _heavyRoot.iconBasePath + "list.svg"; type: Media.IconData.Heavy }
		localCafe: Media.IconData { path: _heavyRoot.iconBasePath + "local_cafe.svg"; type: Media.IconData.Heavy }
		localMall: Media.IconData { path: _heavyRoot.iconBasePath + "local_mall.svg"; type: Media.IconData.Heavy }
		locationOn: Media.IconData { path: _heavyRoot.iconBasePath + "location_on.svg"; type: Media.IconData.Heavy }
		lock: Media.IconData { path: _heavyRoot.iconBasePath + "lock.svg"; type: Media.IconData.Heavy }
		lockOpen: Media.IconData { path: _heavyRoot.iconBasePath + "lock_open.svg"; type: Media.IconData.Heavy }
		login: Media.IconData { path: _heavyRoot.iconBasePath + "login.svg"; type: Media.IconData.Heavy }
		logout: Media.IconData { path: _heavyRoot.iconBasePath + "logout.svg"; type: Media.IconData.Heavy }
		loyalty: Media.IconData { path: _heavyRoot.iconBasePath + "loyalty.svg"; type: Media.IconData.Heavy }
		mail: Media.IconData { path: _heavyRoot.iconBasePath + "mail.svg"; type: Media.IconData.Heavy }
		manageAccounts: Media.IconData { path: _heavyRoot.iconBasePath + "manage_accounts.svg"; type: Media.IconData.Heavy }
		map: Media.IconData { path: _heavyRoot.iconBasePath + "map.svg"; type: Media.IconData.Heavy }
		menu: Media.IconData { path: _heavyRoot.iconBasePath + "menu.svg"; type: Media.IconData.Heavy }
		mic: Media.IconData { path: _heavyRoot.iconBasePath + "mic.svg"; type: Media.IconData.Heavy }
		modeComment: Media.IconData { path: _heavyRoot.iconBasePath + "mode_comment.svg"; type: Media.IconData.Heavy }
		monitoring: Media.IconData { path: _heavyRoot.iconBasePath + "monitoring.svg"; type: Media.IconData.Heavy }
		moreHoriz: Media.IconData { path: _heavyRoot.iconBasePath + "more_horiz.svg"; type: Media.IconData.Heavy }
		moreVert: Media.IconData { path: _heavyRoot.iconBasePath + "more_vert.svg"; type: Media.IconData.Heavy }
		movie: Media.IconData { path: _heavyRoot.iconBasePath + "movie.svg"; type: Media.IconData.Heavy }
		musicNote: Media.IconData { path: _heavyRoot.iconBasePath + "music_note.svg"; type: Media.IconData.Heavy }
		myLocation: Media.IconData { path: _heavyRoot.iconBasePath + "my_location.svg"; type: Media.IconData.Heavy }
		navigation: Media.IconData { path: _heavyRoot.iconBasePath + "navigation.svg"; type: Media.IconData.Heavy }
		nearMe: Media.IconData { path: _heavyRoot.iconBasePath + "near_me.svg"; type: Media.IconData.Heavy }
		nestEcoLeaf: Media.IconData { path: _heavyRoot.iconBasePath + "nest_eco_leaf.svg"; type: Media.IconData.Heavy }
		nestRemoteComfortSensor: Media.IconData { path: _heavyRoot.iconBasePath + "nest_remote_comfort_sensor.svg"; type: Media.IconData.Heavy }
		nightlight: Media.IconData { path: _heavyRoot.iconBasePath + "nightlight.svg"; type: Media.IconData.Heavy }
		notifications: Media.IconData { path: _heavyRoot.iconBasePath + "notifications.svg"; type: Media.IconData.Heavy }
		openInNew: Media.IconData { path: _heavyRoot.iconBasePath + "open_in_new.svg"; type: Media.IconData.Heavy }
		paid: Media.IconData { path: _heavyRoot.iconBasePath + "paid.svg"; type: Media.IconData.Heavy }
		palette: Media.IconData { path: _heavyRoot.iconBasePath + "palette.svg"; type: Media.IconData.Heavy }
		pause: Media.IconData { path: _heavyRoot.iconBasePath + "pause.svg"; type: Media.IconData.Heavy }
		pauseCircle: Media.IconData { path: _heavyRoot.iconBasePath + "pause_circle.svg"; type: Media.IconData.Heavy }
		person: Media.IconData { path: _heavyRoot.iconBasePath + "person.svg"; type: Media.IconData.Heavy }
		personAdd: Media.IconData { path: _heavyRoot.iconBasePath + "person_add.svg"; type: Media.IconData.Heavy }
		personPin: Media.IconData { path: _heavyRoot.iconBasePath + "person_pin.svg"; type: Media.IconData.Heavy }
		pets: Media.IconData { path: _heavyRoot.iconBasePath + "pets.svg"; type: Media.IconData.Heavy }
		phoneIphone: Media.IconData { path: _heavyRoot.iconBasePath + "phone_iphone.svg"; type: Media.IconData.Heavy }
		photoCamera: Media.IconData { path: _heavyRoot.iconBasePath + "photo_camera.svg"; type: Media.IconData.Heavy }
		photoLibrary: Media.IconData { path: _heavyRoot.iconBasePath + "photo_library.svg"; type: Media.IconData.Heavy }
		pictureAsPdf: Media.IconData { path: _heavyRoot.iconBasePath + "picture_as_pdf.svg"; type: Media.IconData.Heavy }
		pinDrop: Media.IconData { path: _heavyRoot.iconBasePath + "pin_drop.svg"; type: Media.IconData.Heavy }
		playArrow: Media.IconData { path: _heavyRoot.iconBasePath + "play_arrow.svg"; type: Media.IconData.Heavy }
		playCircle: Media.IconData { path: _heavyRoot.iconBasePath + "play_circle.svg"; type: Media.IconData.Heavy }
		power: Media.IconData { path: _heavyRoot.iconBasePath + "power.svg"; type: Media.IconData.Heavy }
		printElement: Media.IconData { path: _heavyRoot.iconBasePath + "print.svg"; type: Media.IconData.Heavy }
		priorityHigh: Media.IconData { path: _heavyRoot.iconBasePath + "priority_high.svg"; type: Media.IconData.Heavy }
		publicElement: Media.IconData { path: _heavyRoot.iconBasePath + "public.svg"; type: Media.IconData.Heavy }
		qrCode: Media.IconData { path: _heavyRoot.iconBasePath + "qr_code.svg"; type: Media.IconData.Heavy }
		qrCode2: Media.IconData { path: _heavyRoot.iconBasePath + "qr_code_2.svg"; type: Media.IconData.Heavy }
		qrCodeScanner: Media.IconData { path: _heavyRoot.iconBasePath + "qr_code_scanner.svg"; type: Media.IconData.Heavy }
		queryStats: Media.IconData { path: _heavyRoot.iconBasePath + "query_stats.svg"; type: Media.IconData.Heavy }
		questionMark: Media.IconData { path: _heavyRoot.iconBasePath + "question_mark.svg"; type: Media.IconData.Heavy }
		radar: Media.IconData { path: _heavyRoot.iconBasePath + "radar.svg"; type: Media.IconData.Heavy }
		refresh: Media.IconData { path: _heavyRoot.iconBasePath + "refresh.svg"; type: Media.IconData.Heavy }
		remove: Media.IconData { path: _heavyRoot.iconBasePath + "remove.svg"; type: Media.IconData.Heavy }
		repeat: Media.IconData { path: _heavyRoot.iconBasePath + "repeat.svg"; type: Media.IconData.Heavy }
		replay: Media.IconData { path: _heavyRoot.iconBasePath + "replay.svg"; type: Media.IconData.Heavy }
		report: Media.IconData { path: _heavyRoot.iconBasePath + "report.svg"; type: Media.IconData.Heavy }
		restartAlt: Media.IconData { path: _heavyRoot.iconBasePath + "restart_alt.svg"; type: Media.IconData.Heavy }
		restaurant: Media.IconData { path: _heavyRoot.iconBasePath + "restaurant.svg"; type: Media.IconData.Heavy }
		restaurantMenu: Media.IconData { path: _heavyRoot.iconBasePath + "restaurant_menu.svg"; type: Media.IconData.Heavy }
		rocketLaunch: Media.IconData { path: _heavyRoot.iconBasePath + "rocket_launch.svg"; type: Media.IconData.Heavy }
		rssFeed: Media.IconData { path: _heavyRoot.iconBasePath + "rss_feed.svg"; type: Media.IconData.Heavy }
		save: Media.IconData { path: _heavyRoot.iconBasePath + "save.svg"; type: Media.IconData.Heavy }
		savings: Media.IconData { path: _heavyRoot.iconBasePath + "savings.svg"; type: Media.IconData.Heavy }
		schedule: Media.IconData { path: _heavyRoot.iconBasePath + "schedule.svg"; type: Media.IconData.Heavy }
		school: Media.IconData { path: _heavyRoot.iconBasePath + "school.svg"; type: Media.IconData.Heavy }
		science: Media.IconData { path: _heavyRoot.iconBasePath + "science.svg"; type: Media.IconData.Heavy }
		search: Media.IconData { path: _heavyRoot.iconBasePath + "search.svg"; type: Media.IconData.Heavy }
		security: Media.IconData { path: _heavyRoot.iconBasePath + "security.svg"; type: Media.IconData.Heavy }
		sell: Media.IconData { path: _heavyRoot.iconBasePath + "sell.svg"; type: Media.IconData.Heavy }
		send: Media.IconData { path: _heavyRoot.iconBasePath + "send.svg"; type: Media.IconData.Heavy }
		settings: Media.IconData { path: _heavyRoot.iconBasePath + "settings.svg"; type: Media.IconData.Heavy }
		share: Media.IconData { path: _heavyRoot.iconBasePath + "share.svg"; type: Media.IconData.Heavy }
		shoppingBag: Media.IconData { path: _heavyRoot.iconBasePath + "shopping_bag.svg"; type: Media.IconData.Heavy }
		shoppingCart: Media.IconData { path: _heavyRoot.iconBasePath + "shopping_cart.svg"; type: Media.IconData.Heavy }
		shuffle: Media.IconData { path: _heavyRoot.iconBasePath + "shuffle.svg"; type: Media.IconData.Heavy }
		signalCellularAlt: Media.IconData { path: _heavyRoot.iconBasePath + "signal_cellular_alt.svg"; type: Media.IconData.Heavy }
		skipNext: Media.IconData { path: _heavyRoot.iconBasePath + "skip_next.svg"; type: Media.IconData.Heavy }
		skipPrevious: Media.IconData { path: _heavyRoot.iconBasePath + "skip_previous.svg"; type: Media.IconData.Heavy }
		smartphone: Media.IconData { path: _heavyRoot.iconBasePath + "smartphone.svg"; type: Media.IconData.Heavy }
		sort: Media.IconData { path: _heavyRoot.iconBasePath + "sort.svg"; type: Media.IconData.Heavy }
		sportsEsports: Media.IconData { path: _heavyRoot.iconBasePath + "sports_esports.svg"; type: Media.IconData.Heavy }
		sportsSoccer: Media.IconData { path: _heavyRoot.iconBasePath + "sports_soccer.svg"; type: Media.IconData.Heavy }
		stadiaController: Media.IconData { path: _heavyRoot.iconBasePath + "stadia_controller.svg"; type: Media.IconData.Heavy }
		star: Media.IconData { path: _heavyRoot.iconBasePath + "star.svg"; type: Media.IconData.Heavy }
		stop: Media.IconData { path: _heavyRoot.iconBasePath + "stop.svg"; type: Media.IconData.Heavy }
		stopCircle: Media.IconData { path: _heavyRoot.iconBasePath + "stop_circle.svg"; type: Media.IconData.Heavy }
		storage: Media.IconData { path: _heavyRoot.iconBasePath + "storage.svg"; type: Media.IconData.Heavy }
		store: Media.IconData { path: _heavyRoot.iconBasePath + "store.svg"; type: Media.IconData.Heavy }
		storefront: Media.IconData { path: _heavyRoot.iconBasePath + "storefront.svg"; type: Media.IconData.Heavy }
		subscriptions: Media.IconData { path: _heavyRoot.iconBasePath + "subscriptions.svg"; type: Media.IconData.Heavy }
		sync: Media.IconData { path: _heavyRoot.iconBasePath + "sync.svg"; type: Media.IconData.Heavy }
		taskAlt: Media.IconData { path: _heavyRoot.iconBasePath + "task_alt.svg"; type: Media.IconData.Heavy }
		theaters: Media.IconData { path: _heavyRoot.iconBasePath + "theaters.svg"; type: Media.IconData.Heavy }
		thumbUp: Media.IconData { path: _heavyRoot.iconBasePath + "thumb_up.svg"; type: Media.IconData.Heavy }
		timeline: Media.IconData { path: _heavyRoot.iconBasePath + "timeline.svg"; type: Media.IconData.Heavy }
		timer: Media.IconData { path: _heavyRoot.iconBasePath + "timer.svg"; type: Media.IconData.Heavy }
		touchApp: Media.IconData { path: _heavyRoot.iconBasePath + "touch_app.svg"; type: Media.IconData.Heavy }
		trendingDown: Media.IconData { path: _heavyRoot.iconBasePath + "trending_down.svg"; type: Media.IconData.Heavy }
		trendingUp: Media.IconData { path: _heavyRoot.iconBasePath + "trending_up.svg"; type: Media.IconData.Heavy }
		tune: Media.IconData { path: _heavyRoot.iconBasePath + "tune.svg"; type: Media.IconData.Heavy }
		undo: Media.IconData { path: _heavyRoot.iconBasePath + "undo.svg"; type: Media.IconData.Heavy }
		update: Media.IconData { path: _heavyRoot.iconBasePath + "update.svg"; type: Media.IconData.Heavy }
		uploadFile: Media.IconData { path: _heavyRoot.iconBasePath + "upload_file.svg"; type: Media.IconData.Heavy }
		usb: Media.IconData { path: _heavyRoot.iconBasePath + "usb.svg"; type: Media.IconData.Heavy }
		verified: Media.IconData { path: _heavyRoot.iconBasePath + "verified.svg"; type: Media.IconData.Heavy }
		verifiedUser: Media.IconData { path: _heavyRoot.iconBasePath + "verified_user.svg"; type: Media.IconData.Heavy }
		videoLibrary: Media.IconData { path: _heavyRoot.iconBasePath + "video_library.svg"; type: Media.IconData.Heavy }
		videocam: Media.IconData { path: _heavyRoot.iconBasePath + "videocam.svg"; type: Media.IconData.Heavy }
		visibility: Media.IconData { path: _heavyRoot.iconBasePath + "visibility.svg"; type: Media.IconData.Heavy }
		visibilityOff: Media.IconData { path: _heavyRoot.iconBasePath + "visibility_off.svg"; type: Media.IconData.Heavy }
		volumeOff: Media.IconData { path: _heavyRoot.iconBasePath + "volume_off.svg"; type: Media.IconData.Heavy }
		volumeUp: Media.IconData { path: _heavyRoot.iconBasePath + "volume_up.svg"; type: Media.IconData.Heavy }
		wallet: Media.IconData { path: _heavyRoot.iconBasePath + "wallet.svg"; type: Media.IconData.Heavy }
		wallpaper: Media.IconData { path: _heavyRoot.iconBasePath + "wallpaper.svg"; type: Media.IconData.Heavy }
		warning: Media.IconData { path: _heavyRoot.iconBasePath + "warning.svg"; type: Media.IconData.Heavy }
		wbSunny: Media.IconData { path: _heavyRoot.iconBasePath + "wb_sunny.svg"; type: Media.IconData.Heavy }
		whereToVote: Media.IconData { path: _heavyRoot.iconBasePath + "where_to_vote.svg"; type: Media.IconData.Heavy }
		widgets: Media.IconData { path: _heavyRoot.iconBasePath + "widgets.svg"; type: Media.IconData.Heavy }
		wifi: Media.IconData { path: _heavyRoot.iconBasePath + "wifi.svg"; type: Media.IconData.Heavy }
		wifiOff: Media.IconData { path: _heavyRoot.iconBasePath + "wifi_off.svg"; type: Media.IconData.Heavy }
		work: Media.IconData { path: _heavyRoot.iconBasePath + "work.svg"; type: Media.IconData.Heavy }
		dashedCircle: Media.IconData { path: _heavyRoot.iconBasePath + "dashedCircle.svg"; type: Media.IconData.Heavy }
		colorize: Media.IconData { path: _heavyRoot.iconBasePath + "colorize.svg"; type: Media.IconData.Heavy }
    }

	readonly property Media.IconSet light: Media.IconSet {
		inventory2: Media.IconData { path: '\ue900'; type: Media.IconData.Light }
		keyboardArrowDown: Media.IconData { path: '\ue901'; type: Media.IconData.Light }
		keyboardArrowLeft: Media.IconData { path: '\ue902'; type: Media.IconData.Light }
		keyboardArrowRight: Media.IconData { path: '\ue903'; type: Media.IconData.Light }
		keyboardArrowUp: Media.IconData { path: '\ue904'; type: Media.IconData.Light }
		label: Media.IconData { path: '\ue905'; type: Media.IconData.Light }
		landscape: Media.IconData { path: '\ue906'; type: Media.IconData.Light }
		language: Media.IconData { path: '\ue907'; type: Media.IconData.Light }
		leaderboard: Media.IconData { path: '\ue908'; type: Media.IconData.Light }
		lightMode: Media.IconData { path: '\ue909'; type: Media.IconData.Light }
		lightbulb: Media.IconData { path: '\ue90a'; type: Media.IconData.Light }
		link: Media.IconData { path: '\ue90b'; type: Media.IconData.Light }
		list: Media.IconData { path: '\ue90c'; type: Media.IconData.Light }
		localCafe: Media.IconData { path: '\ue90d'; type: Media.IconData.Light }
		localMall: Media.IconData { path: '\ue90e'; type: Media.IconData.Light }
		locationOn: Media.IconData { path: '\ue90f'; type: Media.IconData.Light }
		lock: Media.IconData { path: '\ue910'; type: Media.IconData.Light }
		lockOpen: Media.IconData { path: '\ue911'; type: Media.IconData.Light }
		login: Media.IconData { path: '\ue912'; type: Media.IconData.Light }
		logout: Media.IconData { path: '\ue913'; type: Media.IconData.Light }
		loyalty: Media.IconData { path: '\ue914'; type: Media.IconData.Light }
		mail: Media.IconData { path: '\ue915'; type: Media.IconData.Light }
		manageAccounts: Media.IconData { path: '\ue916'; type: Media.IconData.Light }
		map: Media.IconData { path: '\ue917'; type: Media.IconData.Light }
		menu: Media.IconData { path: '\ue918'; type: Media.IconData.Light }
		mic: Media.IconData { path: '\ue919'; type: Media.IconData.Light }
		modeComment: Media.IconData { path: '\ue91a'; type: Media.IconData.Light }
		monitoring: Media.IconData { path: '\ue91b'; type: Media.IconData.Light }
		moreHoriz: Media.IconData { path: '\ue91c'; type: Media.IconData.Light }
		moreVert: Media.IconData { path: '\ue91d'; type: Media.IconData.Light }
		movie: Media.IconData { path: '\ue91e'; type: Media.IconData.Light }
		musicNote: Media.IconData { path: '\ue91f'; type: Media.IconData.Light }
		myLocation: Media.IconData { path: '\ue920'; type: Media.IconData.Light }
		navigation: Media.IconData { path: '\ue921'; type: Media.IconData.Light }
		nearMe: Media.IconData { path: '\ue922'; type: Media.IconData.Light }
		nestEcoLeaf: Media.IconData { path: '\ue923'; type: Media.IconData.Light }
		nestRemoteComfortSensor: Media.IconData { path: '\ue924'; type: Media.IconData.Light }
		nightlight: Media.IconData { path: '\ue925'; type: Media.IconData.Light }
		notifications: Media.IconData { path: '\ue926'; type: Media.IconData.Light }
		openInNew: Media.IconData { path: '\ue927'; type: Media.IconData.Light }
		paid: Media.IconData { path: '\ue928'; type: Media.IconData.Light }
		palette: Media.IconData { path: '\ue929'; type: Media.IconData.Light }
		pause: Media.IconData { path: '\ue92a'; type: Media.IconData.Light }
		pauseCircle: Media.IconData { path: '\ue92b'; type: Media.IconData.Light }
		person: Media.IconData { path: '\ue92c'; type: Media.IconData.Light }
		personAdd: Media.IconData { path: '\ue92d'; type: Media.IconData.Light }
		personPin: Media.IconData { path: '\ue92e'; type: Media.IconData.Light }
		pets: Media.IconData { path: '\ue92f'; type: Media.IconData.Light }
		phoneIphone: Media.IconData { path: '\ue930'; type: Media.IconData.Light }
		photoCamera: Media.IconData { path: '\ue931'; type: Media.IconData.Light }
		photoLibrary: Media.IconData { path: '\ue932'; type: Media.IconData.Light }
		pictureAsPdf: Media.IconData { path: '\ue933'; type: Media.IconData.Light }
		pinDrop: Media.IconData { path: '\ue934'; type: Media.IconData.Light }
		playArrow: Media.IconData { path: '\ue935'; type: Media.IconData.Light }
		playCircle: Media.IconData { path: '\ue936'; type: Media.IconData.Light }
		power: Media.IconData { path: '\ue937'; type: Media.IconData.Light }
		printElement: Media.IconData { path: '\ue938'; type: Media.IconData.Light }
		priorityHigh: Media.IconData { path: '\ue939'; type: Media.IconData.Light }
		publicElement: Media.IconData { path: '\ue93a'; type: Media.IconData.Light }
		qrCode: Media.IconData { path: '\ue93b'; type: Media.IconData.Light }
		qrCode2: Media.IconData { path: '\ue93c'; type: Media.IconData.Light }
		qrCodeScanner: Media.IconData { path: '\ue93d'; type: Media.IconData.Light }
		queryStats: Media.IconData { path: '\ue93e'; type: Media.IconData.Light }
		questionMark: Media.IconData { path: '\ue93f'; type: Media.IconData.Light }
		radar: Media.IconData { path: '\ue940'; type: Media.IconData.Light }
		refresh: Media.IconData { path: '\ue941'; type: Media.IconData.Light }
		remove: Media.IconData { path: '\ue942'; type: Media.IconData.Light }
		repeat: Media.IconData { path: '\ue943'; type: Media.IconData.Light }
		replay: Media.IconData { path: '\ue944'; type: Media.IconData.Light }
		report: Media.IconData { path: '\ue945'; type: Media.IconData.Light }
		restartAlt: Media.IconData { path: '\ue946'; type: Media.IconData.Light }
		restaurant: Media.IconData { path: '\ue947'; type: Media.IconData.Light }
		restaurantMenu: Media.IconData { path: '\ue948'; type: Media.IconData.Light }
		rocketLaunch: Media.IconData { path: '\ue949'; type: Media.IconData.Light }
		rssFeed: Media.IconData { path: '\ue94a'; type: Media.IconData.Light }
		save: Media.IconData { path: '\ue94b'; type: Media.IconData.Light }
		savings: Media.IconData { path: '\ue94c'; type: Media.IconData.Light }
		schedule: Media.IconData { path: '\ue94d'; type: Media.IconData.Light }
		school: Media.IconData { path: '\ue94e'; type: Media.IconData.Light }
		science: Media.IconData { path: '\ue94f'; type: Media.IconData.Light }
		search: Media.IconData { path: '\ue950'; type: Media.IconData.Light }
		security: Media.IconData { path: '\ue951'; type: Media.IconData.Light }
		sell: Media.IconData { path: '\ue952'; type: Media.IconData.Light }
		send: Media.IconData { path: '\ue953'; type: Media.IconData.Light }
		settings: Media.IconData { path: '\ue954'; type: Media.IconData.Light }
		share: Media.IconData { path: '\ue955'; type: Media.IconData.Light }
		shoppingBag: Media.IconData { path: '\ue956'; type: Media.IconData.Light }
		shoppingCart: Media.IconData { path: '\ue957'; type: Media.IconData.Light }
		shuffle: Media.IconData { path: '\ue958'; type: Media.IconData.Light }
		signalCellularAlt: Media.IconData { path: '\ue959'; type: Media.IconData.Light }
		skipNext: Media.IconData { path: '\ue95a'; type: Media.IconData.Light }
		skipPrevious: Media.IconData { path: '\ue95b'; type: Media.IconData.Light }
		smartphone: Media.IconData { path: '\ue95c'; type: Media.IconData.Light }
		sort: Media.IconData { path: '\ue95d'; type: Media.IconData.Light }
		sportsEsports: Media.IconData { path: '\ue95e'; type: Media.IconData.Light }
		sportsSoccer: Media.IconData { path: '\ue95f'; type: Media.IconData.Light }
		stadiaController: Media.IconData { path: '\ue960'; type: Media.IconData.Light }
		star: Media.IconData { path: '\ue961'; type: Media.IconData.Light }
		stop: Media.IconData { path: '\ue962'; type: Media.IconData.Light }
		stopCircle: Media.IconData { path: '\ue963'; type: Media.IconData.Light }
		storage: Media.IconData { path: '\ue964'; type: Media.IconData.Light }
		store: Media.IconData { path: '\ue965'; type: Media.IconData.Light }
		storefront: Media.IconData { path: '\ue966'; type: Media.IconData.Light }
		subscriptions: Media.IconData { path: '\ue967'; type: Media.IconData.Light }
		sync: Media.IconData { path: '\ue968'; type: Media.IconData.Light }
		taskAlt: Media.IconData { path: '\ue969'; type: Media.IconData.Light }
		theaters: Media.IconData { path: '\ue96a'; type: Media.IconData.Light }
		thumbUp: Media.IconData { path: '\ue96b'; type: Media.IconData.Light }
		timeline: Media.IconData { path: '\ue96c'; type: Media.IconData.Light }
		timer: Media.IconData { path: '\ue96d'; type: Media.IconData.Light }
		touchApp: Media.IconData { path: '\ue96e'; type: Media.IconData.Light }
		trendingDown: Media.IconData { path: '\ue96f'; type: Media.IconData.Light }
		trendingUp: Media.IconData { path: '\ue970'; type: Media.IconData.Light }
		tune: Media.IconData { path: '\ue971'; type: Media.IconData.Light }
		undo: Media.IconData { path: '\ue972'; type: Media.IconData.Light }
		update: Media.IconData { path: '\ue973'; type: Media.IconData.Light }
		uploadFile: Media.IconData { path: '\ue974'; type: Media.IconData.Light }
		usb: Media.IconData { path: '\ue975'; type: Media.IconData.Light }
		verified: Media.IconData { path: '\ue976'; type: Media.IconData.Light }
		verifiedUser: Media.IconData { path: '\ue977'; type: Media.IconData.Light }
		videoLibrary: Media.IconData { path: '\ue978'; type: Media.IconData.Light }
		videocam: Media.IconData { path: '\ue979'; type: Media.IconData.Light }
		visibility: Media.IconData { path: '\ue97a'; type: Media.IconData.Light }
		visibilityOff: Media.IconData { path: '\ue97b'; type: Media.IconData.Light }
		volumeOff: Media.IconData { path: '\ue97c'; type: Media.IconData.Light }
		volumeUp: Media.IconData { path: '\ue97d'; type: Media.IconData.Light }
		wallet: Media.IconData { path: '\ue97e'; type: Media.IconData.Light }
		wallpaper: Media.IconData { path: '\ue97f'; type: Media.IconData.Light }
		warning: Media.IconData { path: '\ue980'; type: Media.IconData.Light }
		wbSunny: Media.IconData { path: '\ue981'; type: Media.IconData.Light }
		whereToVote: Media.IconData { path: '\ue982'; type: Media.IconData.Light }
		widgets: Media.IconData { path: '\ue983'; type: Media.IconData.Light }
		wifi: Media.IconData { path: '\ue984'; type: Media.IconData.Light }
		wifiOff: Media.IconData { path: '\ue985'; type: Media.IconData.Light }
		work: Media.IconData { path: '\ue986'; type: Media.IconData.Light }
		accountBalance: Media.IconData { path: '\ue987'; type: Media.IconData.Light }
		accountBox: Media.IconData { path: '\ue988'; type: Media.IconData.Light }
		accountCircle: Media.IconData { path: '\ue989'; type: Media.IconData.Light }
		adb: Media.IconData { path: '\ue98a'; type: Media.IconData.Light }
		add: Media.IconData { path: '\ue98b'; type: Media.IconData.Light }
		addAPhoto: Media.IconData { path: '\ue98c'; type: Media.IconData.Light }
		addBox: Media.IconData { path: '\ue98d'; type: Media.IconData.Light }
		addBusiness: Media.IconData { path: '\ue98e'; type: Media.IconData.Light }
		addCard: Media.IconData { path: '\ue98f'; type: Media.IconData.Light }
		addCircle: Media.IconData { path: '\ue990'; type: Media.IconData.Light }
		addPhotoAlternate: Media.IconData { path: '\ue991'; type: Media.IconData.Light }
		addShoppingCart: Media.IconData { path: '\ue992'; type: Media.IconData.Light }
		air: Media.IconData { path: '\ue993'; type: Media.IconData.Light }
		alarm: Media.IconData { path: '\ue994'; type: Media.IconData.Light }
		analytics: Media.IconData { path: '\ue995'; type: Media.IconData.Light }
		android: Media.IconData { path: '\ue996'; type: Media.IconData.Light }
		apps: Media.IconData { path: '\ue997'; type: Media.IconData.Light }
		arrowBack: Media.IconData { path: '\ue998'; type: Media.IconData.Light }
		arrowDownward: Media.IconData { path: '\ue999'; type: Media.IconData.Light }
		arrowDropDown: Media.IconData { path: '\ue99a'; type: Media.IconData.Light }
		arrowDropUp: Media.IconData { path: '\ue99b'; type: Media.IconData.Light }
		arrowForward: Media.IconData { path: '\ue99c'; type: Media.IconData.Light }
		arrowRight: Media.IconData { path: '\ue99d'; type: Media.IconData.Light }
		atr: Media.IconData { path: '\ue99e'; type: Media.IconData.Light }
		attachMoney: Media.IconData { path: '\ue99f'; type: Media.IconData.Light }
		autorenew: Media.IconData { path: '\ue9a0'; type: Media.IconData.Light }
		backspace: Media.IconData { path: '\ue9a1'; type: Media.IconData.Light }
		badge: Media.IconData { path: '\ue9a2'; type: Media.IconData.Light }
		barChart: Media.IconData { path: '\ue9a3'; type: Media.IconData.Light }
		barcodeScanner: Media.IconData { path: '\ue9a4'; type: Media.IconData.Light }
		batteryChargingFull: Media.IconData { path: '\ue9a5'; type: Media.IconData.Light }
		batteryFull: Media.IconData { path: '\ue9a6'; type: Media.IconData.Light }
		batteryFullAlt: Media.IconData { path: '\ue9a7'; type: Media.IconData.Light }
		bluetooth: Media.IconData { path: '\ue9a8'; type: Media.IconData.Light }
		bookmark: Media.IconData { path: '\ue9a9'; type: Media.IconData.Light }
		brush: Media.IconData { path: '\ue9aa'; type: Media.IconData.Light }
		build: Media.IconData { path: '\ue9ab'; type: Media.IconData.Light }
		cable: Media.IconData { path: '\ue9ac'; type: Media.IconData.Light }
		cake: Media.IconData { path: '\ue9ad'; type: Media.IconData.Light }
		calculate: Media.IconData { path: '\ue9ae'; type: Media.IconData.Light }
		calendarMonth: Media.IconData { path: '\ue9af'; type: Media.IconData.Light }
		calendarToday: Media.IconData { path: '\ue9b0'; type: Media.IconData.Light }
		call: Media.IconData { path: '\ue9b1'; type: Media.IconData.Light }
		camera: Media.IconData { path: '\ue9b2'; type: Media.IconData.Light }
		campaign: Media.IconData { path: '\ue9b3'; type: Media.IconData.Light }
		cancel: Media.IconData { path: '\ue9b4'; type: Media.IconData.Light }
		cast: Media.IconData { path: '\ue9b5'; type: Media.IconData.Light }
		category: Media.IconData { path: '\ue9b6'; type: Media.IconData.Light }
		celebration: Media.IconData { path: '\ue9b7'; type: Media.IconData.Light }
		chat: Media.IconData { path: '\ue9b8'; type: Media.IconData.Light }
		chatBubble: Media.IconData { path: '\ue9b9'; type: Media.IconData.Light }
		check: Media.IconData { path: '\ue9ba'; type: Media.IconData.Light }
		checkBox: Media.IconData { path: '\ue9bb'; type: Media.IconData.Light }
		checkBoxOutlineBlank: Media.IconData { path: '\ue9bc'; type: Media.IconData.Light }
		checkCircle: Media.IconData { path: '\ue9bd'; type: Media.IconData.Light }
		chevronLeft: Media.IconData { path: '\ue9be'; type: Media.IconData.Light }
		chevronRight: Media.IconData { path: '\ue9bf'; type: Media.IconData.Light }
		circle: Media.IconData { path: '\ue9c0'; type: Media.IconData.Light }
		close: Media.IconData { path: '\ue9c1'; type: Media.IconData.Light }
		code: Media.IconData { path: '\ue9c2'; type: Media.IconData.Light }
		computer: Media.IconData { path: '\ue9c3'; type: Media.IconData.Light }
		construction: Media.IconData { path: '\ue9c4'; type: Media.IconData.Light }
		contactSupport: Media.IconData { path: '\ue9c5'; type: Media.IconData.Light }
		contentCopy: Media.IconData { path: '\ue9c6'; type: Media.IconData.Light }
		creditCard: Media.IconData { path: '\ue9c7'; type: Media.IconData.Light }
		cropFree: Media.IconData { path: '\ue9c8'; type: Media.IconData.Light }
		currencyBitcoin: Media.IconData { path: '\ue9c9'; type: Media.IconData.Light }
		darkMode: Media.IconData { path: '\ue9ca'; type: Media.IconData.Light }
		dashboard: Media.IconData { path: '\ue9cb'; type: Media.IconData.Light }
		database: Media.IconData { path: '\ue9cc'; type: Media.IconData.Light }
		deleteElement: Media.IconData { path: '\ue9cd'; type: Media.IconData.Light }
		deleteForever: Media.IconData { path: '\ue9ce'; type: Media.IconData.Light }
		description: Media.IconData { path: '\ue9cf'; type: Media.IconData.Light }
		devices: Media.IconData { path: '\ue9d0'; type: Media.IconData.Light }
		directionsCar: Media.IconData { path: '\ue9d1'; type: Media.IconData.Light }
		domain: Media.IconData { path: '\ue9d2'; type: Media.IconData.Light }
		doneAll: Media.IconData { path: '\ue9d3'; type: Media.IconData.Light }
		download: Media.IconData { path: '\ue9d4'; type: Media.IconData.Light }
		downloadForOffline: Media.IconData { path: '\ue9d5'; type: Media.IconData.Light }
		draw: Media.IconData { path: '\ue9d6'; type: Media.IconData.Light }
		eco: Media.IconData { path: '\ue9d7'; type: Media.IconData.Light }
		edit: Media.IconData { path: '\ue9d8'; type: Media.IconData.Light }
		editNote: Media.IconData { path: '\ue9d9'; type: Media.IconData.Light }
		electricBolt: Media.IconData { path: '\ue9da'; type: Media.IconData.Light }
		emojiObjects: Media.IconData { path: '\ue9db'; type: Media.IconData.Light }
		engineering: Media.IconData { path: '\ue9dc'; type: Media.IconData.Light }
		error: Media.IconData { path: '\ue9dd'; type: Media.IconData.Light }
		euro: Media.IconData { path: '\ue9de'; type: Media.IconData.Light }
		event: Media.IconData { path: '\ue9df'; type: Media.IconData.Light }
		explore: Media.IconData { path: '\ue9e0'; type: Media.IconData.Light }
		extension: Media.IconData { path: '\ue9e1'; type: Media.IconData.Light }
		familiarFaceAndZone: Media.IconData { path: '\ue9e2'; type: Media.IconData.Light }
		fastForward: Media.IconData { path: '\ue9e3'; type: Media.IconData.Light }
		fastRewind: Media.IconData { path: '\ue9e4'; type: Media.IconData.Light }
		favorite: Media.IconData { path: '\ue9e5'; type: Media.IconData.Light }
		fileCopy: Media.IconData { path: '\ue9e6'; type: Media.IconData.Light }
		filterAlt: Media.IconData { path: '\ue9e7'; type: Media.IconData.Light }
		filterList: Media.IconData { path: '\ue9e8'; type: Media.IconData.Light }
		finance: Media.IconData { path: '\ue9e9'; type: Media.IconData.Light }
		fingerprint: Media.IconData { path: '\ue9ea'; type: Media.IconData.Light }
		flag: Media.IconData { path: '\ue9eb'; type: Media.IconData.Light }
		flashOn: Media.IconData { path: '\ue9ec'; type: Media.IconData.Light }
		flashlightOn: Media.IconData { path: '\ue9ed'; type: Media.IconData.Light }
		flight: Media.IconData { path: '\ue9ee'; type: Media.IconData.Light }
		folder: Media.IconData { path: '\ue9ef'; type: Media.IconData.Light }
		folderOpen: Media.IconData { path: '\ue9f0'; type: Media.IconData.Light }
		forum: Media.IconData { path: '\ue9f1'; type: Media.IconData.Light }
		gridOn: Media.IconData { path: '\ue9f2'; type: Media.IconData.Light }
		gridView: Media.IconData { path: '\ue9f3'; type: Media.IconData.Light }
		group: Media.IconData { path: '\ue9f4'; type: Media.IconData.Light }
		groupAdd: Media.IconData { path: '\ue9f5'; type: Media.IconData.Light }
		groups: Media.IconData { path: '\ue9f6'; type: Media.IconData.Light }
		handyman: Media.IconData { path: '\ue9f7'; type: Media.IconData.Light }
		headphones: Media.IconData { path: '\ue9f8'; type: Media.IconData.Light }
		hearing: Media.IconData { path: '\ue9f9'; type: Media.IconData.Light }
		help: Media.IconData { path: '\ue9fa'; type: Media.IconData.Light }
		history: Media.IconData { path: '\ue9fb'; type: Media.IconData.Light }
		home: Media.IconData { path: '\ue9fc'; type: Media.IconData.Light }
		homePin: Media.IconData { path: '\ue9fd'; type: Media.IconData.Light }
		image: Media.IconData { path: '\ue9fe'; type: Media.IconData.Light }
		imagesmode: Media.IconData { path: '\ue9ff'; type: Media.IconData.Light }
		info: Media.IconData { path: '\uea00'; type: Media.IconData.Light }
		inventory: Media.IconData { path: '\uea01'; type: Media.IconData.Light }
		colorize: Media.IconData { path: '\uea02'; type: Media.IconData.Light }
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
}
