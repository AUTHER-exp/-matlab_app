本组程序是例题计算

进行三角形3节点和四边形4节点单元的有限元计算
采用了局部坐标分选器，避免因为排序问题而导致的局部坐标混乱

局部坐标分选采用中心点——方位角分选办法，将按照ⅢⅣⅠⅡ象限标记为局部坐标点1234
其中在力边界上的单元边线为23

针对Ke积分运算进行了优化
采用函数句柄的方式，简化变量替代环节，速度提高3.5倍

运行app时，当前文件夹保持在根目录下，否则无法运行
