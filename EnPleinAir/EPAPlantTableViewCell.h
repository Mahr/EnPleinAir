//
//  EPAPlantTableViewCell.h
//  EnPleinAir
//
//  Created by Sean Brady on 8/21/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPAPlant;

@interface EPAPlantTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *plantImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;

@property (strong, nonatomic) UIViewController *parentVC;

@property (strong, nonatomic) EPAPlant *plant;

- (void)prepContent;
@end
