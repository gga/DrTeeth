//
//  DrTeethAppDelegate.m
//  DrTeeth
//
//  Created by Giles Alexander on 22/05/10.
//  Copyright Silverbrook Research 2010. All rights reserved.
//

#import "DrTeethAppDelegate.h"
#import "DrTeethViewController.h"

@implementation DrTeethAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
