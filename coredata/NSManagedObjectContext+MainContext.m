//
//  NSManagedObjectContext+MainContext.m
//  coredata
//
//  Created by Admin on 11/18/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "NSManagedObjectContext+MainContext.h"
#import "AppDelegate.h"

@implementation NSManagedObjectContext (MainContext)

+ (instancetype)mainContext {
    return [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
}

+ (instancetype)childContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = [self mainContext];
    return context;
}

- (void)saveContext {
    [(AppDelegate *)[UIApplication sharedApplication].delegate saveContext];
}

@end
