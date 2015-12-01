//
//  NSManagedObject+ActiveDirectory.m
//  coredata
//
//  Created by Admin on 11/23/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "NSManagedObject+ActiveDirectory.h"
#import "NSManagedObjectContext+MainContext.h"

@implementation NSManagedObject (ActiveDirectory)

+ (NSString *)entityName {
    return NSStringFromClass(self);
}

+ (instancetype)createEntity {
    return [self createEntityInContext:[NSManagedObjectContext mainContext]];
}

+ (instancetype)createEntityInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+ (NSFetchRequest *)request {
    return [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
}

+ (NSFetchRequest *)requestSortingBy:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate {
    NSArray *terms = @[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
    return [self requestWithSortDescriptors:terms withPredicate:predicate];
}

+ (NSFetchRequest *)requestWithSortDescriptors:(NSArray *)terms withPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [self request];
    request.sortDescriptors = terms;
    request.predicate = predicate;
    return request;
}

+ (NSFetchedResultsController *)fetchedResulttWithSortDescriptors:(NSArray *)terms predicate:(NSPredicate *)predicate groupedBy:(NSString *)sectionName {
    NSFetchRequest *request = [self requestWithSortDescriptors:terms withPredicate:predicate];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext mainContext] sectionNameKeyPath:sectionName cacheName:nil];
    NSError *error;
    if (![controller performFetch:&error]) {
        NSLog(@"%@", error);
    }
    
    return controller;
}

+ (NSFetchedResultsController *)fetchedResultSortingBy:(NSString *)key ascending:(BOOL)ascending predicate:(NSPredicate *)predicate groupedBy:(NSString *)sectionName {
    NSArray *terms = @[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
    return [self fetchedResulttWithSortDescriptors:terms predicate:predicate groupedBy:sectionName];
}

@end
