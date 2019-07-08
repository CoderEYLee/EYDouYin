//
//  TTFFmpegManager.m
//  CLVideo
//
//  Created by 李二洋 on 2019/7/6.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import "TTFFmpegManager.h"
#import "ffmpeg.h"

@interface TTFFmpegManager()

@property (nonatomic, assign) BOOL isRuning;
@property (nonatomic, assign) long long fileDuration;
@property (nonatomic, copy) void (^processBlock)(float process);
@property (nonatomic, copy) void (^completionBlock)(NSError *error);

@end

@implementation TTFFmpegManager

+ (instancetype)manager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

// 转换视频
- (void)converVideoWithInputPath:(NSString *)inputPath
                 outputPath:(NSString *)outpath
               processBlock:(void (^)(float process))processBlock
            completionBlock:(void (^)(NSError *error))completionBlock {
    self.processBlock = processBlock;
    self.completionBlock = completionBlock;
    
//    String[] commands = new String[]{"-threads","2","-i", videoPath, "-c:v", "libx264","-b:v","1250K","-s","1280x720","-crf","30","-preset", "superfast","-y",
//        "-acodec","libmp3lame","-vol","500", outPath};
    
//    String[] command = new String[]{"-i", path};
    
    // ffmpeg语法
//    NSString *commandStr = [NSString stringWithFormat:@"ffmpeg -threads 2 -i %@ -c:v libx264 -b:v 1250K -s 1280x720 crf 30 -preset superfast -acodec libmp3lame -vol 500 -y %@", inputPath, outpath];
    // -h 输出 log
    // -threads 2
    // -i 输入文件路径
    // -c:v 编码格式
    // -b:v 视频码率
    // -s 视频frame大小
    // -aspect 宽高比
    // -b:a 音频码率
    // -ac 音频通道数 channels
    // -vol 音频的声音大小  -pre superfast
    /*
     
     Getting help:
     -h      -- print basic options
     -h long -- print more options
     -h full -- print all options (including all format and codec specific options, very long)
     -h type=name -- print all options for the named decoder/encoder/demuxer/muxer/filter/bsf
     See man ffmpeg for detailed description of the options.
     
     Print help / information / capabilities:
     -L                  show license
     -h topic            show help
     -? topic            show help
     -help topic         show help
     --help topic        show help
     -version            show version
     -buildconf          show build configuration
     -formats            show available formats
     -muxers             show available muxers
     -demuxers           show available demuxers
     -devices            show available devices
     -codecs             show available codecs
     -decoders           show available decoders
     -encoders           show available encoders
     -bsfs               show available bit stream filters
     -protocols          show available protocols
     -filters            show available filters
     -pix_fmts           show available pixel formats
     -layouts            show standard channel layouts
     -sample_fmts        show available audio sample formats
     -colors             show available color names
     -sources device     list sources of the input device
     -sinks device       list sinks of the output device
     -hwaccels           show available HW acceleration methods
     
     Global options (affect whole program instead of just one file:
     -loglevel loglevel  set logging level
     -v loglevel         set logging level
     -report             generate a report
     -max_alloc bytes    set maximum size of a single allocated block
     -y                  overwrite output files
     -n                  never overwrite output files
     -ignore_unknown     Ignore unknown stream types
     -filter_threads     number of non-complex filter threads
     -filter_complex_threads  number of threads for -filter_complex
     -stats              print progress report during encoding
     -max_error_rate maximum error rate  ratio of errors (0.0: no errors, 1.0: 100% errors) above which ffmpeg returns an error instead of success.
     -bits_per_raw_sample number  set the number of bits per raw sample
     -vol volume         change audio volume (256=normal)
     
     Per-file main options:
     -f fmt              force format
     -c codec            codec name
     -codec codec        codec name
     -pre preset         preset name
     -map_metadata outfile[,metadata]:infile[,metadata]  set metadata information of outfile from infile
     -t duration         record or transcode "duration" seconds of audio/video
     -to time_stop       record or transcode stop time
     -fs limit_size      set the limit file size in bytes
     -ss time_off        set the start time offset
     -sseof time_off     set the start time offset relative to EOF
     -seek_timestamp     enable/disable seeking by timestamp with -ss
     -timestamp time     set the recording timestamp ('now' to set the current time)
     -metadata string=string  add metadata
     -program title=string:st=number...  add program with specified streams
     -target type        specify target file type ("vcd", "svcd", "dvd", "dv" or "dv50" with optional prefixes "pal-", "ntsc-" or "film-")
     -apad               audio pad
     -frames number      set the number of frames to output
     -filter filter_graph  set stream filtergraph
     -filter_script filename  read stream filtergraph description from a file
     -reinit_filter      reinit filtergraph on input parameter changes
     -discard            discard
     -disposition        disposition
     
     Video options:
     -vframes number     set the number of video frames to output
     -r rate             set frame rate (Hz value, fraction or abbreviation)
     -s size             set frame size (WxH or abbreviation)
     -aspect aspect      set aspect ratio (4:3, 16:9 or 1.3333, 1.7777)
     -bits_per_raw_sample number  set the number of bits per raw sample
     -vn                 disable video
     -vcodec codec       force video codec ('copy' to copy stream)
     -timecode hh:mm:ss[:;.]ff  set initial TimeCode value.
     -pass n             select the pass number (1 to 3)
     -vf filter_graph    set video filters
     -ab bitrate         audio bitrate (please use -b:a)
     -b bitrate          video bitrate (please use -b:v)
     -dn                 disable data
     
     Audio options:
     -aframes number     set the number of audio frames to output
     -aq quality         set audio quality (codec-specific)
     -ar rate            set audio sampling rate (in Hz)
     -ac channels        set number of audio channels
     -an                 disable audio
     -acodec codec       force audio codec ('copy' to copy stream)
     -vol volume         change audio volume (256=normal)
     -af filter_graph    set audio filters
     
     Subtitle options:
     -s size             set frame size (WxH or abbreviation)
     -sn                 disable subtitle
     -scodec codec       force subtitle codec ('copy' to copy stream)
     -stag fourcc/tag    force subtitle tag/fourcc
     -fix_sub_duration   fix subtitles duration
     -canvas_size size   set canvas size (WxH or abbreviation)
     -spre preset        set the subtitle options to the indicated preset

     usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...
     */
    //    NSString *commandStr = [NSString stringWithFormat:@"ffmpeg -i %@ -y %@", inputPath, outpath];
//    NSString *commandStr = [NSString stringWithFormat:@"ffmpeg -ignore_unknown -i %@ -c:v h264 -b:v 1250 -r 25 -vol 500 -y %@", inputPath, outpath];
    
    NSString *commandStr = [NSString stringWithFormat:@"ffmpeg -i %@ -c:v h264 -b:v 1250K -r 25 -s 720X1280 -vol 500 -y %@", inputPath, outpath];
    // 放在子线程运行
    [[[NSThread alloc] initWithTarget:self selector:@selector(runCmd:) object:commandStr] start];
}

// 执行指令
- (void)runCmd:(NSString *)commandStr{
    // 判断转换状态
    if (self.isRuning) {
        NSLog(@"正在转换,稍后重试");
    }
    self.isRuning = YES;
    
    // 根据 !#$ 将指令分割为指令数组
    NSArray *argv_array = [commandStr componentsSeparatedByString:(@" ")];
    // 将OC对象转换为对应的C对象
    int argc = (int)argv_array.count;
    char** argv = (char**)malloc(sizeof(char*)*argc);
    for(int i=0; i < argc; i++) {
        argv[i] = (char*)malloc(sizeof(char)*1024);
        strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
    }
    
    // 打印日志
    EYLog(@"ffmpeg 运行参数%@",commandStr);
    
    // 传入指令数及指令数组
    ffmpeg_main(argc, argv);
    
    // 线程已杀死,下方的代码不会执行
}

// 设置总时长
+ (void)setDuration:(long long)time {
    [TTFFmpegManager manager].fileDuration = time;
}

// 设置当前时间
+ (void)setCurrentTime:(long long)time {
    TTFFmpegManager *mgr = [TTFFmpegManager manager];
    if (mgr.processBlock && mgr.fileDuration) {
        float process = time/(mgr.fileDuration * 1.00);
        dispatch_async(dispatch_get_main_queue(), ^{
            mgr.processBlock(process);
        });
    }
}

// 转换停止 ret:0 成功, 其他:失败
+ (void)stopRuning:(int)ret {
    TTFFmpegManager *mgr = [TTFFmpegManager manager];
    NSError *error = nil;
    if (ret) {//转换过程中出现了错误
        error = [NSError errorWithDomain:@"转换失败,请检查源文件的编码格式!"
                                    code:0
                                userInfo:nil];
    }
    
    if (mgr.completionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            mgr.completionBlock(error);
        });
    }
    
    mgr.isRuning = NO;
}

@end
