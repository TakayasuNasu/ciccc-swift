//
//  Question.h
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Question: NSObject

@property (nonatomic) NSString* question;
@property (nonatomic) NSInteger answer;
@property (nonatomic) NSDate* startTime;
@property (nonatomic) NSDate* endTime;
@property (nonatomic, assign) NSInteger leftValue;
@property (nonatomic, assign) NSInteger rightValue;

- (NSTimeInterval) answerTime;

@end

NS_ASSUME_NONNULL_END
