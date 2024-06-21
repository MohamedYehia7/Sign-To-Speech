import 'package:flutter/material.dart';
import 'package:signtospeech/modules/sign_to_speech_app/login/login.dart';
import 'package:signtospeech/modules/sign_to_speech_app/setting/cubit/user_cubit.dart';
import 'package:signtospeech/modules/sign_to_speech_app/setting/cubit/user_states.dart';
import 'package:signtospeech/network/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   const Text(
                                    'First Name',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Text(
                                      '${UserCubit.get(context).loginModel?.user?.firstName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Last Name',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade200,
                                    ),
                                    child:  Text(
                                      '${UserCubit.get(context).loginModel?.user?.lastName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Email Address',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            width: 350,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200,
                            ),
                            child:  Text(
                              '${UserCubit.get(context).loginModel?.user?.email}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Phone Number',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Container(
                            width: 350,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200,
                            ),
                            child: Text(
                              '${UserCubit.get(context).loginModel?.user?.phoneNumber}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 60,
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
                    // BoxShadow(
                    //   color: Color(0xff00e2cd),
                    //   offset: Offset(-28, -28),
                    //   blurRadius: 70
                    // )
                  ]),
              child: MaterialButton(
                onPressed: () {
                  CacheHelper.clearData(key: 'token');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (route) => false);
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'LOGOUT',
                      style:
                      TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
