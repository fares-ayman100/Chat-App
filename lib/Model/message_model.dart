import 'package:chat_app/Constant/const.dart';

class Message {
  final String message;
  final String? id;
  Message(this.message, this.id);
  factory Message.fromJson(jsonData) {
    return Message(jsonData[kcontainDocument], jsonData['id']);
  }
}
