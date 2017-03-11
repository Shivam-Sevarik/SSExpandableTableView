//
//  SSExpandableTableView.h
//  TestingApp
//
//  Created by Shivam Sevarik on 01/03/17.
//  Copyright © 2017 Shivam Sevarik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSExpandableTableView;

@protocol SSExpandableTableViewDelegate <NSObject>

@required
- (NSInteger)numberOfParentCellsInTable:(SSExpandableTableView *)tablview;
- (NSInteger)numberOfChildCellsInParent:(NSInteger)parent InTable:(SSExpandableTableView *)tablview;
- (UITableViewCell *)parentCellForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview;
- (UITableViewCell *)childCellForChildAtIndex:(NSInteger)child ForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview;


@optional
- (void)didSelectChildAtIndex:(NSInteger)child OfParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview;
- (CGFloat)heightForParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview;
- (CGFloat)heightForChildAtIndex:(NSInteger)child InParentAtIndex:(NSInteger)parent InTable:(SSExpandableTableView *)tablview;
@end
typedef enum
{
    SSTableViewRowAnimationFade,
    SSTableViewRowAnimationRight,
    SSTableViewRowAnimationLeft,
    SSTableViewRowAnimationTop,
    SSTableViewRowAnimationBottom,
    SSTableViewRowAnimationNone,
    SSTableViewRowAnimationMiddle,
    SSTableViewRowAnimationAutomatic = 100
} SSTableViewRowAnimation;

@interface SSExpandableTableView : UITableView< UITableViewDataSource, UITableViewDelegate >
@property (strong, nonatomic) id <SSExpandableTableViewDelegate> expandableTableDelegate;
@property (strong, nonatomic) NSMutableArray *marrCollapsedSections;
@property (nonatomic) BOOL isAllExpanded;
@property (nonatomic) SSTableViewRowAnimation collapseAnimation,expandAnimation;
- (void)setAllParentsExpanded:(BOOL)value;
- (void)setSpecificParentsExpanded:(NSArray *)sections;
- ( void )setExpandParentAnimation:(SSTableViewRowAnimation)ExpandParentAnimation;
- ( void )setCollapsedParentAnimation:(SSTableViewRowAnimation)CollapsedParentAnimation;
@end
