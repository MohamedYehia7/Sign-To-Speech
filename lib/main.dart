import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtospeech/modules/sign_to_speech_app/home/home.dart';
import 'package:signtospeech/modules/sign_to_speech_app/login/login.dart';
import 'package:signtospeech/modules/sign_to_speech_app/on_boarding_screen/on_boarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signtospeech/modules/sign_to_speech_app/setting/cubit/user_cubit.dart';
import 'package:signtospeech/network/bloc_ob.dart';
import 'package:signtospeech/network/cache_helper.dart';
import 'package:signtospeech/network/dio_helper.dart';
import 'package:signtospeech/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = Home();
    } else {
      widget = const Login();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()..getUser()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            textTheme: GoogleFonts.belanosimaTextTheme(),
            primaryColor: Colors.teal),
        home: startWidget,
      ),
    );
  }
}
