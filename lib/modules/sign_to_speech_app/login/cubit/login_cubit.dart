import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signtospeech/model/sign_to_speech_app/login_model.dart';
import 'package:signtospeech/modules/sign_to_speech_app/login/cubit/login_state.dart';
import 'package:signtospeech/network/dio_helper.dart';
import 'package:dio/dio.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: "login", request_data: {
      'email': email,
      'password': password,
    }).then((value) {
      // print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.token);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print('########## ${error.toString()}');
      emit(LoginErrorState(error.toString()));
    });
  }

  void userRegister(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber}){
    emit(RegisterLoadingState());
    DioHelper.postData(url: "register", request_data: {
      FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': password,
        'PhoneNumber': phoneNumber
      })
    }).then((value) {
      print(value.data);

      emit(RegisterSuccessState());
    }).catchError((error) {
      print('########## ${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    });
  }
}
