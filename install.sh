sudo echo ""
echo "========================================================================="
echo "setting the folders in the directory .config"
if [[ $(ls ~/.config/ | grep "OldConfig") ]]; then
  echo -e "it seems the scripts already run on the system, you might \nneed to remove the folder ~/.config/OldConfig folder to execute the script"
  exit 
fi
mkdir ~/.config/OldConfig
if [[ $(ls ~/.config/ | grep "kitty") ]]; then
  mv ~/.config/kitty/ ~/.config/OldConfig

fi
cp -r src/alacritty/ ~/.config/

if [[ $(ls ~/.config/ | grep "i3") ]]; then
  mv ~/.config/i3/ ~/.config/OldConfig
fi
cp -r src/i3/ ~/.config/

if [[ $(ls ~/.config/ | grep "picom") ]]; then
  mv ~/.config/picom/ ~/.config/OldConfig
fi
cp -r src/picom/ ~/.config/

if [[ $(ls ~/.config/ | grep "rofi") ]]; then
  mv ~/.config/rofi/ ~/.config/OldConfig
fi
cp -r src/rofi/ ~/.config/

if [[ $(ls ~/.config/ | grep "fish") ]]; then
  mv ~/.config/fish/ ~/.config/OldConfig
fi
cp -r src/fish/ ~/.config/

if [[ $(ls ~/.config/ | grep "polybar") ]]; then
  mv ~/.config/polybar/ ~/.config/OldConfig
fi
cp -r src/polybar/ ~/.config/
