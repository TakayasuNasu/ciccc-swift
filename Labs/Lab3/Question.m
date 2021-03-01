//
//  Question.h
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import "Question.h"


@implementation Question

- (instancetype)init{

  if (self = [super init]){
    _startTime = [NSDate date];

    _leftValue = arc4random_uniform(100);
    _rightValue = arc4random_uniform(100);

  }

  return self;
}

- (NSInteger) answer
{
  _endTime = [NSDate date];
  return _answer;
}

- (NSTimeInterval) answerTime
{
  NSTimeInterval duration = [_endTime timeIntervalSinceDate:_startTime];
  return duration;
}

@end
