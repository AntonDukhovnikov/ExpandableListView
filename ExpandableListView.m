//
//  ExpandableTableView.m
//  ExpandableCellsTestApp
//
//  Created by Anton Dukhovnikov on 18/02/12.
//  Copyright (c) 2012 Anton Dukhovnikov. All rights reserved.
//

#define BUTTON_HEIGHT 23.0f

#import "ExpandableListView.h"

// Internal class. Simple NSView with flipped geometry. (0,0) is top left corner.
@interface FlippedView : NSView
@end

@implementation FlippedView
- (BOOL)isFlipped { return YES; }
@end

// Internal class. The container for list element. 
@interface ExpandableItemView : FlippedView
{
    BOOL expanded;
    NSView *contentView;
    NSButton *disclosureButton;
    NSTextField *label;
}
@end

@implementation ExpandableItemView

- (id)initWithContentView:(NSView *)view
{
    NSUInteger autoresizingMask = NSViewWidthSizable;// | NSViewMinXMargin | NSViewMaxXMargin;
    
    NSRect frame = view.frame;
    frame.origin.x = 0.0f;
    frame.origin.y = 0.0f;
    frame.size.height += BUTTON_HEIGHT;
    
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setAutoresizingMask:autoresizingMask];
        
        frame.origin.y += BUTTON_HEIGHT;
        frame.size.height -= BUTTON_HEIGHT;
        
        expanded = YES;
        contentView = [view retain];
        [contentView setAutoresizingMask:autoresizingMask];
        [contentView setFrame:frame];
        [self addSubview:contentView];
        
        frame.origin.y = 0.0f;  
        frame.size.height = BUTTON_HEIGHT;
        disclosureButton = [[NSButton alloc] initWithFrame:frame];
        [disclosureButton setBezelStyle:NSSmallSquareBezelStyle];
        [disclosureButton setAutoresizingMask:autoresizingMask];
        [disclosureButton setTarget:self];
        [disclosureButton setAction:@selector(toggle)];
        [self addSubview:disclosureButton];
    }
    
    return self;
}

- (void)toggle
{
    expanded = !expanded;
    
    NSRect frame = self.frame;
    frame.size.height = BUTTON_HEIGHT;
    
    if (expanded)
    {
        frame.size.height += contentView.frame.size.height;
    }
    
    self.frame = frame;
    [contentView setHidden:!expanded];
    [self.superview setNeedsLayout:YES];
    [self.superview layoutSubtreeIfNeeded];
}

- (void)setTitle:(NSString *)title
{
    [disclosureButton setTitle:title];
}

- (void)dealloc
{
    [disclosureButton release];
    [label release];
    [contentView release];
    [super dealloc];
}

@end

// Main class implementation.
@interface ListContainerView : FlippedView 
@end

@implementation ListContainerView

- (void)layout
{
    NSRect frame = self.frame;
    float height = 0.0f;
    
    for (NSView *view in self.subviews)
    {
        frame.origin.y = height;
        frame.size.height = view.frame.size.height;
        view.frame = frame;
    
        height += frame.size.height;
    }
    
    frame.origin.y = 0.0f;
    frame.size.height = height;
    self.frame = frame;    
    
    [super layout];
}
@end

@interface ExpandableListView ()
{
@private
    NSView *containerView;
}
@end

@implementation ExpandableListView
@synthesize dataSource;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        containerView = [[ListContainerView alloc] initWithFrame:self.bounds];
        [containerView setAutoresizingMask:NSViewWidthSizable];
        
        NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.bounds];
        [scrollView setDocumentView:containerView];
        [scrollView setHasVerticalScroller:YES];
        [scrollView setHasHorizontalScroller:NO];
        [scrollView setDrawsBackground:NO];
        [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable ];
        
        [self addSubview:scrollView];
        [scrollView release];
    }
    
    return self;
}

- (void)reloadData
{
    while ([[containerView subviews] count])
        [[[containerView subviews] lastObject] removeFromSuperviewWithoutNeedingDisplay];

    NSInteger count = [dataSource numberOfViewsInExpandableList:self];    
    for (NSInteger index = 0; index < count; index++)
    {
        NSView *view = [dataSource expandableList:self viewAtIndex:index];
        
        ExpandableItemView *view1 = [[ExpandableItemView alloc] initWithContentView:view];
        
        [view1 setTitle:[dataSource expandableList:self titleAtIndex:index]];
        [containerView addSubview:view1];  
        [view1 release];
    }
    
    [containerView setNeedsLayout:YES];
    [containerView layoutSubtreeIfNeeded];
}

- (void)dealloc
{
    [containerView release];
    [self dealloc];
}

@end
