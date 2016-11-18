//
//  BaseNetManager.m
//  MyProject_APP
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseNetManager.h"

@implementation BaseNetManager


//请求网络数据的方法
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params httpMethod:(NSString *)httpMethod finishBlock:(FinishBlock)finish failuerBlock:(FailuerBlock)failuer{
    //判断参数是否为空
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    /**
     * 对网络请求的参数进行加密
     *
     */
    //对传入的参数进行加密
    NSMutableArray* keys = [NSMutableArray new];
    NSString* key = @"";
    NSEnumerator* keyEnumerator = [params keyEnumerator];
    while (key = [keyEnumerator nextObject]) {
        [keys addObject:key];
    }
    NSMutableArray* values = [NSMutableArray new];
    for (NSString* keyStr in keys) {
        id val = [params objectForKey:keyStr];
        if([val isKindOfClass:[NSString class]]) {
            /**
             * 对网络请求的参数进行加密
             *
             */
//            NSString* value = [[DESUtils encryptUseDES:val key:DES_KEY] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"解密后的内容：%@",[DESUtils decryptUseDES:value key:DES_KEY]);
//            [values addObject:value];
        }else {
            [values addObject:val];
        }
    }
    NSDictionary* paramDic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    //拼接字符串
    NSString *urlStr = [base_url stringByAppendingString:url];
    //构建一个operation
    AFHTTPRequestOperation *operation = nil;
    //构建manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //请求方法
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    //判断是GET请求还是POST请求
    if ([httpMethod isEqualToString:@"GET"]) {
        //get请求
        operation = [manager GET:urlStr
                      parameters:paramDic
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             if (finish) {
                                 //请求网络成功
                                 NSLog(@"GET请求成功");
                                 NSString* jsonStr = @"";
                                 /**
                                  * @reqno:H1605310012
                                  * @date-designer:20160613-mobei
                                  * @date-author:20160613-mobei:对网络请求返回的数据进行解密
                                  *
                                  */
                                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                     jsonStr = [responseObject objectForKey:@"data"];
//                                     jsonStr = [DESUtils decryptUseDES:jsonStr key:DES_KEY];
                                 }
                                 NSDictionary* result = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                                 if (!result) {
                                     result = [NSDictionary new];
                                 }
                                 finish(operation, result);
                             }
                         }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             if (failuer) {
                                 //请求网络失败
                                 NSLog(@"GET请求失败");
                                 failuer(operation, error);
                             }
                         }];
    }else if ([httpMethod isEqualToString:@"POST"]){
        
        //判断有没有带文件
        BOOL isfile = NO;
        NSMutableData *data = [NSMutableData data];
        NSString *key = nil;
        id value = nil;
        for (key in params) {
            value = [params objectForKey:key];
            if ([value isKindOfClass:[NSData class]]) {
                isfile = YES;
                [data appendData:value];
                break;
            }
        }
        if (isfile) {
            //带文件
            operation = [manager POST:urlStr
                           parameters:paramDic
            constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *key in params) {
                    id value = [params objectForKey:key];
                    if ([value isKindOfClass:[NSData class]]) {
                        [formData appendPartWithFileData:value
                                                    name:key
                                                fileName:key mimeType:@"image/jpeg"];
                    }
                }
            }
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  if (finish) {
                                      //请求成功
                                      NSLog(@"POST请求成功");
                                      /**
                                       * @reqno:H1605310012
                                       * @date-designer:20160613-mobei
                                       * @date-author:20160613-mobei:对网络请求返回的数据进行解密
                                       *
                                       */
                                      NSString* jsonStr = @"";
                                      if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                          jsonStr = [responseObject objectForKey:@"data"];
//                                          jsonStr = [DESUtils decryptUseDES:jsonStr key:DES_KEY];
                                      }
                                      NSDictionary* result = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                                      if (!result) {
                                          result = [NSDictionary new];
                                      }
                                      finish(operation, result);
                                  }
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  if (failuer) {
                                      //请求失败
                                      NSLog(@"POST请求失败");
                                      failuer(operation, error);
                                  }
                              }];
        }else{
            //不带图片
            operation = [manager POST:urlStr
                           parameters:paramDic
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  if (finish) {
                                      //请求成功
                                      NSLog(@"POST请求成功");
                                      /**
                                       * @reqno:H1605310012
                                       * @date-designer:20160613-mobei
                                       * @date-author:20160613-mobei:对网络请求返回的数据进行解密
                                       *
                                       */
                                      NSString* jsonStr = @"";
                                      if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                          jsonStr = [responseObject objectForKey:@"data"];
//                                          jsonStr = [DESUtils decryptUseDES:jsonStr key:DES_KEY];
                                      }
                                      NSDictionary* result = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                                      if (!result) {
                                          result = [NSDictionary new];
                                      }
                                      finish(operation, result);
                                  }
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  if (failuer) {
                                      //请求失败
                                      NSLog(@"POST请求失败");
                                      failuer(operation, error);
                                  }
                              }];
        }
    }
    
    //设置解析方式
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    return operation;
}

//下载文件
+ (void)downloadFileWithUrl:(NSString*)url Params:(NSMutableDictionary*)params SavePath:(NSString*)savePath DownLoadSuccess:(FinishBlock)finish DownLoadFailure:(FailuerBlock)failure {
    
    NSString *urlStr = [base_url stringByAppendingString:url];
    NSString* str = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestSerializer* serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest* request = [serializer requestWithMethod:@"GET" URLString:str parameters:nil error:nil];
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savePath append:NO]];
    //    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
    ////        float p = (float)totalBytesRead/totalBytesExpectedToRead;
    ////        progress(p);
    //
    //    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        finish(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
    [operation start];
}



@end
