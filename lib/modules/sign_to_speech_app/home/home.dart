import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:signtospeech/modules/sign_to_speech_app/camera/sign_to_text.dart';
import 'package:signtospeech/modules/sign_to_speech_app/microphone/microphone.dart';
import 'package:signtospeech/modules/sign_to_speech_app/setting/setting.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Uri _url = Uri.parse('https://adham-kaseb.github.io/S2S/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow:  [
                    BoxShadow(
                      offset: Offset(0, 15),
                      color: Colors.grey.shade300,
                      blurRadius: 30,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: GoogleFonts.pacifico(
                              textStyle: const TextStyle(fontSize: 20)),
                        ),
                        const Text(
                          'Mohamed Yehia',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (contetx)=>Setting()));
                    }, icon: const Icon(Icons.settings,size: 35,))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: double.infinity,
              height: 160,
              child: Lottie.asset('assets/images/sitting.json'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Let\'s connect with friends and help each other by using camera or microphone',
              style: TextStyle(fontSize: 23),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.greenAccent, Colors.teal]),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(28, 28),
                                color: Colors.grey,
                                blurRadius: 50),

                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignToTextLanguage()));
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              'Camera',
                              style:
                              TextStyle(color: Colors.white, fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 170,
                      width: 160,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.greenAccent, Colors.teal]),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.teal,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(28, 28),
                                color: Colors.grey,
                                blurRadius: 50),

                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Microphone()));
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              'Microphone',
                              style:
                              TextStyle(color: Colors.white, fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          scaffoldKey.currentState?.showBottomSheet((context) =>
              Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xff040D12),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Lottie.asset('assets/images/learning.json',
                          width: double.infinity, height: 250),
                      const Text(
                        'Do you want to learn SIGN LANGUAGE?',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'On our website, you can learn sign language in multiple languages by watching videos, and you can evaluate yourself by solving questions.',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.greenAccent, Colors.teal]),
                        ),
                        child: MaterialButton(
                          onPressed: _launchUrl,
                          child: const Text('LET\'S START NOW',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),),
                        ),
                      ),


                    ],
                  ),
                ),
              ));
        },
        backgroundColor: Colors.teal,
        label: const Text(
          'Our Site',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        icon: const Icon(
          Icons.web_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
