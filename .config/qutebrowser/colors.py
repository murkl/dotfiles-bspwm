import subprocess

# Read XResources Colors
def read_xresources(prefix):
    props = {}
    x = subprocess.run(["xrdb", "-query"], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split("\n")
    for line in filter(lambda l: l.startswith(prefix), lines):
        prop, _, value = line.partition(":\t")
        props[prop] = value
    return props

xresources = read_xresources("*")

# Statusbar
c.colors.statusbar.normal.bg = xresources["*.background"]
c.colors.statusbar.command.bg = xresources["*.background"]
c.colors.statusbar.command.fg = xresources["*.foreground"]
c.colors.statusbar.normal.fg = xresources["*.foreground"]
c.colors.statusbar.url.fg = xresources["*.foreground"]
c.colors.statusbar.url.hover.fg = xresources["*.color4"]
c.colors.statusbar.url.success.http.fg = xresources["*.foreground"]
c.colors.statusbar.url.success.https.fg = xresources["*.color2"]

# Tabs
c.colors.tabs.even.bg = xresources["*.background"]
c.colors.tabs.even.fg = xresources["*.foreground"]
c.colors.tabs.odd.bg = xresources["*.background"]
c.colors.tabs.odd.fg = xresources["*.foreground"]
c.colors.tabs.selected.even.bg = xresources["*.color4"]
c.colors.tabs.selected.even.fg = xresources["*.background"]
c.colors.tabs.selected.odd.bg = xresources["*.color4"]
c.colors.tabs.selected.odd.fg = xresources["*.background"]

# Indicator
c.colors.tabs.indicator.error = xresources["*.color1"]
c.colors.tabs.indicator.start = xresources["*.color3"]
c.colors.tabs.indicator.stop = xresources["*.color2"]

# Completion
c.colors.completion.odd.bg = xresources["*.background"]
c.colors.completion.even.bg = xresources["*.background"]
c.colors.completion.fg = xresources["*.foreground"]
c.colors.completion.category.bg = xresources["*.background"]
c.colors.completion.category.fg = xresources["*.foreground"]
c.colors.completion.item.selected.bg = xresources["*.background"]
c.colors.completion.item.selected.fg = xresources["*.foreground"]

# Hints
c.colors.hints.bg = xresources["*.background"]
c.colors.hints.fg = xresources["*.foreground"]