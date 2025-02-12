import 'package:chat_app/Const/const.dart';

class MessageModel {
  final String message;
  final String? id;
  MessageModel(this.message, this.id);
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData[kcontainDocument], jsonData['id']);
  }
}
