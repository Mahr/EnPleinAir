//
//  EPAPlant.m
//  EnPleinAir
//
//  Created by Sean Brady on 8/21/14.
//  Copyright (c) 2014 Sean Brady. All rights reserved.
//

#import "EPAPlant.h"

@implementation EPAPlant

- (id)initWithDictionary:(NSDictionary *)jsonData {
    self = [super init];
    if (self) {
        self.name = jsonData[@"name"];
        self.latinName = jsonData[@"latin_name"];
        self.id = jsonData[@"id"];
        self.imageUrl = jsonData[@"image_url"];
        self.description = jsonData[@"description"];
    }

    return self;
}

@end
