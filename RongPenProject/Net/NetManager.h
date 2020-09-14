//
//  NetManager.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingView.h"
#import <AFNetworking.h>


@class NetManager;

@protocol NetManagerDelegate <NSObject>

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result;
- (void)requestError:(NetManager *)request error:(NSError*)error;

@optional
- (void)requestStart:(NetManager *)request;


@end

@interface NetManager : AFHTTPSessionManager


@property (nonatomic, retain)   NSString *loadingText;
@property (nonatomic, readonly) BOOL isShowLoading;
@property (nonatomic, assign)   BOOL isShowProgress;//是否显示等待框
@property (nonatomic, readonly) BOOL isRequesting;
@property (nonatomic) NSInteger requestId;
@property (nonatomic, retain) NSDictionary *requestDic;


@property (nonatomic, assign) BOOL loadingViewAlpha;


@property(assign, nonatomic) id <NetManagerDelegate> delegate;

//- (AFSecurityPolicy*)customSecurityPolicy;
- (void)sendPOSTRequestToServerWithAllURL:(NSString *)urlString postData:(NSMutableDictionary *)dataDict;

- (void)sendPOSTRequestToServerWithURL:(NSString *)urlString postData:(NSMutableDictionary *)dataDict;
- (void)sendPOSTRequestToServerWithURL:(NSString *)urlString postData:(NSMutableDictionary *)dataDict deCode:(NSString *)deCode;
- (void)uploadWithUrl:(NSString *)url body:(NSDictionary *)body method:(NSString *)method  decode:(NSString *)deCode constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock;



/**
 上传图片

 @param url 地址
 @param body 参数
 @param data 文件
 */
- (void)uploadWithUrl:(NSString *)url body:(NSDictionary *)body  imageData:(NSData *)data;

/**
 新的接口请求

 @param urlString 地址
 @param dataDict 参数
 */
-(void)NewsendPOSTRequestToServerWithURL:(NSString *)urlString postData:(NSMutableDictionary *)dataDict;


/**
 新新请求接口   别问我为什么  两个服务器  后台是大哥

 @param urlString 地址
 @param dataDict 参数
 */
-(void)NewNewsendPOSTRequestToServerWithURL:(NSString *)urlString postData:(NSMutableDictionary *)dataDict;


@end
