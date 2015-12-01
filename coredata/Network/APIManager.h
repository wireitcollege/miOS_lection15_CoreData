//
//  APIManager.h
//  coredata
//
//  Created by Admin on 11/25/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country+CoreDataProperties.h"

typedef void(^APIManagerErrorBlock)(NSError *error);

@interface APIManager : NSObject

+ (instancetype)defaultManager;

@property (nonatomic, strong, readonly) NSURLSession *session;
@property (nonatomic, copy) APIManagerErrorBlock onError;

- (void)loadCountries:(void (^)())completion;

@end
