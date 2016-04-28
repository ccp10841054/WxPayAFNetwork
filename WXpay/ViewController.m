//
//  ViewController.m
//  WXpay
//
//  Created by sandy on 12/4/15.
//  Copyright (c) 2015 sandy. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
#import "WXApi.h"



@interface ViewController ()
{


    __weak IBOutlet UITextField *m_textfield_pay_money;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)m_button_pay_money:(UIButton *)sender {
    
//    NSString *url = [NSString stringWithFormat:@"%@totalmoney=255",WX_URL];
    NSDictionary * dicPara= [NSDictionary dictionaryWithObjectsAndKeys:m_textfield_pay_money.text,@"totalmoney",nil];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];

    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];

    [session GET:WX_URL parameters:dicPara success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功JSON: %@", responseObject);
        
        NSDictionary * dic = responseObject;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject  options:NSJSONReadingAllowFragments error:nil];//Data转json
        
    //    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithBase64EncodedData:responseObject options:NSDataBase64DecodingIgnoreUnknownCharacters] options:NSJSONReadingAllowFragments error:nil];//base64转json
        
        NSLog(@"success!result dic = %@",dic);

        if ([[dic objectForKey:@"RetMsg"]isEqualToString:@"SUCCESS"] && [[dic objectForKey:@"RetCode"]isEqualToString:@"0000"]) {
            PayReq * request = [[PayReq alloc]init];
            request.partnerId = [dic objectForKey:@"partnerid"];
            request.package = [dic objectForKey:@"package"];
            request.prepayId = [dic objectForKey:@"prepayid"];
            request.nonceStr = [dic objectForKey:@"noncestr"];
            request.timeStamp = (UInt32)[[dic objectForKey:@"timestamp"]intValue];
            request.sign = [dic objectForKey:@"sign"];
            
//            if ([WXApi isWXAppInstalled]) //IOS9.0一直返回no
            {
                BOOL ret =  [WXApi safeSendReq:request];
                if (!ret) {
                    NSLog(@"支付失败");
                }
            }
//            else
//            {
//                NSLog(@"请先安装微信");
//            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"支付失败:%@",error);
    }];
}
@end
