//
//  Cache.m
//  ProjectDico
//
//  Created by Nicole Zhu on 5/31/14.
//  Copyright (c) 2014 ProjectDico. All rights reserved.
//

#import "Cache.h"

@interface Cache()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation Cache

@synthesize cache;

#pragma mark - Initialization

+ (id)sharedCache {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

#pragma mark - PAPCache

- (void)clear {
    [self.cache removeAllObjects];
}


#pragma mark - ()

- (NSString *)keyForUser:(PFUser *)user {
    return [NSString stringWithFormat:@"user_%@", [user objectId]];
}

- (void)setAttributes:(NSDictionary *)attributes forUser:(PFUser *)user {
    NSString *key = [self keyForUser:user];
    [self.cache setObject:attributes forKey:key];
}
@end
