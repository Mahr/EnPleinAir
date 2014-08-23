//
//  EPALandscapeInfoViewController.h
//  EnPleinAir
//
//  Created by Sean Brady on 8/17/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPALandscape;

@interface EPALandscapeInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) EPALandscape *landscape;
@property(nonatomic, strong) NSMutableArray *plants;
@property(nonatomic) CGFloat landscapeHeight;
@property(nonatomic) CGFloat moreInfoHeight;
@property(nonatomic) CGFloat plantHeight;
@end
