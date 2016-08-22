//
//  AppDelegate.m
//  指纹+3DTouch
//
//  Created by 刘松 on 16/8/18.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self touch];
    
    return YES;
}

- (void)application:(UIApplication *)application
performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler{
    //判断先前我们设置的唯一标识
    if([shortcutItem.type isEqualToString:@"com.test.deep"]){
        NSLog(@"fslkdfhsldhflh");
        
        //        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[KCSearchGoodsVC alloc]init] animated:YES completion:nil];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)touch {
    UIApplicationShortcutIcon *icon1 =
    [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon1"];
    
    UIApplicationShortcutIcon *icon2 =
    [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon2"];
    
    UIApplicationShortcutIcon *icon3 =
    [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon3"];
    
    // create several (dynamic) shortcut items
    
    UIMutableApplicationShortcutItem
    
    *item1 = [[UIMutableApplicationShortcutItem
               
               alloc] initWithType:@"com.test.deep"
              localizedTitle:@"Deep Link "
              
              localizedSubtitle:@"Launch Nav "
              icon:icon1
              userInfo:nil];
    
    
    UIMutableApplicationShortcutItem
    
    *item2 = [[UIMutableApplicationShortcutItem
               
               alloc] initWithType:@"com.test.deep"
              localizedTitle:@"Deep Link 1"
              
              localizedSubtitle:@"Launch Nav Controller"
              icon:icon2
              userInfo:nil];
    
    UIMutableApplicationShortcutItem
    
    *item3 = [[UIMutableApplicationShortcutItem
               
               alloc] initWithType:@"com.test.deep665"
              localizedTitle:@"Deep Link 2"
              
              localizedSubtitle:@"Launch 2nd Level"
              icon:icon3
              userInfo:nil];
    
    // add all items to an array
    
    NSArray *items = @[ item1, item2, item3 ];
    
    // add this array to the potentially existing static
    // UIApplicationShortcutItems
    
    NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
    [UIApplication sharedApplication].shortcutItems = existingItems;
}

@end
