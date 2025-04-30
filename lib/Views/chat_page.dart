import 'package:chat_app/Auth/Login.dart';
import 'package:chat_app/Const/const.dart';
import 'package:chat_app/Model/message_model.dart';
import 'package:chat_app/Widgets/customChatMessage.dart';
import 'package:chat_app/cubit/chat/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static String id = 'HomePage';
  final ScrollController controller = ScrollController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController message_controlleer = TextEditingController();
  //List<Message> messageList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kprimaryColor,
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.id, (route) => false);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kLogo,
                height: 60,
                width: 50,
              ),
              const Text(
                ' Chat',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  var messageList =
                      BlocProvider.of<ChatCubit>(context).messageList;
                  return ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? Customchatmessage(messageModel: messageList[index])
                          : CustomchatmessageFromFriend(
                              messageModel: messageList[index]);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                style: const TextStyle(fontSize: 23),
                onFieldSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(message: data, email: email.toString());
                  controller.animateTo(0,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.ease);

                  message_controlleer.clear();
                },
                controller: message_controlleer,
                decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(18),
                  suffixIcon: IconButton(
                    onPressed: () {
                      String message = message_controlleer.text;
                      if (message.isNotEmpty) {
                        message_controlleer.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      size: 30,
                      color: kprimaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
