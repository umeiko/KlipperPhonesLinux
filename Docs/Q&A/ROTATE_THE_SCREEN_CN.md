# 旋转屏幕

- 运行命令

        sudo nano /etc/X11/xorg.conf.d/00-rotate.conf

- 找到 `Option "Rotate" "Right"`这行，替换 `"Right"`，即可旋转显示

        90度  	"Left"                    
        180度 	"Inverted"                
        270度  	"Right" 【默认就是这个】       


- 找到 `Option "CalibrationMatrix" "0 1 0 -1 0 1 0 0 1"` 这行，替换 `"0 1 0 -1 0 1 0 0 1"`，即可旋转触摸

        90度                      "0 -1 1 1 0 0 0 0 1"
        180度                     "-1 0 1 0 -1 1 0 0 1"
        270度 【默认就是这个】     "0 1 0 -1 0 1 0 0 1" 

- 如果想要竖屏就直接把这个文件删了

        sudo rm /etc/X11/xorg.conf.d/00-rotate.conf