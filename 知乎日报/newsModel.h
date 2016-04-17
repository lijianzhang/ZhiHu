//
//  newsModel.h
//  知乎日报
//
//  Created by Jz on 16/4/16.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol newsModelData <NSObject>

-(NSString *)htmlBody;
-(NSString *)htmlJS;
-(NSString *)newsHeadIamge;
-(NSString *)newsHeadtitle;
-(NSString *)newsHeadIamgesource;
@end

@interface sectionModel : NSObject
@property(nonatomic,copy)NSString *thunbnail;/**<<#text#> */
@property(nonatomic,assign)NSInteger Id;/**< <#shuoming#> */
@property(nonatomic,copy)NSString *name;/**<<#text#> */
@end
@class section;
@interface newsModel : NSObject<newsModelData>

@property(nonatomic,copy)NSString *body;/**<HTML 格式的新闻 */
@property(nonatomic,copy)NSString *image_source;/**<图片的内容提供方。为了避免被起诉非法使用图片，在显示图片时最好附上其版权信息。 */
@property(nonatomic,copy)NSString *title;/**< 新闻标题 */
@property(nonatomic,copy)NSString *image;/**<获得的图片同 最新消息 获得的图片分辨率不同。这里获得的是在文章浏览界面中使用的大图。 */
@property(nonatomic,copy)NSString *share_url;/**< 供在线查看内容与分享至 SNS 用的 URL */
@property(nonatomic,strong)NSArray *js;/**<供手机端的 WebView(UIWebView) 使用 */
@property(nonatomic,strong)NSArray<NSDictionary*> *recommeders;/**<这篇文章的推荐者 */
@property(nonatomic,copy)NSString *ga_prefix;/**<供 Google Analytics 使用 */
@property(nonatomic,strong)sectionModel *section; /**<栏目的信息 */
@property(nonatomic,assign)NSInteger type;/**< 新闻的类型 */
@property(nonatomic,assign)NSInteger Id;/**< 新闻的 id */
@property(nonatomic,strong)NSArray *css;/**<: 供手机端的 WebView(UIWebView) 使用 */
- (NSString *)htmlBody;
- (instancetype)initWithDict:(NSDictionary*)dic;
@end

