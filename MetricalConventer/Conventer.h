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
    double operand;
    NSString* unit;
    NSDictionary* unitsByMultiply;
}

- (void) setOperand:(double)operandToSet;
- (void) setUnit:(NSString*)unitToSet;
- (NSArray*) availableUnits;
- (NSDictionary*) getConventered;
@end
