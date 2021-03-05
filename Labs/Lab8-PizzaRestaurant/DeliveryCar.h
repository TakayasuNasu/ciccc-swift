//
//  DeliveryCar.h
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>
#import "Pizza.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryCar : NSObject

-(void) deliverPizza:(Pizza *)pizza;

@end

NS_ASSUME_NONNULL_END
