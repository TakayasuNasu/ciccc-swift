//
//  FoodTruck.h
//  Lab9
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class FoodTruck;

@protocol FoodTruckDelegate <NSObject>

-(double)foodTruck:(FoodTruck *)truck priceForFood:(NSString *)food;

@end


@interface FoodTruck : NSObject


@property (nonatomic, weak) id<FoodTruckDelegate> delegate;
@property (nonatomic, assign) float earnings;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *foodType;

-(instancetype) initWithName:(NSString *)pun andFoodType:(NSString *)foodType;

-(void) serve:(int)orders;
-(void) cashOut;


@end

NS_ASSUME_NONNULL_END
