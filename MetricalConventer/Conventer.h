//
//  Conventer.h
//  MetricalConventer
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conventer : NSObject
{
@private
    double operand;
    NSString* unit;
    NSDictionary* unitsByMultiply;
}

- (NSArray*) availableUnits;
- (NSDictionary*) getConventered;

@property double operand;
@property (copy) NSString* unit;
@property (readonly) NSArray* availableUnits;
@end

