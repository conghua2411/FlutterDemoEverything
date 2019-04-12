import 'package:flutter/material.dart';
import 'package:flutter_app/appDemo/Repo/AuthRepo.dart';
import 'package:flutter_app/appDemo/bloc/AuthBloc.dart';
import 'package:flutter_app/appDemo/signup/SignUp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/appDemo/splash/splash.dart';
import 'package:flutter_app/appDemo/login/Login.dart';

//Future<void> main() async {
//  runApp(Auth());
//}

class Auth extends StatefulWidget {
  final AuthBloc authBloc = AuthBloc(authRepo: AuthRepo());

  @override
  State createState() => AuthScreenState();
}

class AuthScreenState extends State<Auth> {
  AuthBloc get _authBloc => widget.authBloc;

  @override
  void initState() {
    _authBloc.dispatch(SplashEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      bloc: _authBloc,
      child: MaterialApp(
        home: BlocBuilder(
            bloc: _authBloc,
            builder: (BuildContext context, AuthState state) {
              if (state is AuthSplash) {
                print("1");
              } else if (state is AuthLogin) {
                print("2");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                      context, CustomRoute(builder: (context) => Login()));
                });
//                _authBloc.dispatch(SplashEvent());
              } else if (state is AuthSignUp) {
                print("3");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                      context, CustomRoute(builder: (context) => SignUp()));
                });
              }
              return Splash();
            }),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }
}

class CustomRoute<T extends int> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
          .animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    );

//    return FadeTransition(
//      opacity: animation,
//      child: child,
//    );
  }
}
