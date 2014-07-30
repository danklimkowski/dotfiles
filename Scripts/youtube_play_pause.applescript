# Play or pause a video.
set myjs to "
var player =
  document.getElementById('movie_player') ||
  document.getElementsByTagName('embed')[0] ||
  document.getElementById('player1') ||
  document.getElementById('archive_site_player_flash');

if (player) {
  if (player.getPlayerState && player.getPlayerState() === 1 ||
      player.isPaused && !player.isPaused()) {
    player.pauseVideo();
  } else {
    player.playVideo();
  }
}
"

tell application "Google Chrome"
  tell active tab of front window
    set cmd to "echo \"" & URL & "\" | sed -E \"s/https?:\\/\\/www\\.(youtube\\.com\\/(watch|embed)|twitch\\.tv\\/[a-zA-Z0-9_]+\\/c\\/[0-9]+)/*good*(&)/\"" as string
    set result to do shell script cmd
    if result starts with "*good*" then
      execute javascript myjs
      return
    end if
  end tell

  repeat with win in windows
    tell active tab of win
      set cmd to "echo \"" & URL & "\" | sed -E \"s/https?:\\/\\/www\\.(youtube\\.com\\/(watch|embed)|twitch\\.tv\\/[a-zA-Z0-9_]+\\/c\\/[0-9]+)/*good*(&)/\"" as string
      set result to do shell script cmd
      if result starts with "*good*" then
        execute javascript myjs
        return
      end if
    end tell
  end repeat

  repeat with t in tabs of windows
    tell t
      set cmd to "echo \"" & URL & "\" | sed -E \"s/https?:\\/\\/www\\.(youtube\\.com\\/(watch|embed)|twitch\\.tv\\/[a-zA-Z0-9_]+\\/c\\/[0-9]+)/*good*(&)/\"" as string
      set result to do shell script cmd
      if result starts with "*good*" then
        execute javascript myjs
        exit repeat
      end if
    end tell
  end repeat
end tell
