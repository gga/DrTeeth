//
//  DrTeethViewController.h
//  DrTeeth
//
//  Created by Giles Alexander on 22/05/10.
//  Copyright Silverbrook Research 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverFlowView.h"

@class TWBlogsController;

@interface DrTeethViewController : UIViewController <CoverFlowHost>
{
  IBOutlet UIView *meContainer;
  IBOutlet UIView *credentials;
  IBOutlet UITextField *userName;
  IBOutlet UITextField *password;
  IBOutlet UIView *minime;
	
  NSArray *covers;
  IBOutlet CoverFlowView *cfView;
	
}

@property (retain) NSArray *covers;
@property (retain) CoverFlowView *cfView;

- (void)showBlogs:(id)sender;
- (void)signIn:(id)sender;

@end

