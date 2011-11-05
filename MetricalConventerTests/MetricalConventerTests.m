//
//  MetricalConventerTests.m
//  MetricalConventerTests
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetricalConventerTests.h"
#import "Conventer.h"

@implementation MetricalConventerTests

- (void)setUp
{
    [super setUp];
    
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testConventer
{
    Conventer * c = [[Conventer alloc] init];
    [c setOperand:20];
    [c setUnit:@"kg"];
    NSDictionary* result = [c getConventered];
    NSLog(@"%@", result);
    
}

@end
