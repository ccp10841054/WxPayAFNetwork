//
//  AppDelegate.m
//  WXpay
//
//  Created by sandy on 12/4/15.
//  Copyright (c) 2015 sandy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:WX_AppID];
    return YES;
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        NSLog(@"支付结果:errcode=%d",resp.errCode);
    }
}
@end
