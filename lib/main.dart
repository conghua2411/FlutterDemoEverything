import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/TestOcr.dart';
import 'package:flutter_app/appDemo/auth/Auth.dart';
import 'package:flutter_app/chat/chat.dart';
import 'package:flutter_app/connection/connection_screen.dart';
import 'package:flutter_app/demoBloc/widget/BlocScreen.dart';
import 'package:flutter_app/gridView/GridScreen.dart';
import 'package:flutter_app/listDemo/listView.dart';
import 'package:flutter_app/notification/NotiScreen.dart';
import 'package:flutter_app/pageSlide/PageSlideDemo.dart';
import 'package:flutter_app/palette_generator_demo/palette_generator_demo.dart';
import 'package:flutter_app/shoppingCart/screen/cartList.dart';
import 'package:flutter_app/snake/SnakeScreen.dart';
import 'package:flutter_app/socket/SocketDemo.dart';
import 'package:flutter_app/ticTacToe/TicTacToe.dart';
import 'package:flutter_app/transition/ScaleTransition.dart';
import 'package:flutter_app/transition/SlideTransition.dart';
import 'package:flutter_app/uploadS3/upload_s3_screen.dart';
import 'package:flutter_app/viewPager/ViewPager.dart';
import 'package:flutter_app/widgetDemo/memrise.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import 'animation/AnimationScreen.dart';
import 'cognito/CognitoScreen.dart';
import 'deepLink/DeepLinkScreen.dart';
import 'package:uni_links/uni_links.dart';

import 'demoAHung/DemoAHung.dart';
import 'demoAHung/ListExpandDemo.dart';
import 'flutter_sound/flutter_sound_screen.dart';
import 'rxDartDemo/RxDartDemo.dart';

List<CameraDescription> cameras;

Future<String> initUniLink() async {
  try {
    String initialLink = await getInitialLink();
    print('initialLink: $initialLink');
  } on PlatformException {
    print('initialLink: error ');
  }
}

Future<void> main() async {

  //Connection
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  cameras = await availableCameras();

  runApp(MaterialApp(
    title: 'navigation',
    home: MyApp(),
    initialRoute: '/',
    onGenerateRoute: (setting) {
      switch (setting.name) {
        case '/':
          return MaterialPageRoute(builder: (_) => MyApp());
        case '/SecondRoute':
          return ScaleRoute(widget: SecondRoute());
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

  @override
  void dispose() {
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.dispose();
    _linksStreamSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());

    return Scaffold(
      appBar: AppBar(
        title: Text("first my app"),
      ),
      body: Center(
        child: RaisedButton(
            child: Text("next"),
            onPressed: () {
              Navigator.pushNamed(context, '/SecondRoute');
//              Navigator.push(context, ScaleRoute(widget: SecondRoute()));
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
        body: Center(
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
                  child: Text("camera preview"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CameraPrev()));
                  },
                ),
                RaisedButton(
                  child: Text("camera preview sample"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraExampleHome()));
                  },
                ),
                RaisedButton(
                  child: Text("camera ocr test"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TestOcr()));
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
                  child: Text("demo bloc"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BlocScreen()));
                  },
                ),
                RaisedButton(
                  child: Text("demo app"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Auth()),
                        (Route<dynamic> route) => false);
//                  Navigator.pushReplacement(
//                      context, MaterialPageRoute(builder: (context) => Auth()));
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
                  child: Text("shoppingCart"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyCartList()));
                  },
                ),
                RaisedButton(
                  child: Text("memrise"),
                  onPressed: () {
                    Navigator.push(context, SlideRightRoute(widget: Memrise()));
                  },
                ),
                RaisedButton(
                  child: Text("chat"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ChatScreen()));
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
                  child: Text("snake"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: SnakeScreen()));
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
                  child: Text("FlutterSound"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: FlutterSoundScreen()));
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
                  child: Text("PaletteGenerator"),
                  onPressed: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: PaletteGeneratorDemo()));
                  },
                ),
              ],
            ),
          ),
        ));
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

// CameraPreview
class CameraPrev extends StatefulWidget {
  @override
  State createState() {
    return CameraPreviewState();
  }
}

class CameraPreviewState extends State<CameraPrev> {
  CameraController cameraController;

  Future _takePicture() async {}

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("cameraPreview"),
      ),
      body: AspectRatio(
        aspectRatio: cameraController.value.aspectRatio,
        child: new CameraPreview(cameraController),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: Icon(Icons.camera),
      ),
    );

//    return AspectRatio(
//      aspectRatio: cameraController.value.aspectRatio,
//        child: new CameraPreview(cameraController));
  }
}

class CameraExampleHome extends StatefulWidget {
  @override
  _CameraExampleHomeState createState() {
    return _CameraExampleHomeState();
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraExampleHomeState extends State<CameraExampleHome> {
  CameraController controller;
  String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Camera example'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: controller != null && controller.value.isRecordingVideo
                      ? Colors.redAccent
                      : Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          _captureControlRowWidget(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _cameraTogglesRowWidget(),
                _thumbnailWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: videoController == null && imagePath == null
            ? null
            : SizedBox(
                child: (videoController == null)
                    ? Image.file(File(imagePath))
                    : Container(
                        child: Center(
                          child: AspectRatio(
                              aspectRatio: videoController.value.size != null
                                  ? videoController.value.aspectRatio
                                  : 1.0,
                              child: VideoPlayer(videoController)),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.pink)),
                      ),
                width: 64.0,
                height: 64.0,
              ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  controller.value.isRecordingVideo
              ? onStopButtonPressed
              : null,
        )
      ],
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoController?.dispose();
          videoController = null;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) setState(() {});
      if (filePath != null) showInSnackBar('Saving video to $filePath');
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recorded to: $videoPath');
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    await _startVideoPlayer();
  }

  Future<void> _startVideoPlayer() async {
    final VideoPlayerController vcontroller =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoController?.dispose();
    if (mounted) {
      setState(() {
        imagePath = null;
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraExampleHome(),
    );
  }
}

//List<CameraDescription> cameras;

//Future<void> main() async {
//  // Fetch the available cameras before initializing the app.
//  try {
//    cameras = await availableCameras();
//  } on CameraException catch (e) {
//    logError(e.code, e.description);
//  }
//  runApp(CameraApp());
//}
