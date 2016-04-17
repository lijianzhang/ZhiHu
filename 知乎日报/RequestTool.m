//
//  RequestTool.m
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "RequestTool.h"
#import <UIKit/UIKit.h>
static NSString * const Themes = @"http://news-at.zhihu.com/api/4/themes";/**< 主题日报列表URL */
static NSString * const LatestNews = @"http://news-at.zhihu.com/api/4/news/latest";
static NSString * const OldNews = @"http://news.at.zhihu.com/api/4/news/before/%@";
static NSString * const new = @"http://news-at.zhihu.com/api/4/news/%@";
static NSString * const LaunchImage = @"http://news-at.zhihu.com/api/4/start-image/1080*1776";
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
-(void)getOldNewsBefone:(NSString*) time WithSuccess:(success)success andfail:(fail)fail{
    NSString *url = [NSString stringWithFormat:OldNews,time];
    [self JZRequestWithURLString:url Success:^(id requestData) {
        success(requestData);
    } andFial:^(NSError *error) {
        fail(error);
    }];
}

- (void)getNewWithNewId:(NSNumber *)newId AndSuccess:(success)success andFail:(fail)fail{
    NSString *url = [NSString stringWithFormat:new,newId];
    [self JZRequestWithURLString:url Success:^(id requestData) {
        success(requestData);
    } andFial:^(NSError *error) {
        fail(error);
    }];
}
- (void)getLaunchImageWihtSuccess:(success)success andFail:(fail)fail{
    [self JZRequestWithURLString:LaunchImage Success:^(id requestData) {
        success(requestData);
    } andFial:^(NSError *error) {
        fail(error);
    }];
}

- (void)JZRequestWithURLString:(NSString*)urlString Success:(success)success andFial:(fail)fail{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;

        if (error) {
            fail(error);

        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
            success(dict);
        }
    }]resume];
}
@end
