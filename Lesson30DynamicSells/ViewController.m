//
//  ViewController.m
//  Lesson30DynamicSells
//
//  Created by My mac on 18.04.16.
//  Copyright © 2016 Anatolii Zavialov. All rights reserved.
//

#import "ViewController.h"
#import "AZColor.h"
#import "AZStudent.h"

@interface ViewController () 

@property (strong, nonatomic) NSMutableArray* allObjects;
@property (strong, nonatomic) NSArray* groupsOfObjects;

@end

typedef enum {
    CellObjectTypeStudent,
    CellObjectTypeColor
}CellObjectType;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allObjects = [[NSMutableArray alloc] initWithArray:[self splitStudentsByGrade]];
    [self.allObjects addObject:[self createRandomColorsArray]];
    
    self.groupsOfObjects = [[NSArray alloc] initWithObjects:@"Excellent Students", @"Good Students", @"Bad students", @"Very bad students", @"Colors", nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (UIColor*) randomColor {
    CGFloat r = arc4random() % 256 /255.f;
    CGFloat g = arc4random() % 256 /255.f;
    CGFloat b = arc4random() % 256 /255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (NSArray*) createRandomColorsArray {
    
    NSMutableArray* colors = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 10; i++) {
        
        UIColor* currentColor = [self randomColor];
        CGFloat r,g,b,a;
        
        [currentColor getRed:&r green:&g blue:&b alpha:&a];
        NSString* colorName = [NSString stringWithFormat:@"Red = %d, Green = %d, Blue = %d",(int)(r * 255.f), (int)(g * 255.f), (int)(b * 255.f)];
        AZColor* color = [[AZColor alloc] initWithParams:colorName andColor:currentColor];
        [colors addObject:color];
    }
    
    return colors;
}

- (NSArray*) createRandomStudents {
    NSMutableArray* students = [[NSMutableArray alloc] init];
    
    NSArray* firstNamesArray = [[NSArray alloc] initWithObjects:@"Alex", @"Kate", @"Steven", @"Patrick", @"Dave", @"Mike", @"John", nil];
    NSArray* lastNamesArray = [[NSArray alloc] initWithObjects:@"Jhonson", @"Paterson", @"Davidson", @"Poulson", @"Garrison", @"Luter", @"Klein", nil];
    
    for (NSInteger i = 0; i < 30; i++) {
        NSUInteger firstNameIndex = arc4random() % [firstNamesArray count];
        NSUInteger lastNameIndex = arc4random() % [lastNamesArray count];
        
        NSString* studentName = [NSString stringWithFormat:@"%@ %@",    [firstNamesArray objectAtIndex:firstNameIndex],
                                                                        [lastNamesArray objectAtIndex:lastNameIndex]];
        
        NSInteger grade = (arc4random() % 12) + 1;
        
        AZStudent* student = [[AZStudent alloc] initWithName:studentName andGrade:grade];
        [students addObject:student];
    }
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [students sortUsingDescriptors:@[sortDescriptor]];
    
    return students;
}

- (NSArray*) splitStudentsByGrade {
    
    NSArray* allStudents = [self createRandomStudents];
    
    NSMutableArray* veryBadStudents = [[NSMutableArray alloc] init];
    NSMutableArray* badStudents = [[NSMutableArray alloc] init];
    NSMutableArray* goodStudents = [[NSMutableArray alloc] init];
    NSMutableArray* excellentStudents = [[NSMutableArray alloc] init];
    
    for (AZStudent* student in allStudents) {
        if (student.grade >= 10) {
            [excellentStudents addObject:student];
        }
        else if (student.grade > 6 && student.grade < 10) {
            [goodStudents addObject:student];
        }
        else if (student.grade > 3 && student.grade <= 6) {
            [badStudents addObject:student];
        }
        else {
            [veryBadStudents addObject:student];
        }
    }
    
    NSArray* preparedArray = [[NSArray alloc] initWithObjects:excellentStudents, goodStudents, badStudents, veryBadStudents, nil];
    
    return preparedArray;
}

- (UITableViewCell*) createCellForObjectStudent:(AZStudent*) student inTable:(UITableView*) tableView {
    static NSString* identifierStudent = @"studentCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierStudent];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierStudent];
        NSLog(@"Student cell created");
    } else {
        NSLog(@"Student cell reused");
    }
    
    UIColor* currentColor;
    
    if (student.grade >= 10) {
        currentColor = [UIColor greenColor];
    }
    else if (student.grade > 6 && student.grade < 10) {
        currentColor = [UIColor yellowColor];
    }
    else if (student.grade > 3 && student.grade <= 6) {
        currentColor = [UIColor orangeColor];
    }
    else {
        currentColor = [UIColor redColor];
    }
    
    cell.textLabel.text = student.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.0f", student.grade];
    cell.textLabel.textColor = currentColor;
    
    return cell;
}

- (UITableViewCell*) createCellForObjectColor:(AZColor*) colorObject inTable:(UITableView*) tableView {
    static NSString* identifier = @"colorCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSLog(@"Color cell created");
    } else {
        NSLog(@"Color cell reused");
    }

    cell.backgroundColor = colorObject.color;
    cell.textLabel.text = colorObject.name;
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self.allObjects objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell;
    
    NSObject* object = [[self.allObjects objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([object isKindOfClass:[AZStudent class]]) {
        AZStudent* student = (AZStudent*)object;
        
        cell = [self createCellForObjectStudent:student inTable:tableView];
    }
    else if ([object isKindOfClass:[AZColor class]]) {
        AZColor* color = (AZColor*)object;
        
        cell = [self createCellForObjectColor:color inTable:tableView];
        
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.allObjects count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.groupsOfObjects objectAtIndex:section];
}

@end
