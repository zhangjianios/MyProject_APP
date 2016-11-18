//
//  AppDelegate+Category.m
//  MyProject_APP
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate+Category.h"


@implementation AppDelegate (Category)

- (void)initializeWithApplication:(UIApplication *)application{
    
    // 注册DDLog 取代NSLog
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance]setColorsEnabled:YES];
    
    //电池条显示网络活动
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    //检测网络状态
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        DDLogVerbose(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                self.onLine = YES;
                break;
                case AFNetworkReachabilityStatusNotReachable:
            default:
                self.onLine = NO;
                break;
        }
        [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    }];
    
    
}


@end
