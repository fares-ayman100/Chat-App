import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailuer(errMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailuer(errMessage: 'wrong-password'));
      }
    } on Exception catch (e) {
      emit(LoginFailuer(errMessage: e.toString()));
    }
  }

  //_________________________________

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
