//
//  NetManager.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "NetManager.h"
@implementation NetManager

@synthesize delegate;

@synthesize requestId;
@synthesize loadingText;
@synthesize isRequesting;
@synthesize isShowLoading;
@synthesize requestDic;


- (id)init
{
    self = [super init];
    if (self) {
        loadingText  = @"";
        isShowLoading = NO;
        isRequesting = NO;
        _isShowProgress = YES;
    }
    return self;
}

/**
 木库所有接口统一调用此请求方法
 
 @param urlString 地址
 @param dataDict 参数
 */
-(void)sendPOSTRequestToServerWithURL:(NSString *)urlString postData:(NSMutableDictionary *)dataDict{
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(delegate) weakDelegate = delegate;


    NSString *string =kDomainUrl;
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(requestStart:)]) {
            [delegate requestStart:self];
        }
    }
    
    NSData *postData = [NSData dataWithData:[NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:nil]];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:string parameters:nil error:nil];
    request.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:postData];
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         if(responseObject!=NULL) {
             if (weakDelegate) {
                 if ([weakDelegate respondsToSelector:@selector(requestDidFinished:result:)]) {
                 }
             }
             
         }
        if (!error) {
            if (weakDelegate) {
                if ([weakDelegate respondsToSelector:@selector(requestDidFinished:result:)]) {
                    [weakDelegate requestDidFinished:weakSelf result:responseObject];
                }
            }
        } else {
            if (weakDelegate) {
                if ([weakDelegate respondsToSelector:@selector(requestError:error:)]) {
                    [weakDelegate requestError:weakSelf error:error];
                }
            }
        }
    }] resume];
    
    
    
}






- (void)uploadWithUrl:(NSString *)url body:(NSDictionary *)body imageData:(NSData *)data{
    
    if ([MTool getNetWorkStatus] == AFNetworkReachabilityStatusNotReachable) {//无网络
        [MTool showMessage:@"网络不畅，请检查您的网络" inView:nil];
        return;
    }
    
    [self addLoadingView];
    
    NSString *string = kDomainUrl;
    
    string = [string stringByAppendingString:url];
    
    
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(delegate) weakDelegate = delegate;
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:string parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        //二进制文件，接口key值，文件路径，图片格式
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"success");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        NSMutableDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        if (weakDelegate) {
            if ([weakDelegate respondsToSelector:@selector(requestDidFinished:result:)]) {
                [weakDelegate requestDidFinished:weakSelf result:dictionary];
            }
        }
        [weakSelf removeLoadingView];        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (weakDelegate) {
            if ([weakDelegate respondsToSelector:@selector(requestError:error:)]) {
                [weakDelegate requestError:weakSelf error:error];
            }
        }
        [weakSelf removeLoadingView];
    }];
}


//上传文件
- (void)uploadWithUrl:(NSString *)url body:(NSDictionary *)body method:(NSString *)method  decode:(NSString *)deCode constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))bodyBlock
{
    if ([MTool getNetWorkStatus] == AFNetworkReachabilityStatusNotReachable) {//无网络
        [MTool showMessage:@"网络不畅，请检查您的网络" inView:nil];
        return;
    }
    
    [self addLoadingView];
    
    NSString *string = kDomainUrl;
    
    string = [string stringByAppendingString:url];
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(requestStart:)]) {
            [delegate requestStart:self];
        }
    }
    
    //加密
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];
    serializer.timeoutInterval = 30;
    
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:method URLString:string parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        bodyBlock(formData);
        
    } error:nil];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(delegate) weakDelegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"text/json", @"application/json" @"text/javascript", nil];
    //     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    [manager.requestSerializer setValue:deCode forHTTPHeaderField:@"encryptValue"];
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            //            NSLog(@"responseObject: %@", responseObject);
            if (weakDelegate) {
                if ([weakDelegate respondsToSelector:@selector(requestDidFinished:result:)]) {
                    [weakDelegate requestDidFinished:weakSelf result:responseObject];
                }
            }
            [weakSelf removeLoadingView];
        } else {
            //            NSLog(@"error: %@, %@, %@", error, response, responseObject);
            if (weakDelegate) {
                if ([weakDelegate respondsToSelector:@selector(requestError:error:)]) {
                    [weakDelegate requestError:weakSelf error:error];
                }
            }
            [weakSelf removeLoadingView];
        }
    }] resume];
    

}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}




- (void)addLoadingView {
    
    isRequesting = YES;
    
    if (loadingText) {
        isShowLoading = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            LoadingView *view = (LoadingView *)[appDelegate.window viewWithTag:123456];
            view.loadingViewAlpha = _loadingViewAlpha;
            
            UIView *view2 = [appDelegate.window viewWithTag:123457];
            if (!view2) {
                view2  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
                view2.tag = 123457;
                [appDelegate.window addSubview:view2];
            }else{
                [appDelegate.window bringSubviewToFront:view2];
            }
            
            if (!view) {
                view = [[LoadingView alloc] initWithFrame:appDelegate.window.bounds];
                view.tag = 123456;
                view.loadingViewAlpha = _loadingViewAlpha;
                [appDelegate.window addSubview:view];
            }else{
                [appDelegate.window bringSubviewToFront:view];
            }
        });
        
        
        
    }
}

- (void)removeLoadingView {
    isRequesting = NO;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    UIWindow *keyWindow = [UIApplication sharedApplication].delegate;
    LoadingView *view = (LoadingView *)[appDelegate.window viewWithTag:123456];
    UIView *view2 = [appDelegate.window viewWithTag:123457];
    [view2 removeFromSuperview];
    [view stopAnimation];
    
    //loadingText = @"";
}

- (void)dealloc{
    [self removeLoadingView];
}


@end
