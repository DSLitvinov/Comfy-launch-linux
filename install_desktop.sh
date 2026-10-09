cp ./comfyui.desktop ~/.local/share/applications/comfyui.desktop

chmod +x ~/.local/share/applications/comfyui.desktop
update-desktop-database ~/.local/share/applications/
desktop-file-validate ~/.local/share/applications/comfyui.desktop

cp ~/.local/share/applications/comfyui.desktop ~/Desktop/
chmod +x ~/Desktop/comfyui.desktop