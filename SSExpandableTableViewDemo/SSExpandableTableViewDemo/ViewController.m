//
//  ViewController.m
//  SSExpandableTableViewDemo
//
//  Created by Shivam Sevarik on 10/03/17.
//  Copyright © 2017 Shivam Sevarik. All rights reserved.
//

#import "ViewController.h"
#import "SSExpandableTableView.h"

@interface ViewController ()< SSExpandableTableViewDelegate >
@property (strong, nonatomic) IBOutlet SSExpandableTableView *tableExpandable;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableExpandable.expandableTableDelegate = self;
    [ _tableExpandable setAllParentsExpanded:NO ];
    [ _tableExpandable setSpecificParentsExpanded:@[@"0"] ];
    [ _tableExpandable setCollapsedParentAnimation:SSTableViewRowAnimationAutomatic ];
    [ _tableExpandable setExpandParentAnimation:SSTableViewRowAnimationRight ];
}
#pragma mark SSExpandableTableView Delegate
- (CGFloat)heightForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    return 50.0f;
}
- (CGFloat)heightForChildAtIndex:(NSInteger)child InParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    return 40.0f;
}
- (NSInteger)numberOfParentCellsInTable:(SSExpandableTableView *)tablview
{
    return 2;
}
- (NSInteger)numberOfChildCellsInParent:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    if (parent == 0)
    {
        return 3;
    }
    else
    {
        return 3;
    }
}

- (void)didSelectChildAtIndex:(NSInteger)child OfParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    NSLog(@"Parent %lu Child %lu",(unsigned long)parent,(unsigned long)child);
}

#pragma mark SSExpandableTableView DataSource
- (UITableViewCell *)parentCellForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    UITableViewCell *cell = [ tablview dequeueReusableCellWithIdentifier:@"ParentCell" ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)childCellForChildAtIndex:(NSInteger)child ForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview
{
    UITableViewCell *cell = [ tablview dequeueReusableCellWithIdentifier:@"ChildCell" ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
