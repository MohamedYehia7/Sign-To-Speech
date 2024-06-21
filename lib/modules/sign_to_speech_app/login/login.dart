import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signtospeech/modules/sign_to_speech_app/home/home.dart';
import 'package:signtospeech/modules/sign_to_speech_app/login/cubit/login_cubit.dart';
import 'package:signtospeech/modules/sign_to_speech_app/login/cubit/login_state.dart';
import 'package:signtospeech/modules/sign_to_speech_app/register/register.dart';
import 'package:signtospeech/network/cache_helper.dart';
import 'package:signtospeech/shared/components/assets_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signtospeech/shared/components/components.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToast(text: 'Login Success', state: ToastStates.SUCCESS);
            CacheHelper.saveDate(key: 'token', value: state.loginModel.token).then((value) {
              token = state.loginModel.token!;

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
            });
          }
          else if (state is LoginErrorState) {
            showToast(text: "Login Failed", state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xff0d121e),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Image(
                        image: AssetImage(AssetsData.logo),
                        height: 100,
                        width: 100,
                      ),
                      const Text(
                        'Sign To Speech',
                        style:
                            TextStyle(fontSize: 30, color: Color(0xff86e2d5)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 600,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(fontSize: 27),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email Address must be not empty";
                                  }
                                  return null;
                                },
                                cursorColor: Colors.teal,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  hintText: 'Email Address',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                        color: Colors.teal, width: 3),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.mail,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Password',
                                style: TextStyle(fontSize: 27),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: isPassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password must be not empty";
                                  }
                                  return null;
                                },
                                cursorColor: Colors.teal,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  hintText: 'Password',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                        color: Colors.teal, width: 3),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.teal,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPassword = !isPassword;
                                      });
                                    },
                                    icon: isPassword
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Colors.teal,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Colors.teal,
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(20)),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);

                                      //   Navigator.pushAndRemoveUntil(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) => Home()),
                                      //       (route) => false);
                                    }
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Register()));
                                      },
                                      child: const Text(
                                        'Register Now',
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                              // SizedBox(height: 50,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
