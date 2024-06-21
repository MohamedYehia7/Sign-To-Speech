import 'package:flutter/material.dart';
import 'package:signtospeech/modules/sign_to_speech_app/microphone/cubit/microphone_cubit.dart';
import 'package:signtospeech/modules/sign_to_speech_app/microphone/cubit/microphone_state.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:lottie/lottie.dart';

class Microphone extends StatefulWidget {
  const Microphone({super.key});

  @override
  State<Microphone> createState() => _MicrophoneState();
}

class _MicrophoneState extends State<Microphone> {
  late SpeechToText speech;
  bool isListening = false;
  String recognizedText = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    speech = SpeechToText();
    bool available = await speech.initialize();
    if (available) {
      setState(() {
        isListening = false;
      });
    }
  }

  void startListening() {
    speech.listen(onResult: (result) {
      setState(() {
        recognizedText = result.recognizedWords;
      });
    });
    setState(() {
      isListening = true;
    });
  }

  void stopListening() {
    if (isListening) {
      setState(() {
        isListening = false;
      });
      speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MicrophoneCubit(),
      child: BlocConsumer<MicrophoneCubit, MicrophoneStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                'Microphone',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    recognizedText,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Spacer(),
                ConditionalBuilder(
                    condition: MicrophoneCubit.get(context).gifModel != null,
                    builder: (context) => Image(
                        image: NetworkImage(
                            '${MicrophoneCubit.get(context).gifModel?.gifUrl}')),
                    fallback: (context) => LottieBuilder.asset('assets/images/waiting.json')),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.greenAccent, Colors.teal]),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 28),
                              color: Colors.grey.shade400,
                              blurRadius: 50),
                        ]),
                    child: MaterialButton(
                      // onPressed: isListening ? stopListening : startListening,
                      onPressed: () {
                        if (isListening) {
                          stopListening();
                          MicrophoneCubit.get(context).getGif(keyword: recognizedText);

                        } else {
                          startListening();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            isListening
                                ? Icons.stop_circle_outlined
                                : Icons.mic_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            isListening ? 'Stop' : 'Start',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
          );
        },
      ),
    );
  }
}
