//
//  MetricalConverterTests.m
//  MetricalConverterTests
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetricalConverterTests.h"
#import "Converter.h"
#include <stdlib.h>


@implementation MetricalConverterTests

- (void)setUp
{
    [super setUp];
    
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testConverterSanity
{
    Converter * c = [[Converter alloc] init];
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
        result = [c getConvertered];
        resultKeys = [result allKeys];
        newUnit = [resultKeys objectAtIndex:(arc4random_uniform([resultKeys count]-1))];
        newValue = [[result objectForKey:newUnit] floatValue];
        NSLog(@"%f %@ -> %f %@", originalValue, unit, newValue, newUnit);

        
        [c setUnit:newUnit];
        [c setOperand:newValue];
        result = [c getConvertered];
        newestValue = [[result objectForKey:unit] floatValue];
        error = fabs(originalValue-newestValue);
        NSLog(@"%f %@ -> %f %@", newValue, newUnit, newestValue, unit);
        STAssertEqualsWithAccuracy(originalValue, newestValue, 0.00001, @"We expected %d, but it was %d", originalValue, newestValue);
    }
}
//-(void) testRPN
//{
//    Converter * c = [[Converter alloc] init];
//    NSLog(@"%f", [c computeRPNResult:@"2 3+"]);
//}

@end
