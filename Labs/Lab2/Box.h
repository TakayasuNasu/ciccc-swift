//
//  Box.h
//  Lab2
//
//  Created by Takayasu Nasu on 2021/02/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Box : NSObject

@property (assign) float height;
@property (assign) float width;
@property (assign) float length;

- (instancetype)initWithHeight: (float) hight Width: (float) width AndLength: (float) length;
- (float) calculateVolume;
- (int) countBoxWillFit: (Box *) otherBox;


@end

NS_ASSUME_NONNULL_END
