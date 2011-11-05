//
//  Conventer.m
//  MetricalConventer
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Conventer.h"

@implementation Conventer

-(id) init
{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"unitsByMultiply" ofType:@"plist"];
        unitsByMultiply = [[NSDictionary alloc] initWithContentsOfFile:path]; 
    }
    return self;
}
- (void) setOperand:(double)operandToSet
{
    self->operand = operandToSet;
}
- (void) setUnit:(NSString *)unitToSet
{
    self->unit = unitToSet;
}


- (NSArray*) getUnitsOfCategory:(NSString*)category
{
    NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
    NSMutableArray* result = [NSMutableArray arrayWithArray:[[categoryDict objectForKey:@"Units"] allKeys] ] ;
    [result addObject:[categoryDict objectForKey:@"BaseUnit"]];
    return [NSArray arrayWithArray:result];
}

- (NSString*) getCategoryForUnit:(NSString*)forUnit
{
    for (NSString* category in unitsByMultiply) {
        NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
        if ([[categoryDict objectForKey:@"BaseUnit"] isEqual:forUnit]){
            return category;
        }
        for (NSString* unitInCategory in [categoryDict objectForKey:@"Units"]) {
            if ([unitInCategory isEqual:forUnit]) {
                return category;
            }
        }
    }
    return nil;
}

- (NSString*) getBaseUnitInCategory:(NSString*)category
{
    NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
    return [categoryDict objectForKey:@"BaseUnit"];
}

-(double) getMultiplierForUnit:(NSString*)forUnit
{
    NSDictionary* categoryDict = [unitsByMultiply objectForKey:[self getCategoryForUnit:forUnit]];
    NSNumber* result = [[categoryDict objectForKey:@"Units"] objectForKey:forUnit];
    return [result doubleValue];
}


-(double) convertFromUnit:(NSString*)fromUnit toUnit:(NSString*)toUnit value:(double)value
{
    NSString* category = [self getCategoryForUnit:unit];
    NSString* baseUnit =  [self getBaseUnitInCategory:category];
    if ([baseUnit isEqualToString:fromUnit]) {
        return value * [self getMultiplierForUnit:toUnit];
    }
    else if ([baseUnit isEqualToString:toUnit]) {
        return value / [self getMultiplierForUnit:fromUnit];
    }
    else {
        double baseValue = [self convertFromUnit:fromUnit toUnit:baseUnit value:value];
        return [self convertFromUnit:baseUnit toUnit:toUnit value:baseValue];
    }
}


- (NSDictionary*) getConventered
{
    NSString* category = [self getCategoryForUnit:unit];
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    NSArray* unitsToConvert = [self getUnitsOfCategory:category];
    for (NSString *unitToConvert in unitsToConvert) {
        if (![unitToConvert isEqualToString: self->unit]) {
            [result setObject:[NSNumber numberWithDouble:[self convertFromUnit:self->unit toUnit:unitToConvert value:self->operand]] forKey:unitToConvert];
        }
    }
    return [NSDictionary dictionaryWithDictionary:result];
}


@end
