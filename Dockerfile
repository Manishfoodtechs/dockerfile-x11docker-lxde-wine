# x11docker/lxde-wine
# Run wine on LXDE desktop in docker. 
# Use x11docker to run image. 
# Get x11docker from github: 
#   https://github.com/mviereck/x11docker 
#
# Examples: x11docker --desktop x11docker/lxde-wine
#           x11docker x11docker/lxde-wine playonlinux
#
# Use option --home to create a persistant home folder preserving your wine installations.
# Examples: x11docker --home --desktop x11docker/lxde-wine
#           x11docker --home           x11docker/lxde-wine playonlinux
#
# To have pulseaudio sound, add option --pulseaudio.
# To have hardware accelerated graphics, use option --gpu.

FROM x11docker/lxde:latest
RUN echo "deb http://deb.debian.org/debian stretch contrib" >> /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get update

# wine
RUN apt-get install -y wine wine32 wine64
RUN apt-get install -y fonts-wine winetricks ttf-mscorefonts-installer winbind

# wine gecko
RUN mkdir -p /usr/share/wine/gecko
RUN cd /usr/share/wine/gecko && wget http://dl.winehq.org/wine/wine-gecko/2.40/wine_gecko-2.40-x86.msi

# wine mono
RUN mkdir -p /usr/share/wine/mono
RUN cd /usr/share/wine/mono && wget https://dl.winehq.org/wine/wine-mono/4.7.0/wine-mono-4.7.0.msi

# PlayOnLinux
RUN apt-get install -y playonlinux xterm gettext

# q4wine, another frontend for wine
RUN apt-get install -y q4wine

## pulseaudio
RUN apt-get install -y --no-install-recommends pulseaudio pasystray pavucontrol

# Utils: browser and pdf viewer
RUN apt-get install -y dillo evince-gtk


## Add this for chinese, japanese and korean fonts in wine
#winetricks cjkfonts


# create desktop icons that will be copied to every new user
#
RUN mkdir -p /etc/skel/Desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Play on Linux\n\
Exec=playonlinux\n\
Icon=playonlinux\n\
" > /etc/skel/Desktop/PlayOnLinux.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Q4wine\n\
Exec=q4wine\n\
Icon=q4wine\n\
" > /etc/skel/Desktop/Q4wine.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Internet Explorer\n\
Exec=wine iexplore\n\
Icon=applications-internet\n\
" > /etc/skel/Desktop/WineInternetExplorer.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=WineConsole\n\
Exec=wineconsole\n\
Icon=utilities-terminal\n\
" > /etc/skel/Desktop/WineConsole.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=File Explorer\n\
Exec=wine explorer\n\
Icon=folder\n\
" > /etc/skel/Desktop/WineExplorer.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Notepad\n\
Exec=wine notepad\n\
Icon=wine-notepad\n\
" > /etc/skel/Desktop/WineNotepad.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Wordpad\n\
Exec=wine wordpad\n\
Icon=accessories-text-editor\n\
" > /etc/skel/Desktop/WineWordpad.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Configure Wine\n\
Exec=winecfg\n\
Icon=wine-winecfg\n\
" > /etc/skel/Desktop/WineCfg.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Wine File Manager\n\
Exec=winefile\n\
Icon=folder-wine\n\
" > /etc/skel/Desktop/WineFile.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Mines\n\
Exec=wine winemine\n\
Icon=face-cool\n\
" > /etc/skel/Desktop/WineMine.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=winetricks\n\
Exec=winetricks --gui\n\
Icon=wine\n\
" > /etc/skel/Desktop/winetricks.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=RegEdit\n\
Exec=regedit\n\
Icon=preferences-system\n\
" > /etc/skel/Desktop/WineRegEdit.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=UnInstaller\n\
Exec=wine uninstaller\n\
Icon=wine-uninstaller\n\
" > /etc/skel/Desktop/WineUnInstaller.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=TaskManager\n\
Exec=wine taskmgr\n\
Icon=utilities-system-monitor\n\
" > /etc/skel/Desktop/WineTaskmgr.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Wine Control Panel\n\
Exec=wine control\n\
Icon=preferences-system\n\
" > /etc/skel/Desktop/WineControl.desktop

RUN echo "[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=OleView\n\
Exec=wine oleview\n\
Icon=preferences-system\n\
" > /etc/skel/Desktop/WineOleView.desktop

RUN echo "#! /bin/bash\n\
# To install chinese, japanese and korean fonts for wine, run\n\
# winetricks cjkfonts\n\
xterm -e 'winetricks cjkfonts'\n\
" > "/etc/skel/Desktop/chinese, japanese and korean font installer for wine"
RUN chmod +x "/etc/skel/Desktop/chinese, japanese and korean font installer for wine"

# start script for LXDE desktop already defined in x11docker/lxde
CMD start
