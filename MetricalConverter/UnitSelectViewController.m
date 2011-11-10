//
//  UnitSelectViewController.m
//  MetricalConverter
//
//  Created by Sergey Klimov on 09.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UnitSelectViewController.h"


@implementation UnitSelectViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Select unit";
}
- (void)viewDidAppear:(BOOL)animated {
    int i = [[self.delegate unitSelectViewControllerAvailableUnits:self] indexOfObject:[self.delegate unitSelectViewControllerCurrentUnit:self]];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:animated  scrollPosition:UITableViewScrollPositionBottom];
}

//dealloc method declared in RootViewController.m
- (void)dealloc {
    [super dealloc];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] init] autorelease];
    }
    
    NSString *unitName = [[self.delegate unitSelectViewControllerAvailableUnits:self] objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = NSLocalizedStringWithDefaultValue(unitName, nil, [NSBundle mainBundle] , unitName, @"unit name localization");
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.delegate unitSelectViewControllerAvailableUnits:self] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellValue = [[self.delegate unitSelectViewControllerAvailableUnits:self] objectAtIndex:indexPath.row];
    [self.delegate unitSelectViewController:self willSetCurrentUnit: cellValue];
}



@end
