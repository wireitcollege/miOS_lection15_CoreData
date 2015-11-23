//
//  NSManagedObject+ActiveDirectory.h
//  coredata
//
//  Created by Admin on 11/23/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ActiveDirectory)

+ (instancetype)createEntity;
+ (NSFetchRequest *)request;
+ (NSFetchRequest *)requestSortingBy:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;
+ (NSFetchedResultsController *)fetchedResultSortingBy:(NSString *)key ascending:(BOOL)ascending predicate:(NSPredicate *)predicate groupedBy:(NSString *)sectionName;

@end
