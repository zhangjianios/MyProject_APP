//
//  BaseNetManager.h
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
/**
 *  请求成功与失败的Block
 */
typedef void(^FinishBlock)(AFHTTPRequestOperation *operation, id result);

typedef void(^FailuerBlock)(AFHTTPRequestOperation *operation, NSError *error);


@interface BaseNetManager : NSObject

+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod finishBlock:(FinishBlock)finish failuerBlock:(FailuerBlock)failuer;

+ (void)downloadFileWithUrl:(NSString*)url Params:(NSMutableDictionary*)params SavePath:(NSString*)savePath DownLoadSuccess:(FinishBlock)finish DownLoadFailure:(FailuerBlock)failure;




@end


