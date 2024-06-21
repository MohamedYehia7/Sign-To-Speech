import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signtospeech/model/sign_to_speech_app/login_model.dart';
import 'package:signtospeech/modules/sign_to_speech_app/microphone/cubit/microphone_state.dart';
import 'package:signtospeech/modules/sign_to_speech_app/setting/cubit/user_states.dart';
import 'package:signtospeech/network/dio_helper.dart';
import 'package:signtospeech/shared/components/components.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void getUser() {
    emit(UserLoadingState());
    DioHelper.getData(url: "GetUser",
        token: token
    ).then((value) {
      // print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel?.user?.firstName);
      emit(UserSuccessState());
    }).catchError((error) {
      print('########## ${error.toString()}');
      emit(UserErrorState(error.toString()));
    });
  }

}