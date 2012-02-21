//
//  AppDelegate.m
//  ExpandableCellsTestApp
//
//  Created by Anton Dukhovnikov on 18/02/12.
//  Copyright (c) 2012 Anton Dukhovnikov. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize cell1, cell2, cell3;
@synthesize listView;

- (void)dealloc
{
    [cell1 release];
    [cell2 release];
    [cell3 release];
    [listView release];    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [listView reloadData];
}

- (NSInteger) numberOfViewsInExpandableList:(ExpandableListView *)listView
{
    return 3;
}

- (NSString *)expandableList:(ExpandableListView *)listView titleAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:  return @"First view";
        case 1:  return @"Second view";
        default: return @"Third view";
    }
}

- (NSView *)expandableList:(ExpandableListView *)listView viewAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:  return cell1;
        case 1:  return cell2;
        default: return cell3;
    }
}


@end
