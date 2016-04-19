//
//  AZStudent.m
//  Lesson30DynamicSells
//
//  Created by My mac on 18.04.16.
//  Copyright © 2016 Anatolii Zavialov. All rights reserved.
//

#import "AZStudent.h"

@implementation AZStudent

- (id) initWithName:(NSString *)name andGrade:(CGFloat)grade {
    
    self = [super init];
    
    if (self) {
        self.name = name;
        self.grade = grade;
        
        return self;
    }
    
    return self;
}

@end
