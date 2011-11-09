//
//  UnitSelectViewController.h
//  MetricalConverter
//
//  Created by Sergey Klimov on 09.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConverterViewController.h"
@interface UnitSelectViewController : UITableViewController
{
    
    id<ConverterViewControllerDelegate> converterViewControllerDelegate;
}
@property (assign) id<ConverterViewControllerDelegate> converterViewControllerDelegate;

@end
