# Rotate Screen
[中文文档](./ROTATE_THE_SCREEN_CN.md)

# X11
- Run the command

        sudo nano /etc/X11/xorg.conf.d/00-rotate.conf

- Find the line `Option "Rotate" "Right"`, replace `"Right"` with the desired rotation

        90 degrees    "Left"                    
        180 degrees   "Inverted"                
        270 degrees   "Right" 【Default】       


- Find the line `Option "CalibrationMatrix" "0 1 0 -1 0 1 0 0 1"`, replace `"0 1 0 -1 0 1 0 0 1"` to rotate touch input

        90 degrees     "0 -1 1 1 0 0 0 0 1"
        180 degrees    "-1 0 1 0 -1 1 0 0 1"
        270 degrees 【Default】  "0 1 0 -1 0 1 0 0 1" 

- If you want a portrait orientation, simply delete this file

        sudo rm /etc/X11/xorg.conf.d/00-rotate.conf

# Weston

- Run the command
  
         sudo nano /root/.config/weston.ini

- change the `transform` section
