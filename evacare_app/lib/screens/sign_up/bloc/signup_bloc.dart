import 'package:flutter_bloc/flutter_bloc.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignInTappedEvent>((event, emit) async {
      emit(SignInTappedState());
    });
  }
  Stream<SignInTappedState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignInTappedEvent) {
      yield SignInTappedState();
    }
  }
}
