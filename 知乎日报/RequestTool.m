//
//  RequestTool.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "RequestTool.h"

static NSString * const Themes = @"https://news-at.zhihu.com/api/4/themes";/**< 主题日报列表URL */
static NSString * const LatestNews = @"https://news-at.zhihu.com/api/4/news/latest";

@interface RequestTool()
@property(nonatomic,strong,nonnull) NSURLSession *session;
@end

@implementation RequestTool
+ (instancetype)shardRequest{
    static RequestTool *reques = nil;
    dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        reques = [[self alloc]init];
    });
    return reques;
    
}

- (NSURLSession *)session{
    if (!_session) {
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 10.0;
        _session = session;
    }
    return _session;
}

-(void)getThemesWithSuccess:(success)success andfail:(fail)fail{
    NSURL *url = [NSURL URLWithString:Themes];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            fail(error);
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
            success(dict);
        }
    }] resume];
    
}

-(void)getLatestNewsWithSuccess:(success)success andfail:(fail)fail{
    NSURL *url = [NSURL URLWithString:LatestNews];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            fail(error);
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
            success(dict);
        }
    }] resume];
}

@end
