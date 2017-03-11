# SSExpandableTableView
An customisable Expandable Tableview.

SSExpandableTableView is subclass extended from UITableView. It is created as Parent-Child  relationship in Table. 
User can use any designed UITableViewCell for parent as well as for child or any subclass of the same.

Usage:-
Drag and Drop SSExpandableTableView.h and .m in xcode project.
Import SSExpandableTableView.h in ViewController where you want to use TableView.
Import SSExpandableTableViewDelegate in Interface.
Set Class as SSExpandableTableView in place of UITableView class storyboard.See Screenshot fig2.
Set SSExpandableTableViewDelegate.

Set Number of parents
- (NSInteger)numberOfParentCellsInTable:(SSExpandableTableView *)tablview
{
    return 2;
}

Set Number of Childs with respect to parents
- (NSInteger)numberOfChildCellsInParent:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    return 3;
}

Set Height of Parent Rows
- (CGFloat)heightForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    return 50.0f;
}

Set Height of Child Rows
- (CGFloat)heightForChildAtIndex:(NSInteger)child InParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    return 40.0f;
}

Give Cells for Parent Cells
- (UITableViewCell *)parentCellForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    UITableViewCell *cell = [ tablview dequeueReusableCellWithIdentifier:@"ParentCell" ];
    return cell;
}

Give Cells for Child Cells
- (UITableViewCell *)childCellForChildAtIndex:(NSInteger)child ForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    UITableViewCell *cell = [ tablview dequeueReusableCellWithIdentifier:@"ChildCell" ];
    return cell;
}

Set this Methods as per convenience 

Use this Method to receive tap action on parent and childs
- (void)didSelectChildAtIndex:(NSInteger)child OfParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    NSLog(@"Parent %lu Child %lu",(unsigned long)parent,(unsigned long)child);
}

Use "setAllParentsExpanded:YES/NO" to set show all childs.  
example:-    [ _tableExpandable setAllParentsExpanded:NO ];

Use "setSpecificParentsExpanded" to show specific childs.Pass string array.
example:-    [ _tableExpandable setSpecificParentsExpanded:@[@"0"] ];

Use "setCollapsedParentAnimation" and "setExpandParentAnimation" to set collapsed/expanded row animations.
    [ _tableExpandable setCollapsedParentAnimation:SSTableViewRowAnimationAutomatic ];
    [ _tableExpandable setExpandParentAnimation:SSTableViewRowAnimationRight ];

See SSExpandableTableViewDemo project for reference.