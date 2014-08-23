//
//  EPALandscapeDesignCell.h
//  EnPleinAir
//
//  Created by Sean Brady on 8/23/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPALandscape;

@interface EPALandscapeDesignCell : UITableViewCell

@property (strong, nonatomic) EPALandscape *landscape;
@property (strong, nonatomic) UIViewController *parentVC;

@property (weak, nonatomic) IBOutlet UIButton *designerButton;

- (void)prepContent;
@end
