import 'package:chat_app/Const/const.dart';
import 'package:chat_app/Model/message_model.dart';
import 'package:flutter/material.dart';

class Customchatmessage extends StatelessWidget {
  const Customchatmessage({super.key, required this.messageModel});
  final Message messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding:
            const EdgeInsets.only(left: 17, top: 17, right: 17, bottom: 17),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(
          messageModel.message,
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }
}

//_________________________________

class CustomchatmessageFromFriend extends StatelessWidget {
  const CustomchatmessageFromFriend({super.key, required this.messageModel});
  final Message messageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding:
            const EdgeInsets.only(left: 17, top: 17, right: 17, bottom: 17),
        decoration: BoxDecoration(
          color: ksecondaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Text(
          messageModel.message,
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }
}
