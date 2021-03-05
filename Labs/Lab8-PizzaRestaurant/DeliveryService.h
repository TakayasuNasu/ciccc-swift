//
//  DeliveryService.h
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>
#import "DeliveryCar.h"
#import "Pizza.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryService : NSObject

@property (nonatomic) NSMutableArray *deriveredPizzas;
@property (nonatomic) DeliveryCar *deliveryCar;

- (void) deliverPizza:(Pizza *)pizza;
- (NSMutableArray *) getDeliveredPizzaInfo;

@end

NS_ASSUME_NONNULL_END
