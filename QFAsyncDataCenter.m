//
//  QFAsyncDataCenter.m
//  QFAsyncDataCenter
//
//  Created by dqf on 2017/8/25.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "QFAsyncDataCenter.h"
#import "AppDelegate.h"

@interface QFAsyncDataCenter ()
@property (nonatomic) NSMutableDictionary *mutableDict;
@end

@implementation QFAsyncDataCenter

- (NSMutableDictionary *)mutableDict {
    if (!_mutableDict) {
        _mutableDict = [NSMutableDictionary dictionary];
    }
    return _mutableDict;
}

+ (QFAsyncDataCenter *)share {
    static dispatch_once_t predicate;
    static QFAsyncDataCenter *sm;
    dispatch_once(&predicate, ^{
        sm = [[self alloc] init];
    });
    return sm;
}

- (UIWindow *)rootWindow {
    return [UIApplication sharedApplication].delegate.window;
}

- (UINavigationController *)rootVC {
    return (UINavigationController *)[self rootWindow].rootViewController;
}

- (NSString *)showVC {
    return [self getShowVC:[self rootVC].topViewController];
}

- (NSString *)getShowVC:(UIViewController *)objc {
    NSUInteger count = objc.childViewControllers.count;
    for (int i=0; i<count; i++) {
        UIViewController *vc = objc.childViewControllers[i];
        if (vc.isViewLoaded && vc.view.window && !vc.view.hidden) {
            return [self getShowVC:vc];
        }
    }
    return NSStringFromClass([objc class]);
}

#pragma -set/get

- (void)setObject:(NSString *)anObject forKey:(NSString *)aKey {
    [self.mutableDict setObject:anObject forKey:aKey];
}

- (NSString *)objectForKey:(NSString *)aKey {
    return [self.mutableDict objectForKey:aKey];
}

- (void)removeObjectForKey:(NSString *)aKey {
    if ([self.mutableDict.allKeys containsObject:aKey]) {
        [self.mutableDict removeObjectForKey:aKey];
    }
}

@end

@implementation QFAsyncDataCenter (asyncData)

- (void)setClass:(NSString *)classKey object:(NSString *)anObject key:(NSString *)aKey {
    [self.mutableDict setObject:anObject forKey:classKey.append(aKey)];
}

- (NSString *)objectForClass:(NSString *)classKey key:(NSString *)aKey {
    return [self.mutableDict objectForKey:classKey.append(aKey)];
}

- (void)removeClass:(NSString *)classKey key:(NSString *)aKey {
    [self.mutableDict removeObjectForKey:classKey.append(aKey)];
}

- (void)removeObjectForClass:(NSString *)classKey {
    for (NSInteger i=self.mutableDict.allKeys.count-1; i>=0; i--) {
        NSString *aKey = self.mutableDict.allKeys[i];
        if ([aKey containsString:classKey]) {
            [self.mutableDict removeObjectForKey:aKey];
        }
    }
}


- (NSString *)showVCObjectForKey:(NSString *)aKey {
    return [self objectForClass:[self showVC] key:aKey];
}

- (void)popVC:(UIViewController *)vc {
    [self removeObjectForClass:NSStringFromClass([vc class])];
}

@end

@implementation UIView (asyncData)

- (void)setObject:(NSString *)anObject key:(NSString *)aKey {
    NSString *key = NSStringFromClass([self class]).append(aKey);
    [[QFAsyncDataCenter share].mutableDict setObject:anObject forKey:key];
}

- (NSString *)objectForKey:(NSString *)aKey {
    NSString *key = NSStringFromClass([self class]).append(aKey);
    return [[QFAsyncDataCenter share].mutableDict objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)aKey {
    NSString *key = NSStringFromClass([self class]).append(aKey);
    if ([[QFAsyncDataCenter share].mutableDict.allKeys containsObject:key]) {
        [[QFAsyncDataCenter share].mutableDict removeObjectForKey:key];
    }
}

- (void)removeAllObject {
    NSString *classKey = NSStringFromClass([self class]);
    for (NSInteger i=[QFAsyncDataCenter share].mutableDict.allKeys.count-1; i>=0; i--) {
        NSString *aKey = [QFAsyncDataCenter share].mutableDict.allKeys[i];
        if ([aKey containsString:classKey]) {
            [[QFAsyncDataCenter share].mutableDict removeObjectForKey:aKey];
        }
    }
}

#pragma -class key

- (void)setClass:(NSString *)classKey object:(NSString *)anObject key:(NSString *)aKey {
    [[QFAsyncDataCenter share].mutableDict setObject:anObject forKey:classKey.append(aKey)];
}

- (NSString *)objectForClass:(NSString *)classKey key:(NSString *)aKey {
    return [[QFAsyncDataCenter share].mutableDict objectForKey:classKey.append(aKey)];
}

- (void)removeClass:(NSString *)classKey key:(NSString *)aKey {
    [[QFAsyncDataCenter share].mutableDict removeObjectForKey:classKey.append(aKey)];
}

- (void)removeClass:(NSString *)classKey {
    for (NSInteger i=[QFAsyncDataCenter share].mutableDict.allKeys.count-1; i>=0; i--) {
        NSString *aKey = [QFAsyncDataCenter share].mutableDict.allKeys[i];
        if ([aKey containsString:classKey]) {
            [[QFAsyncDataCenter share].mutableDict removeObjectForKey:aKey];
        }
    }
}

@end

@implementation UIViewController (asyncData)

- (void)setObject:(NSString *)anObject key:(NSString *)aKey {
    NSString *key = NSStringFromClass([self class]).append(aKey);
    [[QFAsyncDataCenter share].mutableDict setObject:anObject forKey:key];
}

- (NSString *)objectForKey:(NSString *)aKey {
    NSString *key = NSStringFromClass([self class]).append(aKey);
    return [[QFAsyncDataCenter share].mutableDict objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)aKey {
    NSString *key = NSStringFromClass([self class]).append(aKey);
    if ([[QFAsyncDataCenter share].mutableDict.allKeys containsObject:key]) {
        [[QFAsyncDataCenter share].mutableDict removeObjectForKey:key];
    }
}

- (void)removeAllObject {
    NSString *classKey = NSStringFromClass([self class]);
    for (NSInteger i=[QFAsyncDataCenter share].mutableDict.allKeys.count-1; i>=0; i--) {
        NSString *aKey = [QFAsyncDataCenter share].mutableDict.allKeys[i];
        if ([aKey containsString:classKey]) {
            [[QFAsyncDataCenter share].mutableDict removeObjectForKey:aKey];
        }
    }
}

#pragma -class key

- (void)setClass:(NSString *)classKey object:(NSString *)anObject key:(NSString *)aKey {
    [[QFAsyncDataCenter share].mutableDict setObject:anObject forKey:classKey.append(aKey)];
}

- (NSString *)objectForClass:(NSString *)classKey key:(NSString *)aKey {
    return [[QFAsyncDataCenter share].mutableDict objectForKey:classKey.append(aKey)];
}

- (void)removeClass:(NSString *)classKey key:(NSString *)aKey {
    [[QFAsyncDataCenter share].mutableDict removeObjectForKey:classKey.append(aKey)];
}

- (void)removeClass:(NSString *)classKey {
    for (NSInteger i=[QFAsyncDataCenter share].mutableDict.allKeys.count-1; i>=0; i--) {
        NSString *aKey = [QFAsyncDataCenter share].mutableDict.allKeys[i];
        if ([aKey containsString:classKey]) {
            [[QFAsyncDataCenter share].mutableDict removeObjectForKey:aKey];
        }
    }
}

@end

@implementation NSString (asyncData)

- (NSString *(^)(id))append {
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:@"%@%@", self,obj];
    };
}

- (NSString *(^)(NSString *, NSString *))replace {
    return ^NSString *(NSString *org1, NSString *org2) {
        return [self stringByReplacingOccurrencesOfString:org1 withString:org2];
    };
}

@end
