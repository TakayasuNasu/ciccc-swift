//
//  SubtractionQuestion.m
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/28.
//

#import "SubtractionQuestion.h"

@implementation SubtractionQuestion

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self generateQuestion];
  }
  return self;
}

 -(void)generateQuestion
{
  [self setQuestion:[NSString stringWithFormat:@"%d - %d ?", (int)[self leftValue], (int)[self rightValue]]];
  [self setAnswer:[self leftValue] - [self rightValue]];
}

@end
