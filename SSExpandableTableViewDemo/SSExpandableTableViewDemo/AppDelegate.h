//
//  AppDelegate.h
//  SSExpandableTableViewDemo
//
//  Created by Shivam Sevarik on 10/03/17.
//  Copyright © 2017 Shivam Sevarik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

