//
//  newsModel.m
//  知乎日报
//
//  Created by Jz on 16/4/16.
//  Copyright © 2016年 Jz. All rights reserved.
//

#import "newsModel.h"
//body : HTML 格式的新闻
//image-source : 图片的内容提供方。为了避免被起诉非法使用图片，在显示图片时最好附上其版权信息。
//title : 新闻标题
//image : 获得的图片同 最新消息 获得的图片分辨率不同。这里获得的是在文章浏览界面中使用的大图。
//share_url : 供在线查看内容与分享至 SNS 用的 URL
//js : 供手机端的 WebView(UIWebView) 使用
//recommenders : 这篇文章的推荐者
//ga_prefix : 供 Google Analytics 使用
//section : 栏目的信息
//thumbnail : 栏目的缩略图
//id : 该栏目的 id
//name : 该栏目的名称
//type : 新闻的类型
//id : 新闻的 id
//css : 供手机端的 WebView(UIWebView) 使用
//可知，知乎日报的文章浏览界面利用 WebView(UIWebView) 实现
@implementation newsModel
- (NSString *)htmlBody{
    return [NSString stringWithFormat:@"<html><head><link rel='stylesheet' href='%@'><body>%@</body></head></html>",self.css.firstObject,self.body];
}

- (NSString *)htmlJS{
    return self.js.firstObject;
}

-(instancetype)initWithDict:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _body = dic[@"body"];
        _image_source = dic[@"image_source"];
        _title = dic[@"title"];
        _image = dic[@"image"];
        _share_url = dic[@"share_url"];
        _js = dic[@"js"];
        _css = dic[@"css"];
        _recommeders = dic[@"recommeders"];
    }
    return self;
}
-(NSString *)newsHeadIamge{
    return self.image;
}
- (NSString *)newsHeadIamgesource{
    return self.image_source;
}
- (NSString *)newsHeadtitle{
    return self.title;
}
@end
