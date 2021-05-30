//
//  EYMeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYMeViewController.h"
#import "EYExcelTool.h"
#import "EYDouYin-Swift.h"
#import <Flutter/Flutter.h>
#import "EYRNViewController.h"

@interface EYMeViewController () <UITableViewDataSource, UITableViewDelegate, FlutterStreamHandler>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray <EYLocalUseModel *>*arrayM;

@end

@implementation EYMeViewController

static NSString *EYMeViewControllerCellID = @"EYMeViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
    
    [self.tableView reloadData];
    
    // [EYExcelTool startParseExcel];
 }

//1. 初始化界面
- (void)setupUI {
    //1.隐藏分割线
    self.gk_navTitle = @"我的";
}

#pragma mark - iOS <--> Flutter 的通信
// 进入 Fulutter 界面
- (void)pushFlutterViewController {
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithNibName:nil bundle:nil];
    flutterViewController.view.backgroundColor = EYColorWhite;
    // 设置路由名字 跳转到不同的flutter界面
    /*flutter代码*/
    /*
     import 'dart:ui';

     void main() => runApp(_widgetForRoute(window.defaultRouteName));

     Widget _widgetForRoute(String route) {
     switch (route) {
     case 'myApp':
     return new MyApp();
     case 'home':
     return new HomePage();
     default:
     return Center(
     child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
     );
     }
     }
     */

    __weak typeof(self) weakSelf = self;

    // iOS-->Flutter
    // 要与main.dart中一致
    NSString *methodChannelName = @"com.pages.your/native_get";
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:methodChannelName binaryMessenger:flutterViewController];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall* _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        EYLog(@"flutter 给到我：\nmethod=%@ \narguments = %@", call.method, call.arguments);
        if([call.method isEqualToString:@"toNativeSomething"]) {
            //添加提示框
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction * actionDetermine = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                // 回调给flutter
                if(result) {
                    result(@(1000));
                }
            }];

            [alert addAction:actionDetermine];

            [self presentViewController:alert animated:YES completion:nil];
        } else if([call.method isEqualToString:@"toNativePush"]) {

        } else if([call.method isEqualToString:@"toNativePop"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {

        }
    }];

    //iOS-->Flutter
    NSString *eventChannelName = @"com.pages.your/native_post";
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:eventChannelName binaryMessenger:flutterViewController];
    // 代理FlutterStreamHandler
    [evenChannal setStreamHandler:weakSelf];

    //push转场动画
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:animation forKey:kCATransition];
    [self.navigationController pushViewController:flutterViewController animated:NO];
}
    
- (void)pushReactNative {
    EYRNViewController *rnVc = [[EYRNViewController alloc] init];
    [self.navigationController pushViewController:rnVc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arrayM[section] valueForKeyPath:@"items"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EYMeViewControllerCellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EYMeViewControllerCellID];
        cell.backgroundColor = EYColorClear;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = EYColorWhite;
    }

    NSArray *items = self.arrayM[indexPath.section].items;
    EYLocalUseModel *localUseModel = items[indexPath.row];
    cell.textLabel.text = localUseModel.name;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.arrayM[section].groupName;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.arrayM valueForKeyPath:@"groupName"];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *items = self.arrayM[indexPath.section].items;
    EYLocalUseModel *localUseModel = items[indexPath.row];
    NSString *language = localUseModel.language;
    
    if ([language isEqualToString:@"OC"] || [language isEqualToString:@"Swift"]) {
        UIViewController *vc = [[NSClassFromString(localUseModel.vcName) alloc] init];
        vc.title = localUseModel.name;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([language isEqualToString:@"Flutter"]) {
        [self pushFlutterViewController];
    } else if ([language isEqualToString:@"RN"]) {
        [self pushReactNative];
    } else {
        
    }
}

#pragma mark - FlutterStreamHandler
 // 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    EYLog(@"123 onListenWithArguments==%@==%@", arguments, events);
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        events(@"push传值给flutter的vc");
    }
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id)arguments {
    // arguments flutter给native的参数
    EYLog(@"123 onCancelWithArguments==%@", arguments);
    return nil;
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) style:UITableViewStyleGrouped];
        tableView.backgroundColor = EYColorClear;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray<EYLocalUseModel *> *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [EYLocalUseModel mj_objectArrayWithFilename:@"EYMeViewControllerSourceArray.plist"];
    }
    return _arrayM;
}

@end
