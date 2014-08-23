//
//  EPALandscapeDesignCell.m
//  EnPleinAir
//
//  Created by Sean Brady on 8/23/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPALandscapeDesignCell.h"
#import "EPALandscape.h"
#import "BasicWebViewController.h"

@implementation EPALandscapeDesignCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)prepContent {
    [_designerButton setTitle:_landscape.designer forState:UIControlStateNormal];
}


- (void)prepareForReuse {
    [_designerButton setTitle:@"" forState:UIControlStateNormal];
}


- (IBAction)didDesignerButton:(id)sender {
    BasicWebViewController *bwvc = [[BasicWebViewController alloc] initWithURL:_landscape.designerWebsite];
    bwvc.title = _landscape.designer;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.parentVC.navigationController pushViewController:bwvc animated:YES];
    });

}

@end
