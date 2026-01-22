case $@ in
"Finder" | "访达")
	icon_result=":finder:"
	;;
"GitHub")
	icon_result=":git_hub:"
	;;
"Zed")
	icon_result=":zed:"
	;;
"Goodnotes")
	icon_result=":notability:"
	;;
"便笺")
	icon_result=":reminders:"
	;;
"OrbStack")
	icon_result=":docker:"
	;;
"LocalSend")
	icon_result=":localsend:"
	;;
"Plex")
	icon_result=":playing:"
	;;
"照片")
	icon_result=":affinity_photo_2:"
	;;
"licecap")
	icon_result=":camera:"
	;;
"Final Cut Pro")
	icon_result=":final_cut_pro:"
	;;
"FaceTime通话" | "TencentMeeting")
	icon_result=":face_time:"
	;;
"Messages" | "Nachrichten")
	icon_result=":messages:"
	;;
"Tweetbot" | "Twitter")
	icon_result=":twitter:"
	;;
"Microsoft Edge")
	icon_result=":microsoft_edge:"
	;;
"Notes" | "massCode" | "备忘录")
	icon_result=":notes:"
	;;
"Microsoft To Do" | "Things")
	icon_result=":things:"
	;;
"GitHub Desktop")
	icon_result=":git_hub:"
	;;
"App Store")
	icon_result=":app_store:"
	;;
"Chromium" | "Google Chrome" | "Google Chrome Canary")
	icon_result=":google_chrome:"
	;;
"zoom.us")
	icon_result=":zoom:"
	;;
"Color Picker")
	icon_result=":color_picker:"
	;;
"Microsoft Word")
	icon_result=":microsoft_word:"
	;;
# "Microsoft Teams")
# 	icon_result=":microsoft_teams:"
# 	;;
"Neovide" | "MacVim" | "Vim" | "VimR")
	icon_result=":vim:"
	;;
"OBS")
	icon_result=":obsstudio:"
	;;
"Microsoft Excel")
	icon_result=":microsoft_excel:"
	;;
"Microsoft PowerPoint")
	icon_result=":microsoft_power_point:"
	;;
"Matlab")
	icon_result=":matlab:"
	;;
"Numbers")
	icon_result=":numbers:"
	;;
"Default")
	icon_result=":default:"
	;;
"Notion")
	icon_result=":notion:"
	;;
"Calendar" | "Fantastical" | "日历")
	icon_result=":calendar:"
	;;
"Android Studio")
	icon_result=":android_studio:"
	;;
"Xcode")
	icon_result=":xcode:"
	;;
"System Preferences" | "System Settings" | "系统设置" | "字体册")
	icon_result=":gear:"
	;;
"Firefox")
	icon_result=":firefox:"
	;;
"Dropbox")
	icon_result=":dropbox:"
	;;
"微信" | "WeChat")
	icon_result=":wechat:"
	;;
"QQ")
	icon_result=":qq:"
	;;
"Typora")
	icon_result=":text:"
	;;
"Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "邮件" | "Outlook")
	icon_result=":mail:"
	;;
"Safari" | "Safari Technology Preview" | "力扣" | "DeepSeek")
	icon_result=":safari:"
	;;
"Telegram")
	icon_result=":telegram:"
	;;
"Keynote")
	icon_result=":keynote:"
	;;
"Spotlight")
	icon_result=":spotlight:"
	;;
"Music" | "NetEaseMusic" | "音乐")
	icon_result=":music:"
	;;
"Pages")
	icon_result=":pages:"
	;;
"mpv")
	icon_result=":mpv:"
	;;
"网易云音乐")
	icon_result=":netease_music:"
	;;
"Affinity Designer")
	icon_result=":affinity_designer:"
	;;
"IntelliJ IDEA")
	icon_result=":idea:"
	;;
"Obsidian")
	icon_result=":obsidian:"
	;;
"Microsoft Remote Desktop")
	icon_result=":microsoft_remote_desktop:"
	;;
"zotero" | "Zotero")
	icon_result=":zotero:"
	;;
"Todoist" | "提醒事项")
	icon_result=":omni_focus:"
	;;
"Reminders")
	icon_result=":reminders:"
	;;
"Preview" | "Skim" | "zathura" | "sioyek" | "预览")
	icon_result=":pdf:"
	;;
"Code" | "Code - Insiders")
	icon_result=":code:"
	;;
"calibre" | "图书")
	icon_result=":book:"
	;;
"播客")
	icon_result=":podcasts:"
	;;
"Termius")
	icon_result=":terminal:"
	;;
# "Alacritty" | "Hyper" | "kitty" | "Terminal" | "iTerm" | "iTerm2")
# 	icon_result=":terminal:"
# 	;;
"VidHub")
	icon_result=":jellyfin:"
	;;
*)
	icon_result=""
	;;
esac
echo $icon_result
