//
//  NetWorkingManager.m
//  NetWork
//
//  Created by Rain on 16/11/28.
//  Copyright © 2016年 Rain. All rights reserved.
//
#define TIMEOUT 10

#import "NetWorkingManager.h"

@implementation NetWorkingManager

+ (NetWorkingManager *)sharedManager{
    
    static NetWorkingManager *netWorkSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        netWorkSingleton = [[self alloc] init];
    });
    
    return netWorkSingleton;
}

- (AFHTTPSessionManager *)requestBaseHttp{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    //header 设置
//    [sessionManager.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"appversion"];
    AFJSONResponseSerializer *jsonResult = [AFJSONResponseSerializer serializer];
    jsonResult.removesKeysWithNullValues = YES;
    sessionManager.responseSerializer = jsonResult;
    sessionManager.requestSerializer.timeoutInterval = TIMEOUT;
    
    return sessionManager;
}

- (void )getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url progress:(BlockProgress )blockProgress blockFinish:(BlockFinish )blockFinish{
    
    AFHTTPSessionManager *sessionManager = [self requestBaseHttp];
    [sessionManager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (blockProgress) {
            
            blockProgress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ResultCode resultCode = [self checkResultCodeWithCodeString:[NSString stringWithFormat:@"%@",responseObject[@"code"]]];
        NSString *resultMessage = responseObject[@"message"];

        if (blockFinish) {
            
            blockFinish(responseObject, resultCode ,resultMessage);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *resultMessage = [self showErroInfoWithError:error];
        
        if (blockFinish) {
            
            blockFinish(nil ,ResultCode_UnknowError, resultMessage);
        }
    }];
}

- (void )postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url progress:(BlockProgress )blockProgress blockFinish:(BlockFinish )blockFinish{
    
    AFHTTPSessionManager *sessionManager = [self requestBaseHttp];
    [sessionManager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (blockProgress) {
            
            blockProgress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ResultCode resultCode = [self checkResultCodeWithCodeString:[NSString stringWithFormat:@"%@",responseObject[@"code"]]];
        NSString *resultMessage = responseObject[@"message"];
        
        if (blockFinish) {
            
            blockFinish(responseObject, resultCode ,resultMessage);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSString *resultMessage = [self showErroInfoWithError:error];

        if (blockFinish) {
            
            blockFinish(nil ,ResultCode_UnknowError, resultMessage);
        }
    }];
}

- (void )upLoadFileWithParameter:(NSDictionary *)parameter url:(NSString *)url arrayImage:(NSMutableArray *)arrayImage  blockProgress:(BlockProgress )blockProgress blockFinish:(BlockFinish )blockFinish{
    
    AFHTTPSessionManager *sessionManager = [self requestBaseHttp];
    [sessionManager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < arrayImage.count; i++){
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssss";
            NSString *strCurrentDate = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%ld.jpg", (long)[strCurrentDate integerValue] + i];
            NSData *dataImage = UIImagePNGRepresentation(arrayImage[i]);
            [formData appendPartWithFileData:dataImage name:@"file" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (blockProgress) {
            
            blockProgress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ResultCode resultCode = [self checkResultCodeWithCodeString:[NSString stringWithFormat:@"%@",responseObject[@"code"]]];
        NSString *resultMessage = responseObject[@"message"];
        
        if (blockFinish) {
            
            blockFinish(responseObject, resultCode ,resultMessage);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *resultMessage = [self showErroInfoWithError:error];
        
        if (blockFinish) {
            
            blockFinish(nil ,ResultCode_UnknowError, resultMessage);
        }
    }];
}

- (void )downLoadFileWithUrl:(NSString *)url progress:(BlockProgress )progressBlock completionBlock:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))block{
    
    AFHTTPSessionManager *sessionManager = [self requestBaseHttp];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task = [sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            
            progressBlock(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (block) {
            
            block(response ,filePath ,error);
        }
    }];
    
    //开始启动任务
    [task resume];
}

- (ResultCode)checkResultCodeWithCodeString:(NSString *)stringCode{
    
    if ([stringCode isEqualToString:@"200"]) {
        
        return ResultCode_Success;
    }else{
        
        return ResultCode_UnknowError;
    }
}

#pragma mark - show error information

- (NSString *)showErroInfoWithError:(NSError *)error{
    
    NSString *resultMessage;
    NSLog(@"error: %@",error);
    if (error.code == URLErrorCode_Timeout){
        
        resultMessage = @"请求超时";
    }else if (error.code == URLErrorCode_NetworkConnectionLost){
        
        resultMessage = @"网络中断";
    }else if (error.code == URLErrorCode_WrongJSONFormat){
        
        resultMessage = @"服务器返回数据有误";
    }else if (error.code == URLErrorCode_NetworkOffline){
        
        resultMessage = @"网络已经离线";
    }else if (error.code == URLErrorCode_DisconServer){
        
        resultMessage = @"无法连接服务器";
    }else if (error.code == URLErrorCode_ServerError){
        
        resultMessage = @"服务器错误";
    }else{
        
        resultMessage = @"未知错误";
    }
    return resultMessage;
}

- (void )startMonitoring{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                
                NSLog(@"未知");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                
                NSLog(@"无网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
                NSLog(@"蜂窝数据网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
                NSLog(@"WiFi");
            }
                break;
            default:
                break;
        }
    }];
    
    [manager startMonitoring];
    //[manager stopMonitoring]
}

@end
