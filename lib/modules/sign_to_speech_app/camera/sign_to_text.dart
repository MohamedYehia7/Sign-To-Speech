import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class SignToTextLanguage extends StatefulWidget {
  final FlutterVision vision = FlutterVision();

  SignToTextLanguage({super.key});

  @override
  State<SignToTextLanguage> createState() => _SignToTextLanguageState();
}

class _SignToTextLanguageState extends State<SignToTextLanguage> {
  late CameraController controller;
  late List<Map<String, dynamic>> yoloResults;
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  final FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();


  void translate({required String lang}) async {
    await translator.translate(yoloResults[0]["tag"], to: lang).then((value) => setState(() {
      yoloResults[0]["tag"] = value.text;
    }));
  }

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    late List<CameraDescription> cameras;
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.low);
    await controller.initialize();
    await loadYoloModel();
    setState(() {
      isLoaded = true;
      isDetecting = false;
      yoloResults = [];
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.teal,
          ),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 650,
                  width: double.infinity,
                  child: CameraPreview(controller)),
              Container(
                width: double.infinity,
                height: 210,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 5.0,top: 20.0),
                      child: Row(
                        children: [
                          yoloResults.isEmpty
                              ? const Text('')
                              : Text(
                                  "${yoloResults[0]['tag']}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                          const Spacer(),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.greenAccent,
                                        Colors.teal
                                      ]),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 28),
                                        color: Colors.grey.shade400,
                                        blurRadius: 50),
                                  ]),
                              child: IconButton(
                                  onPressed: () {
                                    speak('${yoloResults[0]['tag']}');
                                  },
                                  icon: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                  ))),
                          const SizedBox(
                            width: 5,
                          ),
                          DropdownMenu(
                            hintText: 'Select',
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: 0, label: 'Arabic'),
                              DropdownMenuEntry(value: 1, label: 'English'),
                              DropdownMenuEntry(value: 2, label: 'French'),
                              DropdownMenuEntry(value: 3, label: 'Spanish'),
                            ],
                            onSelected: (value) {
                              if (value == 0) {
                                translate(lang: 'ar');
                              } else if (value == 1) {
                                translate(lang: 'en');
                              } else if (value == 2) {
                                translate(lang: 'fr');
                              } else if (value == 3) {
                                translate(lang: 'es');
                              }
                            },
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintStyle: const TextStyle(fontSize: 18),
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                            leadingIcon: const Icon(
                              Icons.translate,
                              color: Colors.black,
                            ),
                            trailingIcon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                            ),
                            selectedTrailingIcon: const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: Colors.black,
                            ),
                            menuStyle: MenuStyle(
                              elevation: MaterialStateProperty.all(5),
                              surfaceTintColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 60,
                        width: 140,
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
                          onPressed: isDetecting ? stopDetection : startDetection,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                isDetecting
                                    ? Icons.stop_circle_outlined
                                    : Icons.play_arrow_sharp,
                                color: Colors.white,
                                size: 35,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                isDetecting ? 'Stop' : 'Start',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadYoloModel() async {
    await widget.vision.loadYoloModel(
      labels: 'assets/models/classes4.txt',
      modelPath: 'assets/models/best4-fp16.tflite',
      modelVersion: "yolov5",
      numThreads: 2,
      useGpu: true,
    );
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await widget.vision.yoloOnFrame(
      bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
    );
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
        print("Youssef:$yoloResults");
      });
    }
  }

  Future<void> startDetection() async {
    setState(() {
      isDetecting = true;
    });
    if (controller.value.isStreamingImages) {
      return;
    }
    await controller.startImageStream((image) async {
      if (isDetecting) {
        cameraImage = image;
        yoloOnFrame(image);
      }
    });
  }

  Future<void> stopDetection() async {
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];
    double factorX = screen.width / (cameraImage?.height ?? 1);
    double factorY = screen.height / (cameraImage?.width ?? 1);

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);

    return yoloResults.map((result) {
      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }
}
