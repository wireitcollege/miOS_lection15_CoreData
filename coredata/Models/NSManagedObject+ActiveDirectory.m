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
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:[NSManagedObjectContext mainContext]];
}

+ (NSFetchRequest *)request {
    return [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
}

+ (NSFetchRequest *)requestSortingBy:(NSString *)key ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [self request];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
    request.predicate = predicate;
    return request;
}

+ (NSFetchedResultsController *)fetchedResultSortingBy:(NSString *)key ascending:(BOOL)ascending predicate:(NSPredicate *)predicate groupedBy:(NSString *)sectionName {
    
    NSFetchRequest *request = [self requestSortingBy:key ascending:ascending withPredicate:predicate];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext mainContext] sectionNameKeyPath:sectionName cacheName:nil];
    NSError *error;
    if (![controller performFetch:&error]) {
        NSLog(@"%@", error);
    }
    
    return controller;
}

@end
