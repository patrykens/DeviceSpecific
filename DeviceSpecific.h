//
//  DeviceSpecific
//
//  Created by Patryk Adamkiewicz
//  Copyright (c) 2012 Patryk Adamkiewicz. All rights reserved.
//

#define IS_WIDESCREEN (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_NORMAL_SCREEN ([[UIScreen mainScreen]bounds].size.height == (double)480)
#define DEVICE_IS_SIMULATOR ([[[UIDevice currentDevice]model] isEqualToString:@"iPhone Simulator"])
#define DEVICE_IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define DEVICE_IS_IPHONE (([[[UIDevice currentDevice]model] isEqualToString: @"iPhone"]) || ([[[UIDevice currentDevice]model] isEqualToString:@"iPhone Simulator"]))
#define DEVICE_IS_IPHONE_5 (DEVICE_IS_IPHONE && IS_WIDESCREEN)
#define DEVICE_IS_IPHONE_4 (DEVICE_IS_IPHONE && IS_NORMAL_SCREEN)
#define DEVICE_IS_IPOD   ([[[UIDevice currentDevice]model] isEqualToString:@"iPod touch"])

#define DEVICE_SPECIFIC(iPhone, iPhone5) ((IS_IPHONE_5) ? (iPhone5) : (iPhone))

#import <Foundation/Foundation.h>

@interface DeviceSpecific : NSObject

+ (UIStoryboard*)storyboard;
+ (void)executeBlockForiPhone4:(void(^)())iPhoneBlock;
+ (void)executeBlockForiPhone5:(void(^)())iPhoneBlock;
+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock;
+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock iPhoneFamily:(void(^)())iPhoneBlock;
+ (void)executeBlockForiPad:(void(^)())iPadBlock iPhone5:(void(^)())iPhone5Block iPhone:(void(^)())iPhoneBlock;

+ (BOOL)deviceIsIPadFamily;
+ (BOOL)deviceIsIPhoneFamily;
+ (BOOL)deviceIsIPhone5;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

@end

