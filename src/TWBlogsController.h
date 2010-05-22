//
//  TWBlogsController.h
//  DrTeeth
//
//  Created by Giles Alexander on 22/05/10.
//  Copyright 2010 Silverbrook Research. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TWBlogsController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
  IBOutlet UITableView *tableView;
}

- (void)close:(id)sender;

@end
