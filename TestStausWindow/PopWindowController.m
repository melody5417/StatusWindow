//
//  PopWindowController.m
//  TestStausWindow
//
//  Created by Yiqi Wang on 2016/12/29.
//  Copyright © 2016年 Melody5417. All rights reserved.
//

#import "PopWindowController.h"

@interface PopWindow : NSWindow

@end

@implementation PopWindow

- (BOOL)canBecomeKeyWindow {
  return YES;
}

- (BOOL)canBecomeMainWindow {
  return YES;
}

@end

@interface PopWindowController ()

@end

@implementation PopWindowController

- (instancetype)init {
  self = [[PopWindowController alloc] initWithWindowNibName:@"PopWindowController"];
  return self;
}

- (void)windowDidLoad {
  [super windowDidLoad];
    
  [self.window setMovableByWindowBackground:YES];
}

- (void)popAtPosition:(NSPoint)arrowPoint {
  NSSize windowSize = self.window.frame.size;
  NSPoint windowOrigin = NSMakePoint(arrowPoint.x - windowSize.width / 2.0,
                                     arrowPoint.y - windowSize.height);
  [self.window setFrameOrigin:windowOrigin];
  [self showWindow:nil];
}

@end
