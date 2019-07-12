//
//  AppDelegate.m
//  Instagram
//
//  Created by ezietz on 7/8/19.
//  Copyright © 2019 ezietz. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(  NSDictionary *)launchOptions {
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"elizabethinstagram";
        configuration.server = @"https://elizabethinstagram.herokuapp.com/parse";
    }];
    [Parse initializeWithConfiguration:config];
    if (PFUser.currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
