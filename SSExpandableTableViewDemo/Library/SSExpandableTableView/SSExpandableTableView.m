//
//  SSExpandableTableView.m
//  TestingApp
//
//  Created by Shivam Sevarik on 01/03/17.
//  Copyright © 2017 Shivam Sevarik. All rights reserved.
//

#import "SSExpandableTableView.h"



@implementation SSExpandableTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [ super initWithCoder:aDecoder ];
    if (self)
    {
        [ self setup ];
    }
    return self;
}
#pragma mark Helper Methods
- (void)setup
{
    self.delegate = self;
    self.dataSource = self;
    self.marrCollapsedSections = [ NSMutableArray new ];
}
- (void)setAllParentsExpanded:(BOOL)value
{
    if ( !value )
    {
        for (NSInteger row = 0; row < [ _expandableTableDelegate numberOfParentCellsInTable:self ]; row ++)
        {
            [ self.marrCollapsedSections addObject:[ NSNumber numberWithInteger:row ] ];
        }
    }
    self.isAllExpanded = value;
}
- (void)setSpecificParentsExpanded:(NSArray *)sections
{
    if ( !self.isAllExpanded)
    {
        for (NSString *parent in sections)
        {
            if ( ![ self.marrCollapsedSections containsObject:[ NSNumber numberWithInteger:[ parent integerValue ] ] ] )
            {
                [ self.marrCollapsedSections addObject:[ NSNumber numberWithInteger:[parent integerValue] ] ];
            }
            else
            {
                [ self.marrCollapsedSections removeObject:[ NSNumber numberWithInteger:[parent integerValue] ] ];
            }
        }
    }
}

#pragma mark Tableview Data Source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.row == 0)
    {
        height = [ _expandableTableDelegate heightForParentAtIndex:indexPath.row InTable:self ];
    }
    else
    {
        height = [ _expandableTableDelegate heightForChildAtIndex:indexPath.row InParentAtIndex:indexPath.section InTable:self ];
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [ _expandableTableDelegate numberOfParentCellsInTable:self ];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([ self.marrCollapsedSections containsObject:[ NSNumber numberWithInteger:section ] ])
    {
        return 1;
    }
    else
    {
       return [ _expandableTableDelegate numberOfChildCellsInParent:section InTable:self ] + 1;
       // Adding 1 so that First cell will become parent cell
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 )
    {
        return [ _expandableTableDelegate parentCellForParentAtIndex:indexPath.section InTable:self ];
    }
    else
    {
        return [ _expandableTableDelegate childCellForChildAtIndex:indexPath.row ForParentAtIndex:indexPath.section InTable:self ];
    }
}
#pragma mark Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ _expandableTableDelegate didSelectChildAtIndex:indexPath.row OfParentAtIndex:indexPath.section InTable:self ];
    if (indexPath.row == 0)
    {
        [ self showHideChildCellsAtIndexPath:indexPath ];
    }
}

- (void)showHideChildCellsAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger totalRowsInSection = [ _expandableTableDelegate numberOfChildCellsInParent:indexPath.section InTable:self ];
    NSMutableArray *marrIndexpaths = [ NSMutableArray new ];
    for (int row = 1 ; row <= totalRowsInSection ; row ++ )
    {
        [ marrIndexpaths addObject:[ NSIndexPath indexPathForRow:row inSection:indexPath.section ] ];
    }
    if (marrIndexpaths.count > 0)
    {
        [self beginUpdates];
        if (![self.marrCollapsedSections containsObject:[ NSNumber numberWithInteger:indexPath.section ]] )
        {
            [ self.marrCollapsedSections addObject:[ NSNumber numberWithInteger:indexPath.section ] ];
            [self deleteRowsAtIndexPaths:marrIndexpaths withRowAnimation:[ self getCollapsedParentRowAnimation ]];
        }
        else
        {
            [ self.marrCollapsedSections removeObject:[ NSNumber numberWithInteger:indexPath.section ] ];
            [self insertRowsAtIndexPaths:marrIndexpaths withRowAnimation:[ self getExpandParentRowAnimation ]];
        }
        [self endUpdates];
    }
}
#pragma mark Row Animations
- ( void )setExpandParentAnimation:(SSTableViewRowAnimation)ExpandParentAnimation
{
    self.expandAnimation = ExpandParentAnimation;
}
- ( void )setCollapsedParentAnimation:(SSTableViewRowAnimation)CollapsedParentAnimation
{
    self.collapseAnimation = CollapsedParentAnimation;
}
- ( UITableViewRowAnimation )getExpandParentRowAnimation
{
    
    switch (self.expandAnimation)
    {
        case SSTableViewRowAnimationTop:
        {
            return UITableViewRowAnimationTop;
        }
            break;
        case SSTableViewRowAnimationBottom:
        {
            return UITableViewRowAnimationBottom;
        }
            break;
        case SSTableViewRowAnimationFade:
        {
            return UITableViewRowAnimationFade;
        }
            break;
        case SSTableViewRowAnimationLeft:
        {
            return UITableViewRowAnimationLeft;
        }
            break;
        case SSTableViewRowAnimationNone:
        {
            return UITableViewRowAnimationNone;
        }
            break;
        case SSTableViewRowAnimationRight:
        {
            return UITableViewRowAnimationRight;
        }
            break;
        case SSTableViewRowAnimationMiddle:
        {
            return UITableViewRowAnimationMiddle;
        }
            break;
        case SSTableViewRowAnimationAutomatic:
        {
            return UITableViewRowAnimationAutomatic;
        }
            break;
            
        default:
        {
            return UITableViewRowAnimationTop;
        }
            break;
    }
}
- ( UITableViewRowAnimation )getCollapsedParentRowAnimation
{
    
    switch (self.collapseAnimation)
    {
        case SSTableViewRowAnimationTop:
        {
            return UITableViewRowAnimationTop;
        }
            break;
        case SSTableViewRowAnimationBottom:
        {
            return UITableViewRowAnimationBottom;
        }
            break;
        case SSTableViewRowAnimationFade:
        {
            return UITableViewRowAnimationFade;
        }
            break;
        case SSTableViewRowAnimationLeft:
        {
            return UITableViewRowAnimationLeft;
        }
            break;
        case SSTableViewRowAnimationNone:
        {
            return UITableViewRowAnimationNone;
        }
            break;
        case SSTableViewRowAnimationRight:
        {
            return UITableViewRowAnimationRight;
        }
            break;
        case SSTableViewRowAnimationMiddle:
        {
            return UITableViewRowAnimationMiddle;
        }
            break;
        case SSTableViewRowAnimationAutomatic:
        {
            return UITableViewRowAnimationAutomatic;
        }
            break;
            
        default:
        {
            return UITableViewRowAnimationTop;
        }
            break;
    }
}
@end
