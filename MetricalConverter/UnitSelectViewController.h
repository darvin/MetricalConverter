//
//  UnitSelectViewController.h
//  MetricalConverter
//
//  Created by Sergey Klimov on 09.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnitSelectViewController;
@protocol UnitSelectViewControllerDelegate <NSObject>

- (NSArray*)unitSelectViewControllerAvailableUnits:(UnitSelectViewController *)unitSelectViewController;
- (NSString*)unitSelectViewControllerCurrentUnit:(UnitSelectViewController *)unitSelectViewController ;
- (void)unitSelectViewController:(UnitSelectViewController *)unitSelectViewController willSetCurrentUnit:(NSString*) newCurrentUnit;


@end

@interface UnitSelectViewController : UITableViewController
{
    
    id<UnitSelectViewControllerDelegate> delegate;
}
@property (assign) id<UnitSelectViewControllerDelegate> delegate;

@end
