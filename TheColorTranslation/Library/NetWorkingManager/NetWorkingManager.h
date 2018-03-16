//
//  NetWorkingManager.h
//  NetWork
//
//  Created by Rain on 16/11/28.
//  Copyright © 2016年 Rain. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef enum{
    
    ResultCode_Success        = 0,         /**< 请求成功 */
    ResultCode_ParamError     = 401,       /**< 参数错误 */
    ResultCode_UnknowError                 /**< 未知错误 */
}ResultCode; /**< 请求状态码 */

typedef enum{
    
    URLErrorCode_Timeout                       = -1001,    /**< 请求超时 */
    URLErrorCode_NetworkConnectionLost         = -1005,    /**< 网络中断 */
    URLErrorCode_NetworkOffline                = -1009,    /**< 网络已经离线 */
    URLErrorCode_WrongJSONFormat               = 3840,     /**< 错误的JSON格式，无法解析 */
    URLErrorCode_DisconServer                  = -1004,    /**< 无法连接服务器 */
    URLErrorCode_ServerError                   = -1011,    /**< 服务器错误 */
    URLErrorCode_Unknow,                                   /**< 未知错误 */
}URLErrorCode; /**< URL错误码 */

/**
 完成度回调block

 @param downloadProgress 完成度
 */
typedef void(^BlockProgress)(NSProgress *downloadProgress);

/**
 完成请求的回调block

 @param responseObject 回调的内容
 @param resultCode 错误码
 @param resultMessage 错误信息
 */
typedef void (^BlockFinish)(id responseObject, ResultCode resultCode, NSString *resultMessage);

@interface NetWorkingManager : AFHTTPSessionManager

+ (NetWorkingManager *)sharedManager;

#pragma mark - 数据请求

/**
 get request

 @param parameter 请求参数
 @param url 部分url
 @param blockProgress 完成度回调block
 @param blockFinish 完成请求的回调block
 */
- (void )getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url progress:(BlockProgress )blockProgress blockFinish:(BlockFinish )blockFinish;

/**
 post request

 @param parameter 请求参数
 @param url 部分url
 @param blockProgress 完成度回调block
 @param blockFinish 完成请求的回调block
 */
- (void )postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url progress:(BlockProgress )blockProgress blockFinish:(BlockFinish )blockFinish;

/**
 upload file request

 @param parameter 请求参数
 @param url 部分url
 @param arrayImage 上传的图片数组
 @param blockProgress 完成度回调block
 @param blockFinish 完成请求的回调block
 */
- (void )upLoadFileWithParameter:(NSDictionary *)parameter url:(NSString *)url arrayImage:(NSMutableArray *)arrayImage  blockProgress:(BlockProgress )blockProgress blockFinish:(BlockFinish )blockFinish;

/**
 download file request

 @param url 部分url
 @param progressBlock 完成度回调block
 @param block 完成请求的回调block
 */
- (void )downLoadFileWithUrl:(NSString *)url progress:(BlockProgress )progressBlock completionBlock:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))block;

#pragma mark - 网络监控
- (void)startMonitoring;

@end
