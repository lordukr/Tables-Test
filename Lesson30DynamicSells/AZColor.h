//
//  AZColor.h
//  Lesson30DynamicSells
//
//  Created by My mac on 18.04.16.
//  Copyright © 2016 Anatolii Zavialov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AZColor : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) UIColor* color;

- (id) initWithParams:(NSString*) label andColor:(UIColor*) color;

@end
