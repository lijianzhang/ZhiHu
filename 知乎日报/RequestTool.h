//
//  RequestTool.h
//  知乎日报
//
//  Created by Jz on 16/4/8.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^success)(id requestData);
typedef void(^fail)(NSError *error);

@interface RequestTool : NSObject

+ (instancetype)shardRequest;

-(void)getThemesWithSuccess:(success)success andfail:(fail)fail;
-(void)getLatestNewsWithSuccess:(success)success andfail:(fail)fail;
-(void)getOldNewsBefone:(NSString*) time WithSuccess:(success)success andfail:(fail)fail;
- (void)getNewWithNewId:(NSNumber *)newId AndSuccess:(success)success andFail:(fail)fail;
- (void)getLaunchImageWihtSuccess:(success)success andFail:(fail)fail;
@end
