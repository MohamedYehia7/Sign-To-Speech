import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signtospeech/model/sign_to_speech_app/gif_model.dart';
import 'package:signtospeech/modules/sign_to_speech_app/microphone/cubit/microphone_state.dart';
import 'package:signtospeech/network/dio_helper.dart';
import 'package:signtospeech/shared/components/components.dart';

class MicrophoneCubit extends Cubit<MicrophoneStates> {
  MicrophoneCubit() : super(MicrophoneInitialState());

  static MicrophoneCubit get(context) => BlocProvider.of(context);

   GifModel? gifModel;

  void getGif({required String keyword}) {
    emit(MicrophoneLoadingState());
    DioHelper.getData(url: "GetGif", query: {
      'keyword': keyword,
    },
      token: token
    ).then((value) {
      // print(value.data);
      gifModel = GifModel.fromJson(value.data);
      print(gifModel?.gifUrl);
      emit(MicrophoneSuccessState());
    }).catchError((error) {
      print('########## ${error.toString()}');
      emit(MicrophoneErrorState(error.toString()));
    });
  }

}