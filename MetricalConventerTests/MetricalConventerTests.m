//
//  MetricalConventerTests.m
//  MetricalConventerTests
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetricalConventerTests.h"
#import "Conventer.h"
#include <stdlib.h>


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

- (void)testConventerSanity
{
    Conventer * c = [[Conventer alloc] init];
    NSArray* availableUnits = [c availableUnits];
    
    NSDictionary* result;
    NSArray* resultKeys;
    NSString* newUnit;
    float originalValue;
    float newValue; 
    float newestValue;

    float error;
    
    for (NSString* unit in availableUnits) {
        originalValue = (float)(arc4random_uniform(100));
        [c setOperand:originalValue];
        [c setUnit:unit];
        result = [c getConventered];
        resultKeys = [result allKeys];
        newUnit = [resultKeys objectAtIndex:(arc4random_uniform([resultKeys count]-1))];
        newValue = [[result objectForKey:newUnit] floatValue];
        NSLog(@"%f %@ -> %f %@", originalValue, unit, newValue, newUnit);

        
        [c setUnit:newUnit];
        [c setOperand:newValue];
        result = [c getConventered];
        newestValue = [[result objectForKey:unit] floatValue];
        error = fabs(originalValue-newestValue);
        NSLog(@"%f %@ -> %f %@", newValue, newUnit, newestValue, unit);
        STAssertEqualsWithAccuracy(originalValue, newestValue, 0.00001, @"We expected %d, but it was %d", originalValue, newestValue);
        
    }
    
    
}

@end
