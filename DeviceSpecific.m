//
//  DeviceSpecific
//
//  Created by Patryk Adamkiewicz
//  Copyright (c) 2012 Patryk Adamkiewicz. All rights reserved.
//

#define DEVICE_IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define DEVICE_IS_IPHONE (([[[UIDevice currentDevice] model] isEqualToString: @"iPhone"]) || ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]))

#import "DeviceSpecific.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DeviceSpecific

+ (UIStoryboard *)storyboard
{
    if (DEVICE_IS_IPAD) {
        return [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    }
    else {
        return [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    }
}

+ (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString *)platformString
{
    NSString *platform = [DeviceSpecific platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

#pragma mark - Device Specific Blocks

+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock
{
    if (DEVICE_IS_IPAD) {
        iPadBlock();
    }
}

+ (void)executeBlockForIPhoneFamily:(void(^)())iPhoneBlock
{
    if (DEVICE_IS_IPHONE) {
        iPhoneBlock();
    }
}

+ (void)executeBlockForiPadFamily:(void(^)())iPadBlock iPhoneFamily:(void(^)())iPhoneBlock
{
    if (DEVICE_IS_IPAD) {
        iPadBlock();
    }
    else {
        iPhoneBlock();
    }
}

+ (void)executeBlockForDeviceType:(DeviceType)type block:(void(^)())block
{
    if ([DeviceSpecific deviceIsOfType:type]) {
        block();
    }
}
+ (void)executeBlockForDeviceiOSVersion:(DeviceiOSVersion)version block:(void(^)())block
{
    if ([DeviceSpecific deviceHasIOSVersion:version]) {
        block();
    }
}

#pragma mark - Testing for device type

+ (BOOL)deviceIsRealDevice
{
    NSString *platform = [DeviceSpecific platform];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        return NO;
    }
    else {
        return YES;
    }
}

+ (BOOL)deviceIsIPadFamily
{
    return [[[UIDevice currentDevice] model] hasPrefix:@"iPad"];
}

+ (BOOL)deviceIsIPhoneFamily
{
    return [[[UIDevice currentDevice] model] hasPrefix:@"iPhone"];
}

+ (BOOL)deviceHasIOSVersion:(DeviceiOSVersion)version
{
    switch (version) {
        case DeviceiOSVersion4:
            if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_4_3) {
                return YES;
            }
            return NO;
        case DeviceiOSVersion5:
            if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_5_0 &&
                floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_5_1) {
                return YES;
            }
            return NO;
        case DeviceiOSVersion6:
            if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_6_0 &&
                floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
                return YES;
            }
            return NO;
        case DeviceiOSVersion7:
            if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0 &&
                floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
                return YES;
            }
            return NO;
        case DeviceiOSVersion8:
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
                return YES;
            }
            return NO;
        default:
            return NO;
    }
}

+ (BOOL)deviceIsOfType:(DeviceType)type
{
    NSString *platform = [DeviceSpecific platform];
    switch (type) {
        case DeviceTypeSimulator:
            if ([platform isEqualToString:@"i386"] ||
                [platform isEqualToString:@"x86_64"]) {
                return YES;
            }
            return NO;
        case DeviceTypeiPhone4:
            if ([platform isEqualToString:@"iPhone3,1"] ||
                [platform isEqualToString:@"iPhone3,3"] ||
                [platform isEqualToString:@"iPhone4,1"]) {
                return YES;
            }
            return NO;
        case DeviceTypeiPhone5:
            if ([platform isEqualToString:@"iPhone5,1"] ||
                [platform isEqualToString:@"iPhone5,2"] ||
                [platform isEqualToString:@"iPhone5,3"] ||
                [platform isEqualToString:@"iPhone5,4"] ||
                [platform isEqualToString:@"iPhone6,1"] ||
                [platform isEqualToString:@"iPhone6,2"]) {
                return YES;
            }
            return NO;
        case DeviceTypeiPhone6:
            if ([platform isEqualToString:@"iPhone7,2"]) {
                return YES;
            }
            return NO;
        case DeviceTypeiPhone6plus:
            if ([platform isEqualToString:@"iPhone7,1"]) {
                return YES;
            }
            return NO;
        case DeviceTypeiPadStandard:
            if ([platform isEqualToString:@"iPad1,1"] ||
                [platform isEqualToString:@"iPad2,1"] ||
                [platform isEqualToString:@"iPad2,2"] ||
                [platform isEqualToString:@"iPad2,3"] ||
                [platform isEqualToString:@"iPad2,4"]) {
                return YES;
            }
            return NO;
        case DeviceTypeiPadMini:
            if ([platform isEqualToString:@"iPad2,5"] ||
                [platform isEqualToString:@"iPad2,6"] ||
                [platform isEqualToString:@"iPad2,7"] ||
                [platform isEqualToString:@"iPad4,4"] ||
                [platform isEqualToString:@"iPad4,5"]) {
                return YES;
            }
            return NO;
        case DeviceTypeiPadRetina:
            if ([platform isEqualToString:@"iPad3,1"] ||
                [platform isEqualToString:@"iPad3,2"] ||
                [platform isEqualToString:@"iPad3,3"] ||
                [platform isEqualToString:@"iPad3,4"] ||
                [platform isEqualToString:@"iPad3,5"] ||
                [platform isEqualToString:@"iPad3,6"] ||
                [platform isEqualToString:@"iPad4,1"] ||
                [platform isEqualToString:@"iPad4,2"]) {
                return YES;
            }
            return NO;
        default:
            return NO;
    }
}

#pragma mark - Screen sizes

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

@end
