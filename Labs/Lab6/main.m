//
//  main.m
//  Lab6
//
//  Created by Takayasu Nasu on 2021/02/28.
//

#import <Foundation/Foundation.h>
#import "Dice.h"
#import "GameController.h"
#import "InputHandler.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    InputHandler *inputHandler = [[InputHandler alloc] init];
    GameController *gameController = [[GameController alloc] init];
    [gameController rollDice];
    [gameController displayCurrentStats];

    while (YES) {
      if ([gameController rollCount] >= 5){
        [gameController displayFinalStats];
        break;
      }
      [GameController displayCommandLists];

      NSString *userCommand = [inputHandler getUserInput:255 And: @"Enter your request: "];

      if ([userCommand isEqualToString:@"roll"]){
        [gameController rollDice];
      }else if ([userCommand isEqualToString:@"hold"]){
        NSString *selectedDice = [inputHandler getUserInput:255 And:@"Enter the dice you want to hold/un-hold:"];
        NSNumber *tmp = [[[NSNumberFormatter alloc] init] numberFromString: selectedDice];
        NSNumber *selectedIndex = [NSNumber numberWithInt:[tmp intValue] -1];
        [gameController holdDiceWithIndex: selectedIndex];
      }else if ([userCommand isEqualToString:@"reset"]){
        [gameController resetDice];
      }else if ([userCommand isEqualToString:@"done"]){
        [gameController displayFinalStats];
        break;
      }else if ([userCommand isEqualToString:@"display"]){
        [gameController displayCurrentStats];
      }

      [gameController displayCurrentStats];
    }
  }
  return 0;
}
