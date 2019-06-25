#import "FlutterPluginTestPlugin.h"
#import <flutter_plugin_test/flutter_plugin_test-Swift.h>

@implementation FlutterPluginTestPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPluginTestPlugin registerWithRegistrar:registrar];
}
@end
