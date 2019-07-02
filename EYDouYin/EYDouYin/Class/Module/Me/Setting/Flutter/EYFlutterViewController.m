//
//  EYFlutterViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/2.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYFlutterViewController.h"

@interface EYFlutterViewController () <FlutterBinaryMessenger>

@property (strong, nonatomic) FlutterMethodChannel *methodChannel;

@end

@implementation EYFlutterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
//    __weak typeof(self) weakSelf = self;
    
    // 要与main.dart中一致
    NSString *channelName = @"com.pages.your/native_get";
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:self];
    [self.methodChannel invokeMethod:@"1234" arguments:@"5678" result:^(id  _Nullable result) {
        EYLog(@"invokeMethod==%@", result);
    }];
//    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall* _Nonnull call, FlutterResult  _Nonnull result) {
//        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
//        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
//        // result 是给flutter的回调， 该回调只能使用一次
//        NSLog(@"flutter 给到我：\nmethod=%@ \narguments = %@", call.method, call.arguments);
//        if([call.method isEqualToString:@"toNativeSomething"]) {
//            //添加提示框
//            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功" preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction * actionDetermine = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                // 回调给flutter
//                if(result) {
//                    result(@10);
//                }
//            }];
//
//            [alert addAction:actionDetermine];
//
//            [weakSelf presentViewController:alert animated:YES completion:nil];
//        } else if([call.method isEqualToString:@"toNativePush"]) {
//
//        } else if([call.method isEqualToString:@"toNativePop"]) {
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        } else {
//
//        }
//    }];
}

#pragma mark - FlutterBinaryMessenger
/**
 * Sends a binary message to the Flutter side on the specified channel, expecting
 * no reply.
 *
 * @param channel The channel name.
 * @param message The message.
 */
- (void)sendOnChannel:(NSString *)channel message:(NSData *)message {
    EYLog(@"sendOnChannel==%@==%@", channel, message);
}

/**
 * Sends a binary message to the Flutter side on the specified channel, expecting
 * an asynchronous reply.
 *
 * @param channel The channel name.
 * @param message The message.
 * @param callback A callback for receiving a reply.
 */
- (void)sendOnChannel:(NSString *)channel message:(NSData *)message binaryReply:(FlutterBinaryReply)callback {
    EYLog(@"sendOnChannel==%@==%@", channel, message.mj_JSONString);
}

/**
 * Registers a message handler for incoming binary messages from the Flutter side
 * on the specified channel.
 *
 * Replaces any existing handler. Use a `nil` handler for unregistering the
 * existing handler.
 *
 * @param channel The channel name.
 * @param handler The message handler.
 */
- (void)setMessageHandlerOnChannel:(NSString *)channel binaryMessageHandler:(FlutterBinaryMessageHandler)handler {
    EYLog(@"setMessageHandlerOnChannel==%@==%@", channel, handler);
    
    // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
    // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
    // result 是给flutter的回调， 该回调只能使用一次
//    NSLog(@"flutter 给到我：\nmethod=%@ \narguments = %@", call.method, call.arguments);
//    if([call.method isEqualToString:@"toNativeSomething"]) {
//        //添加提示框
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功" preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction * actionDetermine = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            // 回调给flutter
//            if(result) {
//                result(@10);
//            }
//        }];
//        
//        [alert addAction:actionDetermine];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//    } else if([call.method isEqualToString:@"toNativePush"]) {
//        
//    } else if([call.method isEqualToString:@"toNativePop"]) {
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    } else {
//        
//    }
}

@end
