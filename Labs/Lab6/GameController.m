//
//  GameController.m
//  Lab6
//
//  Created by Takayasu Nasu on 2021/02/28.
//

#import "GameController.h"

@implementation GameController

- (instancetype) init
{
  self = [super init];
  if (self) {

    NSMutableArray *dices = [[NSMutableArray alloc] init];

    for (int i = 0; i < 5; i++){
      Dice *newDice = [[Dice alloc] init];
      [newDice setValue: arc4random_uniform(6)+1];
      [dices addObject:newDice];
    }

    [self setDices:[NSArray arrayWithArray:dices]];
    [self setHoldingIndexes:[NSMutableSet new]];
    [self setRollCount:0];
  }
  return self;
}

- (int) totalScore
{
  _totalScore = 0;
  for (Dice *dice in _dices){
    _totalScore += ([dice value] == 3) ? 0 : [dice value];
  }
  return _totalScore;
}

- (void) rollDice
{
  for (int i = 0; i < 5; i++){
    if (![_holdingIndexes containsObject: [NSNumber numberWithInt:i]]){
      [_dices[i] setValue: arc4random_uniform(6)+1];
    }
  }
  _rollCount += 1;
}

- (void)holdDiceWithIndex: (NSNumber*) index
{
  if ([[self holdingIndexes] containsObject:index]){
    [[self holdingIndexes] removeObject:index];
  }else if ([index intValue] >= 0 && [index intValue] <= 4){
    [[self holdingIndexes] addObject:index];
  }
}

- (void) resetDice
{
  [[self holdingIndexes] removeAllObjects];
}

+ (void)displayCommandLists
{
  NSString *str = [NSString stringWithFormat:
                    @"\n\n"
                    "roll     : to roll a dice\n"
                    "hold     : to hold a dice\n"
                    "reset    : to un-hold all dices\n"
                    "done     : to end the game\n"
                    "display  : to show current stats\n\n"
                  ];
  NSLog(@"%@", str);
}

- (NSString*)generateDiceText
{
  NSString *diceIcons = @"";
  for (int i = 0; i < [_dices count]; i++){

    NSString *diceIcon = [NSString stringWithFormat:@"%@", [_dices[i] generateDiceIcon]];
    if ([_holdingIndexes containsObject: [NSNumber numberWithInt: i]]){
      diceIcon = [NSString stringWithFormat:@"[%@]", diceIcon];
    }
    diceIcons = [diceIcons stringByAppendingFormat:@" %@",diceIcon];
  }
  return  diceIcons;
}

- (void)displayCurrentStats
{

  int remainingRolls = 5 - _rollCount;

  NSString *str = [NSString stringWithFormat:
                    @"\n\n"
                    "Remaining Rolls : %d\n"
                    "Current Dice\n"
                    "%@ \n"
                    "Total Score : %d"
                  ,remainingRolls ,[self generateDiceText], [self totalScore]];
  NSLog(@"%@", str);
}

- (void)displayFinalStats
{
  NSString *str = [NSString stringWithFormat:
                    @"\n"
                    "Final Dice\n"
                    "%@  \n"
                    "Total Score : %d\n"
                  ,[self generateDiceText], [self totalScore]];
  NSLog(@"%@", str);
}


@end
