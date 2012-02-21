# ExpandableListView

Expandable list view is Apple Cocoa visual component for displaying expandable/collapsible lists of views. Example of such behavior is Inspector panel in Xcode. I was unable to find standard component with similar functionality so decided to make my own.

Repository contains class source and test application.

Using of the component is quite easy. In order to add expandable list into project next steps should be performed:

* Add ExpandableListView.h/c into project
* Create ExpandableListView instance programmatically, or add NSView into Interface Builder and set it's class name to ExpandableListView.
* Implement expandable list view data source. It's very easy. It should only provide number of views to show, title of view at given number, view at given number. If ExpandableListView was created via InterfaceBuilder, it's data source can be set by IBOutlet.
* Create all views which should be shown in list. There are no particular requirements to these views. Any NSView's descendant should work fine. These views can be designed via Interface Builder as well.
* When all views are prepared, call [ExpandableListView reloadData].

Test application shows how to do it. In this application 3 custom views are prepared in Interface Builder and added into list.

## Hints and tips.

* All subviews of views intended to be added into list should have proper autoresizing masks. View items will be automatically resized if list view's size changed.
* Views' autoresizing masks can be any, because they are overrided when views are added to list. This is done to be sure that the list is displayed correctly when it was resized.
* Class are written using manual reference counting. It can be converted to ARC or garbage collected very easily.  

## License.

BSD-style license. See License.txt

## TODO

* Add disclosure triangle to header view. AppKit does not provide image for down-pointed triangle in standard resources, and I don't want to add custom resources to keep code integration simple. I will resort code to draw triangle programmatically a little bit later.  