//
//  TTFFmpegConverOC.h
//  CLVideo
//
//  Created by 李二洋 on 2019/7/6.
//  Copyright © 2019 TaoTie. All rights reserved.
//

/**
 监测FFmpeg中C方法转化为OC方法 (此工程中的 FFmpeg 版本为 4.0.3 版本, 高版本中对应的方法会更加完善)
 */

// 转换停止回调
void stopRuning(int ret);

// 获取总时间长度
void setDuration(long long int time);

// 获取当前时间
void setCurrentTime(char info[1024]);
