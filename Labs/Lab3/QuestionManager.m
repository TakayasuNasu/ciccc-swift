//
//  QuestionManager.m
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import "QuestionManager.h"
#import "Question.h"

@implementation QuestionManager

- (instancetype)init
{
  self = [super init];
  if (self) {
    _questions = [NSMutableArray array];
  }
  return self;
}

- (NSString*)timeOutput
{
  int count = 0;
  float totalTime = 0;
  for (Question* q in [self questions]){
    totalTime += [q answerTime];
    count++;
  }
  float averageTime = floor(totalTime/count);

  return [NSString stringWithFormat:@"total time: %.fs, average time: %.fs",totalTime,averageTime];
}

@end
