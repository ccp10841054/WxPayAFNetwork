//
//  Readme.h
//  WXpay
//
//  Created by sandy on 16/4/28.
//  Copyright © 2016年 sandy. All rights reserved.
//

#import <Foundation/Foundation.h>



/* 查看url的content-type等信息*/
1.用chrome浏览器打开浏览器，右击 －－－检查 <快捷键 f12>
 样例：请查看图片url_info.jpg


/* AFNet的用法 主要是Post和Get*/

注意：a)返回数据类型，基本完整的如下
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    b)一般注意输写规范，一般url头 body params
    c)一般处理dic时，请先判断是否为空，以免奔溃

1.POST:

AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
session.requestSerializer = [AFJSONRequestSerializer serializer];
NSMutableDictionary *params = [NSMutableDictionary dictionary];
params[@"start"] = @"1";
params[@"end"] = @"5";

[session POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"请求成功");
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"请求成功");
}];


2.GET:

AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
[manager GET:@"http://example.com/resources.json" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
    NSDictionary * dic = responseObject; //直接返回json
    //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject  options:NSJSONReadingAllowFragments error:nil];//Data转json
    
    //    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithBase64EncodedData:responseObject options:NSDataBase64DecodingIgnoreUnknownCharacters] options:NSJSONReadingAllowFragments error:nil];//base64转json
} failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
}];


2.解析Json有四种方式：touchJson、SBJson、JSonKit和系统解析方法NSJSONSerialization。

　　下面主要介绍SBJson解析Json的方法：

　　首先在Build Phases中需要导入库文件：libxml2.dylib。

　　然后导入第三方包GDataXMLNode.h和GDataXMLNode.m文件

　　新建程序，利用NSConnection方法或者ASIHTTPRequest方法下载XML文件，下面以ASIHTTPRequest方法为例，在ASIHTTPRequestDelegate协议方法中进行XML文件解析。
-(void)requestFinished:(ASIHTTPRequest *)request {
    [mData setLength:0];
    [mData appendData:[request responseData]];
//用字典来接受下载的Json数据
    NSDictionary *dict = [mData JSONValue];
}