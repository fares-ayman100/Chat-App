import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
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
      } else if (event is SignUpEvent) {
        emit(SignupLoading());
        try {
          UserCredential credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
    });
  }
}
