//
// Created by Sean Brady on 8/16/14.
// Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPATheme : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imageUrl;

- (id)initWithDictionary:(NSDictionary *)jsonData;
@end