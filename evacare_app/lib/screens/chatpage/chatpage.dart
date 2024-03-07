import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:evacare_app/core/const/api.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPagrState();
}

class _ChatPagrState extends State<ChatPage> {
  final openAI = OpenAI.instance.build(
    token: openAIKey,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 2
      )
    ),
    enableLog: true
  );
  final gptUser = ChatUser(id: '1');
  // final String email = FirebaseAuth.instance.currentUser.email;
  // final String uid = FirebaseAuth.instance.currentUser!.uid;
  List<ChatMessage> messages = <ChatMessage>[];
  // final String userName = FirebaseAuth.instance.currentUser!.displayName!;
  List<ChatUser> typingUser = <ChatUser> [];
  @override
  Widget build(BuildContext context) {
    final currentUser = ChatUser(id: '2', firstName: 'Me');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Eva Care'
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 2,
        scrolledUnderElevation: 2,
      ),
      body: DashChat(
        currentUser: currentUser,
        typingUsers: typingUser,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.lightBlue,
          textColor: Colors.black
        ),
        onSend: (ChatMessage chatmessage) {
          getChatResponse (chatmessage);
        },
        messages: messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      messages.insert(0, m);
    });
    typingUser.add(gptUser);
    List<Messages> messageHistory = messages.reversed.map((m) {
      if(m.user == 'me') {
        return Messages(
          role: Role.user, 
          content: m.text
        );
      } else {return Messages(
          role: Role.assistant, 
          content: m.text
        );
      }
    }).toList();

    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(), 
      messages: messageHistory,
      maxToken: 400
    );
    final reponse = await openAI.onChatCompletion( request: request);
    for (var element in reponse!.choices) {
      if (element.message != null) {
        setState(() {
          messages.insert(0, ChatMessage(
            user: gptUser, createdAt: DateTime.now(),
            text: element.message!.content));
        });
        await saveChatData(m.text, element.message!.content);
      }
    }    
    setState(() {
      typingUser.remove(gptUser);
    });
  }

  Future<void> saveChatData(String prompt, String response) async {
  final chatRef = FirebaseFirestore.instance.collection('evaCare_Chats').doc('me');
  await chatRef.collection('messages').add({
    'sender': 'me',
    'prompt': prompt,
    'response': response,
    'timestamp': DateTime.now(),
  });
}

}