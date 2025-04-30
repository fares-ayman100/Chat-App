import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> registerMethod(
      {required String email, required String password}) async {
    emit(SignupLoading());
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailuer(errMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailuer(errMessage: 'email-already-in-use'));
      }
    } on Exception catch (e) {
      emit(SignupFailuer(errMessage: e.toString()));
    }
  }
}
