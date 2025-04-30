import 'package:bloc/bloc.dart';
import 'package:chat_app/Constant/const.dart';
import 'package:chat_app/Model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kprimaryCollection);
  List<Message> messageList = [];
  void sendMessage({required String message, required String email}) {
    messages.add({'message': message, 'Time': DateTime.now(), 'id': email});
  }

  void getMessage() {
    messages.orderBy('Time', descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
