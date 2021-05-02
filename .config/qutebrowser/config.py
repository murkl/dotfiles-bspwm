from qutebrowser.mainwindow import tabwidget

# Load GUI Settings
#######################################################
config.load_autoconfig(True)

# Colors
#######################################################
config.source('colors.py')

# Fonts
#######################################################
c.fonts.default_size = '9pt'
#c.fonts.web.size.default = 12
c.fonts.default_family = []

# Change Audio Text
tabwidget.TabWidget.MUTE_STRING = "婢 "
tabwidget.TabWidget.AUDIBLE_STRING = "墳 "

# Example Config
# https://gist.github.com/Gavinok/f9c310a66576dc00329dd7bef2b122a1

# Configurations
#######################################################
# Change tab title format
#c.tabs.title.format = "{audio}{index}: {current_title}"
c.tabs.title.format = "{audio}{current_title}"
c.tabs.show = "multiple"

c.tabs.indicator.width = 3
c.tabs.indicator.padding = {'bottom': 2, 'left': 4, 'right': 8, 'top': 2}
c.tabs.position = 'top'
c.tabs.show = 'multiple'
c.tabs.title.alignment = 'left'
c.tabs.mousewheel_switching = False
c.tabs.padding = {'bottom': 4, 'left': 8, 'right': 4, 'top': 4}
c.tabs.favicons.show = 'pinned'
c.tabs.background = True
c.statusbar.show = "in-mode"
c.statusbar.padding = {'bottom': 2, 'left': 0, 'right': 0, 'top': 2}
c.content.javascript.can_access_clipboard = True
c.content.headers.accept_language = 'de-DE;de'
c.auto_save.session = True
c.new_instance_open_target = 'tab'

# Adblock
c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt', 'https://easylist.to/easylistgermany/easylistgermany.txt', 'https://secure.fanboy.co.nz/fanboy-annoyance.txt']
c.content.blocking.hosts.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts']
c.content.blocking.method = 'both'

# Start page
#######################################################
c.url.default_page = 'file:///home/murkl/.config/qutebrowser/startpage/index.html'
c.url.start_pages = 'file:///home/murkl/.config/qutebrowser/startpage/index.html'

# Search engines
#######################################################
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}', 'a': 'https://wiki.archlinux.org/?search={}', 'y': 'https://www.youtube.com/results?search_query={}'}

# Key bindings
#######################################################

# Toggle status & tab bar
config.bind('xx', 'config-cycle statusbar.show always never')
# Open link in mpv
config.bind('M', 'hint links spawn mpv {hint-url}')
# Download link with youtub-dl
config.bind('Z', 'hint links spawn st -e youtube-dl {hint-url}')


