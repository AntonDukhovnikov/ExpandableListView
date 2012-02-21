//
//  ExpandableTableView.h
//  ExpandableCellsTestApp
//
//  Created by Anton Dukhovnikov on 18/02/12.
//  Copyright (c) 2012 Anton Dukhovnikov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ExpandableListView;

/// @brief Data source for expandable list view. Data source should implement three mandatory methods returning number of views, view for given index, title of view at given index.
@protocol ExpandableListDataSource <NSObject>

/// Method returning number of views to show in expandable list.
/// @param listView list view requesting information
/// @return number of views
- (NSInteger) numberOfViewsInExpandableList:(ExpandableListView *)listView;

/// Method returning title of view to show in expandable list an given index.
/// @param listView list view requesting information
/// @param index index of requested view
- (NSString *)expandableList:(ExpandableListView *)listView titleAtIndex:(NSInteger)index;

/// Method returning view to show in expandable list an given index.
/// @param listView list view requesting information
/// @param index index of requested view
- (NSView *)expandableList:(ExpandableListView *)listView viewAtIndex:(NSInteger)index;
@end

/// @brief ExpandableListView is a visual component displaying list of views which can be expanded/collapsed by user clicking on view's header. Example of such behavior is the Inspector in XCode.
@interface ExpandableListView : NSView

/// Data source for expandable list. This property is declared as IBOutlet so it can be set in Interface Builder.
@property (nonatomic, assign) IBOutlet id <ExpandableListDataSource> dataSource;

/// Method to refresh list content if some data in data source was changed.
- (void)reloadData;
@end
