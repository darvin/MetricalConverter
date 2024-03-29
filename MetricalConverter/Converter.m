//
//  Converter.m
//  MetricalConverter
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Converter.h"


@interface Converter ()
- (NSArray*) getUnitsOfCategory:(NSString*)category;
- (NSMutableSet*) getCategoriesForUnit:(NSString*)forUnit;
- (NSString*) getCategoryForUnit:(NSString*)forUnit1 andUnit:(NSString*)forUnit2;
- (NSString*) getBaseUnitInCategory:(NSString*)category;
-(double) getMultiplierForUnit:(NSString*)forUnit inCategory: (NSString*)category;
-(double) convertFromUnit:(NSString*)fromUnit toUnit:(NSString*)toUnit value:(double)value;

@end

@implementation Converter
@synthesize unit, operand;
-(id) init
{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"unitsByMultiply" ofType:@"plist"];
        unitsByMultiply = [[NSDictionary alloc] initWithContentsOfFile:path];
        [unitsByMultiply retain];
        self.operand = 0;
        self.unit = [[self availableUnits] objectAtIndex:0];
    }
    return self;
}

-(void) dealloc
{
    [unitsByMultiply release];
    [super dealloc];
}
- (NSDictionary*) getConvertered
{
    NSSet* categories = [self getCategoriesForUnit:unit];
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    NSMutableArray* unitsToConvert = [NSMutableArray array];
    for (NSString* category in categories) {
        [unitsToConvert addObjectsFromArray: [self getUnitsOfCategory:category]];
    }
    for (NSString *unitToConvert in unitsToConvert) {
        if (![unitToConvert isEqualToString: self->unit]) {
            [result setObject:[NSNumber numberWithDouble:[self convertFromUnit:self->unit toUnit:unitToConvert value:self->operand]] forKey:unitToConvert];
        }
    }
    return [NSDictionary dictionaryWithDictionary:result];
}

- (NSArray*) availableUnits
{
    NSMutableSet* result = [NSMutableSet set];
    for (NSString* category in unitsByMultiply) {
        NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
        [result addObject:[categoryDict objectForKey:@"BaseUnit"]];
        for (NSString* unitInCategory in [categoryDict objectForKey:@"Units"]) {
            [result addObject:unitInCategory];
        }
    }
    return [NSArray arrayWithArray:[result allObjects]];
    
}


- (NSArray*) getUnitsOfCategory:(NSString*)category
{
    NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
    NSMutableArray* result = [NSMutableArray arrayWithArray:[[categoryDict objectForKey:@"Units"] allKeys] ] ;
    [result addObject:[categoryDict objectForKey:@"BaseUnit"]];
    return [NSArray arrayWithArray:result];
}

- (NSSet*) getCategoriesForUnit:(NSString*)forUnit
{
    NSMutableSet* result = [NSMutableSet set];
    for (NSString* category in unitsByMultiply) {
        NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
        if ([[categoryDict objectForKey:@"BaseUnit"] isEqual:forUnit]){
            [result addObject: category];
        }
        for (NSString* unitInCategory in [categoryDict objectForKey:@"Units"]) {
            if ([unitInCategory isEqual:forUnit]) {
                [result addObject: category];
            }
        }
    }
    return [NSSet setWithSet:result];
}

- (NSString*) getCategoryForUnit:(NSString*)forUnit1 andUnit:(NSString*)forUnit2
{
    NSMutableSet* commonCategories = [NSMutableSet setWithSet:[self getCategoriesForUnit:forUnit1]];
    [commonCategories intersectSet: [self getCategoriesForUnit:forUnit2]];
    return [commonCategories anyObject];
}



- (NSString*) getBaseUnitInCategory:(NSString*)category
{
    NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
    return [categoryDict objectForKey:@"BaseUnit"];
}

-(double) getMultiplierForUnit:(NSString*)forUnit inCategory: (NSString*)category
{
    NSDictionary* categoryDict = [unitsByMultiply objectForKey:category];
    NSNumber* result = [[categoryDict objectForKey:@"Units"] objectForKey:forUnit];
    return [result doubleValue];
}


-(double) convertFromUnit:(NSString*)fromUnit toUnit:(NSString*)toUnit value:(double)value
{
    NSString* category = [self getCategoryForUnit:unit andUnit:toUnit];
    NSString* baseUnit =  [self getBaseUnitInCategory:category];
    if ([baseUnit isEqualToString:fromUnit]) {
        return value * [self getMultiplierForUnit:toUnit inCategory:category];
    }
    else if ([baseUnit isEqualToString:toUnit]) {
        return value / [self getMultiplierForUnit:fromUnit inCategory:category];
    }
    else {
        double baseValue = [self convertFromUnit:fromUnit toUnit:baseUnit value:value];
        return [self convertFromUnit:baseUnit toUnit:toUnit value:baseValue];
    }
}
//
//-(double) computeRPNResult: (NSString*) rpn
//{
//    int c,err;
//    double x,y;
//    char *q;
//    char *rpstr = "3 6 *";
//    char *p = rpstr;
//    NSMutableArray *stk = [NSMutableArray new];
//#define POP(z)  z = [[stk lastObject] doubleValue]; [stk removeLastObject]
////    const char * rpnCString = "3 6 *"; ///[rpn UTF8String];
//    err = 0;
//    while (NULL!=(q=strtok(p," \t")))  {
//        x = strtod(q,&p);  err = *p;
//        p = NULL;
//        if (err)  {
//            err = q[1] || NULL==strchr("+-*/",*q) || 2>[stk count];
//            NSLog(@"%d,%d,%d",  q[1] , NULL==strchr("+-*/",*q) , 2>[stk count]);
//            if (err)  break;
//            POP(y);  POP(x);
//            switch (*q)  {
//                case '+': x += y; break;
//                case '-': x -= y; break;
//                case '*': x *= y; break;
//                case '/': x /= y;
//            }
//        }
//        [stk addObject:[NSNumber numberWithDouble:x]];
//    }
//    if (err || 1<[stk count])  puts("error");
//    else  if ([stk count])  {
//        POP(x);  
//        printf("%f\n",x);
//    }
//
//return 0;
//}
//
@end
