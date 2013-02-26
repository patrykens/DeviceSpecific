//
//  DeviceSpecific
//
//  Created by Patryk Adamkiewicz
//  Copyright (c) 2012 Patryk Adamkiewicz. All rights reserved.
//

#import "DeviceSpecific.h"

@implementation DeviceSpecific

+ (UIStoryboard*)storyboard {
    if (DEVICE_IS_IPAD) {
        return [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    }
    else {
        return [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    }
}

+ (void)executeBlockForiPad:(void(^)())iPadBlock iPhone5:(void(^)())iPhone5Block iPhone:(void(^)())iPhoneBlock {
    if (DEVICE_IS_IPAD && iPadBlock) {
        iPadBlock();
    }
    else if (DEVICE_IS_IPHONE_5 && iPhone5Block) {
        iPhone5Block();
    }
    else if (iPhoneBlock) {
        iPhoneBlock();
    }
}

+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock iPhoneFamily:(void(^)())iPhoneBlock {
    if (DEVICE_IS_IPAD) {
        iPadBlock();
    }
    else {
        iPhoneBlock();
    }
}

+ (void)executeBlockForiPhone4:(void(^)())iPhoneBlock {
    if (DEVICE_IS_IPHONE_4 && iPhoneBlock) {
        iPhoneBlock();
    }
}

+ (void)executeBlockForiPhone5:(void(^)())iPhoneBlock {
    if (DEVICE_IS_IPHONE_5 && iPhoneBlock) {
        iPhoneBlock();
    }
}

+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock {
    if (DEVICE_IS_IPAD && iPadBlock) {
        iPadBlock();
    }
}

#pragma mark -

+ (BOOL)deviceIsIPadFamily {
    return DEVICE_IS_IPAD;
}

+ (BOOL)deviceIsIPhoneFamily {
    return !DEVICE_IS_IPAD;
}

+ (BOOL)deviceIsIPhone5 {
    return DEVICE_IS_IPHONE_5;
}

#pragma mark -

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end