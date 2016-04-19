//
//  AZColor.m
//  Lesson30DynamicSells
//
//  Created by My mac on 18.04.16.
//  Copyright © 2016 Anatolii Zavialov. All rights reserved.
//

#import "AZColor.h"

@implementation AZColor

- (id) initWithParams:(NSString*) label andColor:(UIColor*) color {
    
    self = [super init];
    
    if (self) {
        self.name = label;
        self.color = color;
        
        return self;
    }
    return self;
}

@end
