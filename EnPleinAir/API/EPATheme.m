//
// Created by Sean Brady on 8/16/14.
// Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPATheme.h"


@implementation EPATheme {

}


- (id)initWithDictionary:(NSDictionary *)jsonData {
    self = [super init];
    if (self) {
        self.name = jsonData[@"name"];
        self.id = jsonData[@"id"];
        self.imageUrl = jsonData[@"image_url"];
    }

    return self;
}

@end