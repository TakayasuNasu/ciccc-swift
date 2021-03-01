//
//  main.m
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/24.
//

#import <Foundation/Foundation.h>
#import "ScoreKeeper.h"
#import "InputHandler.h"
#import "Question.h"
#import "QuestionManager.h"
#import "QuestionFactory.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    BOOL onGame = YES;
    NSLog(@"MATHS");

    NSString *right = @"Right!";
    NSString *wrong = @"Wrong!";

    InputHandler *inputHandler = [[InputHandler alloc] init];
    QuestionManager *questionManager = [[QuestionManager alloc] init];
    ScoreKeeper *scoreKeeper = [[ScoreKeeper alloc] init];
    QuestionFactory *factory = [[QuestionFactory alloc] init];

    NSString *startOrCancel = [inputHandler getUserInput:255 And: @"Enter you Answer ('q' to quit): *\n"];
    while (onGame) {
      if ([startOrCancel isEqualToString: @"q"]) {
        break;
      }
      Question *questionAndAnswer = [factory generateRandomQuestion];
      [[questionManager questions] addObject:questionAndAnswer];
      NSLog(@"%@", questionAndAnswer.question);
      NSString *answer = [inputHandler getUserInput:255 And: @""];
      if ([answer isEqual: @"q"]){ break; }
      if ([answer isEqual: @"quit"]){ break; }
      if ([answer intValue] == questionAndAnswer.answer) {
        NSLog(@"%@", right);
        [scoreKeeper setRight: [scoreKeeper right] + 1];
      } else {
        NSLog(@"%@", wrong);
        [scoreKeeper setWrong: [scoreKeeper wrong] + 1];
      }
    }
    NSInteger ratio = [scoreKeeper right] * 100 / ([scoreKeeper right] + [scoreKeeper wrong]);
    NSLog(@"score: %ld right, %ld wrong ---- %ld%%", (long)[scoreKeeper right], (long)[scoreKeeper wrong], (long)ratio);
    NSString *totalTime = [questionManager timeOutput];
    NSLog(@"%@", totalTime);
  }
  return 0;
}
