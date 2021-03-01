//
//  QuestionManager.h
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionManager : NSObject

@property NSMutableArray *questions;

- (NSString *) timeOutput;

@end

NS_ASSUME_NONNULL_END
