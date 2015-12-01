//
//  APIManager.m
//  coredata
//
//  Created by Admin on 11/25/15.
//  Copyright © 2015 Wire IT College. All rights reserved.
//

#import "APIManager.h"
#import "Country+JSONMapping.h"
#import "NSManagedObjectContext+MainContext.h"

static NSString *const kBaseUrl = @"https://restcountries.eu/rest/v1/all";
static NSString *const kSessionIdentifier = @"BackgroundSession";

@interface APIManager () <NSURLSessionDelegate>
@property (nonatomic, strong, readwrite) NSURLSession *session;
@end

@implementation APIManager

+ (instancetype)defaultManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManager alloc] init];
    });
    return instance;
}

- (void)loadCountries:(void (^)())completion {
    [self executeRequest:^(id response, NSError *error) {

        if (!error && [response isKindOfClass:[NSArray class]]) {
            NSManagedObjectContext *childContext = [NSManagedObjectContext childContext];
            [childContext performBlockAndWait:^{
                [Country loadObjectsInCoreData:response inContext:childContext];
                [childContext save:NULL];
            }];
            
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    }];
}

#pragma mark - Execute Request

- (void)executeRequest:(void (^)(id response, NSError *error))completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kBaseUrl]];
    
    NSURLSessionDataTask *task = [self.session
                                  dataTaskWithRequest:request
                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        id result = data;
        if (!error && data.length) {
            NSError *jsonError;
            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            error = jsonError;
        } else {
            self.onError(error);
        }
        
        if (completion) {
            completion(result, error);
        }
    }];
    [task resume];
}

#pragma mark - Session

- (NSURLSession *)session {
    if (!_session) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
            configuration.allowsCellularAccess = NO;
            
            _session = [NSURLSession sessionWithConfiguration:configuration
                                                     delegate:self
                                                delegateQueue:nil];
        });
    }
    return _session;
}

@end
