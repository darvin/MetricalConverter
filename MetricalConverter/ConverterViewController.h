//
//  ConverterViewController.h
//  MetricalConverter
//
//  Created by Sergey Klimov on 05.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Converter.h"

@interface ConverterViewController : UIViewController
{
    Converter * converter;
    IBOutlet UILabel* unit;
}

-(IBAction)unitChanged:(id)sender;
-(IBAction)valueChanged:(UITextField *)sender;


@end
