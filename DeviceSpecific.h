//
//  DeviceSpecific
//
//  Created by Patryk Adamkiewicz
//  Copyright (c) 2012 Patryk Adamkiewicz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DeviceType) {
    DeviceTypeSimulator,
    DeviceTypeiPhone4,
    DeviceTypeiPhone5,
    DeviceTypeiPhone6,
    DeviceTypeiPhone6plus,
    DeviceTypeiPadStandard,
    DeviceTypeiPadRetina,
    DeviceTypeiPadMini
};

typedef NS_ENUM(NSUInteger, DeviceiOSVersion) {
    DeviceiOSVersion4,
    DeviceiOSVersion5,
    DeviceiOSVersion6,
    DeviceiOSVersion7,
    DeviceiOSVersion8
};

/**
 *	Helper class for executing blocks for specified device type or iOS version
 */
@interface DeviceSpecific : NSObject

/**
 *	Returns storyboard object for current device 
 *
 *  Warning! - using default names which are MainStoryboard_iPad and MainStoryboard_iPhone,
 *  if you named them differently, then change names in implementation file.
 *
 *	@return	storyboard object
 */
+ (UIStoryboard *)storyboard;

+ (NSString *)platformString;

#pragma mark - Device Specific Blocks

+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock;
+ (void)executeBlockForIPhoneFamily:(void(^)())iPhoneBlock;
+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock iPhoneFamily:(void(^)())iPhoneBlock;

+ (void)executeBlockForDeviceType:(DeviceType)type block:(void(^)())block;
+ (void)executeBlockForDeviceiOSVersion:(DeviceiOSVersion)version block:(void(^)())block;

#pragma mark - Testing for device type
/**
 *	Determines if device is of specified kind
 *
 *	@return	BOOL flag
 */
+ (BOOL)deviceIsRealDevice;
+ (BOOL)deviceIsIPadFamily;
+ (BOOL)deviceIsIPhoneFamily;
+ (BOOL)deviceHasIOSVersion:(DeviceiOSVersion)version;
+ (BOOL)deviceIsOfType:(DeviceType)type;

#pragma mark - Screen sizes
/**
 *	Returns screen width or height
 *
 *	@return	screen width or height
 */
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;


@end
