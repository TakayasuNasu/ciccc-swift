//
//  GameController.h
//  Lab6
//
//  Created by Takayasu Nasu on 2021/02/28.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameController : NSObject

@property (nonatomic, strong) NSArray<Dice*>* dices;
@property (nonatomic, strong) NSMutableSet<NSNumber*>* holdingIndexes;
@property (nonatomic, assign) int rollCount;
@property (nonatomic, assign) int totalScore;

+ (void) displayCommandLists;

- (NSString*) generateDiceText;
- (void) holdDiceWithIndex: (NSNumber*) index;
- (void) rollDice;
- (void) resetDice;
- (void) displayCurrentStats;
- (void) displayFinalStats;

@end

NS_ASSUME_NONNULL_END
