//
//  DrTeethAppDelegate.h
//  DrTeeth
//
//  Created by Giles Alexander on 22/05/10.
//  Copyright Silverbrook Research 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrTeethViewController;

@interface DrTeethAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DrTeethViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DrTeethViewController *viewController;

@end
