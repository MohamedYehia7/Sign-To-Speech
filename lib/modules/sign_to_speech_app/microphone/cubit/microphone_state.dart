abstract class MicrophoneStates {}

class MicrophoneInitialState extends MicrophoneStates {}

class MicrophoneLoadingState extends MicrophoneStates {}

class MicrophoneSuccessState extends MicrophoneStates {}

class MicrophoneErrorState extends MicrophoneStates {
  final String error;

  MicrophoneErrorState(this.error);
}