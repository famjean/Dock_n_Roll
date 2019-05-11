#!/bin/bash
# Script to launch rstudio

# correct bug on keyboard
export QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb


# launch
env QTWEBENGINE_DISABLE_SANDBOX=1 /usr/bin/rstudio
