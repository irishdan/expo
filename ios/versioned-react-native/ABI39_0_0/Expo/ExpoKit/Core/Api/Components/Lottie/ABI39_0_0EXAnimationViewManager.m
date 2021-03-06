//
//  ABI39_0_0EXAnimationViewManager.m
//  LottieABI39_0_0ReactNative
//
//  Created by Leland Richardson on 12/12/16.
//  Copyright © 2016 Airbnb. All rights reserved.
//

#import "ABI39_0_0EXAnimationViewManager.h"

#import "ABI39_0_0EXContainerView.h"

// import ABI39_0_0RCTBridge.h
#if __has_include(<ABI39_0_0React/ABI39_0_0RCTBridge.h>)
#import <ABI39_0_0React/ABI39_0_0RCTBridge.h>
#elif __has_include("ABI39_0_0RCTBridge.h")
#import "ABI39_0_0RCTBridge.h"
#else
#import "ABI39_0_0React/ABI39_0_0RCTBridge.h"
#endif

// import ABI39_0_0RCTUIManager.h
#if __has_include(<ABI39_0_0React/ABI39_0_0RCTUIManager.h>)
#import <ABI39_0_0React/ABI39_0_0RCTUIManager.h>
#elif __has_include("ABI39_0_0RCTUIManager.h")
#import "ABI39_0_0RCTUIManager.h"
#else
#import "ABI39_0_0React/ABI39_0_0RCTUIManager.h"
#endif

#import <Lottie/Lottie.h>

@implementation ABI39_0_0EXAnimationViewManager

ABI39_0_0RCT_EXPORT_MODULE(LottieAnimationView)

- (UIView *)view
{
  return [ABI39_0_0EXContainerView new];
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (NSDictionary *)constantsToExport
{
  return @{
    @"VERSION": @1,
  };
}

ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(resizeMode, NSString)
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(sourceJson, NSString);
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(sourceName, NSString);
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(progress, CGFloat);
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(loop, BOOL);
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(speed, CGFloat);
ABI39_0_0RCT_EXPORT_VIEW_PROPERTY(onAnimationFinish, ABI39_0_0RCTBubblingEventBlock);

ABI39_0_0RCT_EXPORT_METHOD(play:(nonnull NSNumber *)ABI39_0_0ReactTag
                  fromFrame:(nonnull NSNumber *) startFrame
                  toFrame:(nonnull NSNumber *) endFrame)
{
  [self.bridge.uiManager addUIBlock:^(__unused ABI39_0_0RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    id view = viewRegistry[ABI39_0_0ReactTag];
    if (![view isKindOfClass:[ABI39_0_0EXContainerView class]]) {
      ABI39_0_0RCTLogError(@"Invalid view returned from registry, expecting LottieContainerView, got: %@", view);
    } else {
      ABI39_0_0EXContainerView *lottieView = (ABI39_0_0EXContainerView *)view;
      LOTAnimationCompletionBlock callback = ^(BOOL animationFinished){
        if (lottieView.onAnimationFinish) {
          lottieView.onAnimationFinish(@{@"isCancelled": animationFinished ? @NO : @YES});
        }
      };
      if ([startFrame intValue] != -1 && [endFrame intValue] != -1) {
        [lottieView playFromFrame:startFrame toFrame:endFrame withCompletion:callback];
      } else {
        [lottieView play:callback];
      }
    }
  }];
}

ABI39_0_0RCT_EXPORT_METHOD(reset:(nonnull NSNumber *)ABI39_0_0ReactTag)
{
  [self.bridge.uiManager addUIBlock:^(__unused ABI39_0_0RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    id view = viewRegistry[ABI39_0_0ReactTag];
    if (![view isKindOfClass:[ABI39_0_0EXContainerView class]]) {
      ABI39_0_0RCTLogError(@"Invalid view returned from registry, expecting LottieContainerView, got: %@", view);
    } else {
      ABI39_0_0EXContainerView *lottieView = (ABI39_0_0EXContainerView *)view;
      [lottieView reset];
    }
  }];
}

@end
