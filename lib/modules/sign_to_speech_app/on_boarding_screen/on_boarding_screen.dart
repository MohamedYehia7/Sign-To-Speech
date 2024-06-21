import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:signtospeech/modules/sign_to_speech_app/login/login.dart';
import 'package:signtospeech/network/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boarderController = PageController();
  bool isLast = false;

  List<OnBoardingModel> boarding = [
    OnBoardingModel(
        image: 'assets/images/welcome.json',
        title: 'Welcome to Sign To Speech',
        body: 'Here you can communicate with sign language speakers with ease'),
    OnBoardingModel(
        image: 'assets/images/camera.json',
        title: 'Use the Camera',
        body:
            'Film your friend speaking in sign language and the sign language will automatically turn into understandable sentences'),
    OnBoardingModel(
        image: 'assets/images/microphone.json',
        title: 'Use the Microphone',
        body:
            'You can also use the microphone to convert a sentence into sign language'),
  ];

  void onSubmit() {
    CacheHelper.saveDate(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  onSubmit();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 17, color: Color(0xff0d121e)),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boarderController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildOnBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      isLast = true;
                    } else {
                      isLast = false;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boarderController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Color(0xff0d121e),
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        onSubmit();
                      } else {
                        boarderController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    backgroundColor: Colors.teal,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildOnBoardingItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Lottie.asset('${model.image}', width: 400, height: 400)),
          const SizedBox(
            height: 90,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(fontSize: 25, fontFamily: 'Belanosima'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(fontSize: 20, fontFamily: 'Belanosima'),
          ),
        ],
      );
}
