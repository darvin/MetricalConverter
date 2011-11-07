//
//  Converter.h
//  MetricalConverter
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Converter : NSObject
{
@private
    double operand;
    NSString* unit;
    NSDictionary* unitsByMultiply;
}

- (NSArray*) availableUnits;
- (NSDictionary*) getConvertered;

@property double operand;
@property (copy) NSString* unit;
@property (readonly) NSArray* availableUnits;
@end

