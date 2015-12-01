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
+ (instancetype)createEntityInContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)request;
+ (NSFetchRequest *)requestSortingBy:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;
+ (NSFetchRequest *)requestWithSortDescriptors:(NSArray *)terms withPredicate:(NSPredicate *)predicate;
+ (NSFetchedResultsController *)fetchedResulttWithSortDescriptors:(NSArray *)terms predicate:(NSPredicate *)predicate groupedBy:(NSString *)sectionName;
+ (NSFetchedResultsController *)fetchedResultSortingBy:(NSString *)key ascending:(BOOL)ascending predicate:(NSPredicate *)predicate groupedBy:(NSString *)sectionName;

@end
