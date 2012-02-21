//
//  AppDelegate.h
//  ExpandableCellsTestApp
//
//  Created by Anton Dukhovnikov on 18/02/12.
//  Copyright (c) 2012 Anton Dukhovnikov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ExpandableListView.h"

//@class ExpandableTableView;

@interface AppDelegate : NSObject <NSApplicationDelegate, ExpandableListDataSource>

@property (assign) IBOutlet NSWindow *window;

@property (nonatomic, retain) IBOutlet NSView *cell1;
@property (nonatomic, retain) IBOutlet NSView *cell2;
@property (nonatomic, retain) IBOutlet NSView *cell3;
@property (nonatomic, retain) IBOutlet ExpandableListView *listView;

@end
