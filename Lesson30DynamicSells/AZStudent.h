//
//  AZStudent.h
//  Lesson30DynamicSells
//
//  Created by My mac on 18.04.16.
//  Copyright © 2016 Anatolii Zavialov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AZStudent : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) CGFloat grade;

- (id)initWithName:(NSString*)name andGrade:(CGFloat) grade;

@end
