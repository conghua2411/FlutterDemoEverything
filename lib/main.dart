import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/connection/connection_screen.dart';
import 'package:flutter_app/custom_drop_down/custom_drop_down.dart';
import 'package:flutter_app/custom_text_field_view/custom_text_field_view.dart';
import 'package:flutter_app/gridView/GridScreen.dart';
import 'package:flutter_app/inventis_filter/inventis_filter.dart';
import 'package:flutter_app/json_serializable_demo/json_serializable_demo.dart';
import 'package:flutter_app/listDemo/listView.dart';
import 'package:flutter_app/list_dismissible/list_dismissible.dart';
import 'package:flutter_app/navite_view/native_view.dart';
import 'package:flutter_app/notification/NotiScreen.dart';
import 'package:flutter_app/open_store/open_store_demo.dart';
import 'package:flutter_app/pageSlide/PageSlideDemo.dart';
import 'package:flutter_app/page_view_sistem_demo/page_view_sistem_demo.dart';
import 'package:flutter_app/permission/permision_demo.dart';
import 'package:flutter_app/place_queens/place_queens_puzzle.dart';
import 'package:flutter_app/provider/provider_screen.dart';
import 'package:flutter_app/reorder_tree_list/reorder_tree_list.dart';
import 'package:flutter_app/resize_image_demo/resize_image_demo.dart';
import 'package:flutter_app/sim_info_demo/sim_info_demo.dart';
import 'package:flutter_app/sistem_schedule2/sistem_schedule2.dart';
import 'package:flutter_app/sliding_setting_demo/sliding_setting_demo.dart';
import 'package:flutter_app/sliver_demo/sliver_demo.dart';
import 'package:flutter_app/socket/SocketDemo.dart';
import 'package:flutter_app/ticTacToe/TicTacToe.dart';
import 'package:flutter_app/tooltip/super_tooltip_demo.dart';
import 'package:flutter_app/transition/ScaleTransition.dart';
import 'package:flutter_app/transition/SlideTransition.dart';
import 'package:flutter_app/uploadS3/upload_s3_screen.dart';
import 'package:flutter_app/viewPager/ViewPager.dart';
import 'package:flutter_app/wifi_info_demo/wifi_info_demo.dart';
import 'package:flutter_app/win_hun_grid_view/win_hun_grid_view.dart';
import 'package:flutter_app/xiangqi_game/xiangqui_game.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:inventis_my_sales/inventis_my_sales.dart';
import 'animation/AnimationScreen.dart';
import 'aws_cognito_dev_upload_s3/aws_cognito_dev_upload_s3.dart';
import 'aws_cognito_prod/aws_cognito_prod.dart';
import 'bottom_bar_demo/bottom_bar_demo.dart';
import 'bottom_edit_view/bottom_edit_view.dart';
import 'bottom_sheet_keyboard/bottom_sheet_keyboard.dart';
import 'calendar/list_calendar.dart';
import 'calendar_view_demo/calendar_view_demo.dart';
import 'camera_sistem/camera_sistem_demo.dart';
import 'challenge_app_profile/challenge_app_profile_demo.dart';
import 'cognito/CognitoScreen.dart';
import 'column_demo/column_demo.dart';
import 'comment_ui_demo/comment_ui_demo.dart';
import 'crypto_home_demo/crypto_home_demo.dart';
import 'crypto_tooltip/crypto_tooltip.dart';
import 'current_locale_demo/current_locale_demo.dart';
import 'custom_bottom_calendar/custom_bottom_calendar.dart';
import 'custom_list_quochuynh/custom_list_quochuynh.dart';
import 'custom_painter_image/custom_painter_image.dart';
import 'custom_profile/custom_profile_screen.dart';
import 'deepLink/DeepLinkScreen.dart';
import 'package:uni_links/uni_links.dart';

import 'deep_link_native/deep_link_native.dart';
import 'demoAHung/DemoAHung.dart';
import 'demoAHung/ListExpandDemo.dart';
import 'device_info_demo/device_info_demo.dart';
import 'draggable_demo/draggable_demo.dart';
import 'floating_button_draggable/floating_button_draggable.dart';
import 'format_date_time/format_date_time_demo.dart';
import 'game_of_life/game_of_life.dart';
import 'image_crop_circle/image_crop_circle.dart';
import 'keyboard_initstate.dart';
import 'language_demo/language_demo.dart';
import 'load_json_demo/load_json_demo.dart';
import 'local_file_demo/local_file_demo.dart';
import 'photo_filter_demo/photo_filter_demo.dart';
import 'photo_view_demo/photo_view_demo.dart';
import 'reorder_list_demo/reorder_list_demo.dart';
import 'rxDartDemo/RxDartDemo.dart';
import 'sistem_schedule_demo/sistem_schedule_demo.dart';
import 'ui_bottom_bar/ui_bottom_bar_demo.dart';
import 'view_page_with_bottom_bar/view_page_with_bottom_bar.dart';
import 'web_socket_channel/demo_state.dart';

List<CameraDescription> cameras;

Future<String> initUniLink() async {
  try {
    String initialLink = await getInitialLink();
    print('initialLink: $initialLink');
    return 'initialLink';
  } on PlatformException {
    print('initialLink: error ');
    throw ('initialLink: error');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup line ony once

////  set up line sdk only once - 1653555607
//  await LineSDK.instance.setup('1653555607');

  //Connection
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  cameras = await availableCameras();

  runApp(MaterialApp(
    theme: ThemeData(primaryColorBrightness: Brightness.dark),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', 'EN'),
      const Locale('ko', 'KO'),
      const Locale('vi', 'VI'),
    ],

    /// uncommend this so font size never change
//    builder: (context, child) {
//      return MediaQuery(
//        child: child,
//        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//      );
//    },
    title: 'navigation',
    home: MyApp(),
    initialRoute: '/',
    onGenerateRoute: (setting) {
      switch (setting.name) {
        case '/':
          return MaterialPageRoute(builder: (_) => MyApp());
        case '/SecondRoute':
          return ScaleRoute(widget: SecondRoute());
        case '/FloatButtonDraggable':
          return MaterialPageRoute(builder: (_) => FloatButtonDraggable());
        default:
          return MaterialPageRoute(builder: (_) => MyApp());
      }
    },
  ));
}

// Navigation
class MyApp extends StatefulWidget {
  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  StreamSubscription<Uri> _linksStreamSubscription;

  _initPlatformState() async {
    try {
      String initialLink = await getInitialLink();
      print('link : $initialLink');
    } on PlatformException {
      print('error');
    }

    _linksStreamSubscription = getUriLinksStream().listen((Uri link) {
      print('link listener: $link');

      var query = link.queryParameters;

      var name = query["name"];
      var email = query["email"];
      var confirmationCode = query["confirmationCode"];
      var picture = query["picture"];

      print(
          'name : $name - email : $email - confirmationCode : $confirmationCode - picture : $picture');
    }, onError: (err) {
      print('link listener: $err');
    });
  }

  // deep link native
  //Event Channel creation
  static const stream = const EventChannel('poc.deeplink.flutter.dev/events');

  //Method channel creation
  static const platform =
      const MethodChannel('poc.deeplink.flutter.dev/cnannel');

  StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  @override
  void dispose() {
    _stateController.close();
    _linksStreamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
//    _initPlatformState();

    // only on android
    if (Platform.isAndroid) {
      //Checking application start by deep link
      startUri().then(_onRedirected);

      //Checking broadcast stream, if deep link was clicked in opened appication
      stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
    }

    state.listen((data) {
      print('deep_link_native: success $data');
      if (data != 'startString is null') {
        Navigator.of(context)
            .push(SlideRightRoute(widget: DeepLinkNativeDemo(url: data)));
      }
    }, onError: (e) {
      print('deep_link_native: error $e');
    });
  }

  Future<String> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  _onRedirected(String uri) {
    if (uri == null) return;
    print('deep_link_native: $uri');
    // Here can be any uri analysis, checking tokens etc, if it’s necessary
    // Throw deep link URI into the BloC's stream
//    stateSink.add(uri);
    _stateController.add(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("first my app"),
      ),
      body: Center(
        child: RaisedButton(
            child: Text("next"),
            onPressed: () {
//              Navigator.pushNamed(context, '/SecondRoute');
              Navigator.push(context, ScaleRoute(widget: SecondRoute()));
            }),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text("camera"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("list view"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListViewScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("NotiScreen"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotiScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("ViewPager"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewPagerDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("GridView"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GridScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("tictactoe"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: TicTacToe()));
                  },
                ),
                RaisedButton(
                  child: Text("pageSlide"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: PageSlideDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("socketDemo"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: SocketDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("deepLinkDemo"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: DeepLinkScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("cognito"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: CognitoScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("animation"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: AnimationScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("rxDart"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: RxDartDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("AHung"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: DemoAHung()));
                  },
                ),
                RaisedButton(
                  child: Text("ListExpandDemo"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ListExpandDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("FlutterConnection"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ConnectionScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("UploadS3"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: UploadS3Screen()));
                  },
                ),
                RaisedButton(
                  child: Text("TestSetState"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: DemoStateScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("PermissionDemo"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: PermissionDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("ColumnDemo"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ColumnDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("LanguageDemo"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: LanguageDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("CustomProfileScreen"),
                  onPressed: () {
                    Navigator.push(context,
                        SlideRightRoute(widget: CustomProfileScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("CommentUIDemo"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: CommentUIDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("CryptoHome"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: CryptoHomeDemo()));
                  },
                ),
                RaisedButton(
                  child: Text("ViewPageWithBottomBar"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ViewPageBottomBar()));
                  },
                ),
                RaisedButton(
                  child: Text('BottomEditDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: BottomEditDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('TooltipDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: SuperTooltipDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('CryptoTooltip'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: CryptoTooltipDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('DraggableDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: DraggableDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('SlidingSetting'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: SlidingSettingDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('BottomSheetKeyboard'),
                  onPressed: () {
                    Navigator.push(context,
                        SlideRightRoute(widget: BottomSheetKeyboard()));
                  },
                ),
                RaisedButton(
                  child: Text('CustomListQuocHuynh'),
                  onPressed: () {
                    Navigator.push(context,
                        SlideRightRoute(widget: CustomListQuocHuynh()));
                  },
                ),
                RaisedButton(
                  child: Text('AwsCognitoProd'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: AwsCognitoProd()));
                  },
                ),
                RaisedButton(
                  child: Text('DeviceInfoDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: DeviceInfoDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('SliverDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: SliverDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('AwsCognitoDevUploadS3'),
                  onPressed: () {
                    Navigator.push(context,
                        SlideRightRoute(widget: AwsCognitoDevUploadS3()));
                  },
                ),
                RaisedButton(
                  child: Text('DeepLinkNativeDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: DeepLinkNativeDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('LoadJsonDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: LoadJsonDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('CurrentLocaleDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: CurrentLocaleDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('FloatButtonDraggable'),
                  onPressed: () {
                    Navigator.push(context,
                        SlideRightRoute(widget: FloatButtonDraggable()));

//                    Navigator.of(context).pushAndRemoveUntil(
//                        SlideRightRoute(widget: FloatButtonDraggable()),
//                        (route) {
//                      return route == MaterialPageRoute(builder: (_) => MyApp());
//                    });
                  },
                ),
                RaisedButton(
                  child: Text('WifiInfoDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: WifiInfoDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('ReorderTreeList'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ReorderTreeList()));
                  },
                ),
                RaisedButton(
                  child: Text('KeyboardInit'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: KeyboardInit()));
                  },
                ),
                RaisedButton(
                  child: Text('SimInfoDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: SimInfoDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('ResizeImageDemo'),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ResizeImageDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('ChallengeAppProfileDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        SlideRightRoute(widget: ChallengeAppProfileDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('LocalFileDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LocalFileDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('FormatDateTimeDemo'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormatDateTimeDemo(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('XiangqiGame'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => XiangqiGame()));
                  },
                ),
                RaisedButton(
                  child: Text('GameOfLife'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => GameOfLife()));
                  },
                ),
                RaisedButton(
                  child: Text('ImageCropCircleDemo'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ImageCropCircleDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('PhotoViewDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PhotoViewDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('CustomPainterImage'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CustomPainterImage()));
                  },
                ),
                RaisedButton(
                  child: Text('ReOrderListDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ReOrderListDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('CameraSistemDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CameraSistemDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('PhotoFilterDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PhotoFilterDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('BottomBarDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BottomBarDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('SistemScheduleDemo'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SistemScheduleDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('CalendarViewDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CalendarViewDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('UiBottomBarDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => UiBottomBarDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('SistemScheduleView2'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SistemScheduleView()));
                  },
                ),
                RaisedButton(
                  child: Text('ListCalendarDemo'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ListCalendar()));
                  },
                ),
                RaisedButton(
                  child: Text('PageViewSistemDemo'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PageViewSistemDemo()));
                  },
                ),
                RaisedButton(
                  child: Text('CustomBottomCalendar'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CustomBottomCalendar()));
                  },
                ),
                RaisedButton(
                  child: Text('ListDismissible'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListDismissibleView(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('NativeView'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NativeView(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('InventisFilter'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InventisFilter(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('InventisMySale'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InventisMySale(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('CustomDropDown'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomDropDown(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('CustomTextFieldView'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomTextFieldView(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('ProviderDemo'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProviderDemo(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('JsonSerializableDemo'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JsonSerializableDemo(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('PlaceQueensPuzzle'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlaceQueensPuzzle(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('OpenStore'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OpenStoreDemo(),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('WinHunGridView'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WinHunGridView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Camera take picture
class CameraScreen extends StatefulWidget {
  @override
  State createState() {
    return CameraState();
  }
}

class CameraState extends State<CameraScreen> {
  File _image;

  static const platform = const MethodChannel("com.example.flutter_app/main");

  Future _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });

    String result = "";
    try {
      result = await platform.invokeMethod("testOcr", {"imageFile": image});

      print("testOcr : $result");
    } on PlatformException catch (e) {
      print("native error : ${e.message}");
    }
  }

  Future _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("camera"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("open camera"),
                  onPressed: _openCamera,
                ),
                RaisedButton(
                  child: Text("open Gallery"),
                  onPressed: _openGallery,
                ),
                _image == null ? new Text("empty") : new Image.file(_image),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
