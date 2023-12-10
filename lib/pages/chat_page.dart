import 'package:fam_story_frontend/models/family_member_model.dart';
import 'package:fam_story_frontend/services/family_member_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fam_story_frontend/style.dart';
import 'package:fam_story_frontend/controllers/chat_controller.dart';
import 'package:fam_story_frontend/models/chat_model.dart';
import 'package:fam_story_frontend/services/chat_api_service.dart';
import '../di/provider/id_provider.dart';
import 'chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController _chatController = ChatController();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatModel> chatHistory = []; // 채팅 히스토리를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() async {
    try {
      await _chatController
          .connectToServer(context.read<IdProvider>().familyId.toString());
      _chatController.listenToMessages();
      _loadChatHistory(); // 필요한 경우 활성화
    } catch (e) {
      _showErrorDialog("Failed to link web socket server: $e");
    }
  }

  void _loadChatHistory() async {
    try {
      var history =
          await ChatApiService.getChat(context.read<IdProvider>().familyId);
      setState(() {
        chatHistory = history;
        // 스크롤을 맨 아래로 이동
        _scrollToBottom();
      });
    } catch (e) {
      _showErrorDialog("Failed to load chat history: $e");
    }
  }

  void _sendChatMessage() {
    if (_messageController.text.isNotEmpty) {
      final chat = ChatModel(
        familyId: context.read<IdProvider>().familyId,
        familyMemberId: context.read<IdProvider>().familyMemberId,
        nickname: context.read<IdProvider>().nickname,
        role: context.read<IdProvider>().role,
        message: _messageController.text,
      );
      _chatController.sendMessage(chat);
      _messageController.clear();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _chatController.disconnect();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Chat",
                    style: TextStyle(
                        fontFamily: 'AppleSDGothicNeo',
                        fontWeight: FontWeight.bold,
                        color: AppColor.textColor,
                        fontSize: 35),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                    color: AppColor.swatchColor,
                    iconSize: 35,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: StreamBuilder<ChatModel>(
              stream: _chatController.messages,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // 새 메시지를 리스트의 끝(아래쪽)에 추가
                  chatHistory.add(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                // ListView를 역순으로 설정하여 최신 메시지가 아래에 표시되도록 함
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true, // 리스트를 역순으로 표시
                  itemCount: chatHistory.length,
                  itemBuilder: (context, index) {
                    // 역순 리스트에서의 인덱스 처리
                    final item = chatHistory[chatHistory.length - 1 - index];
                    //역할, 별명, 메시지, 시간, 본인 확인
                    return ChatBubbles(
                      item.role ?? 999,
                      item.nickname ?? 'No Nickname',
                      item.message,
                      item.date ?? 'No date',
                      item.familyMemberId ==
                          context.read<IdProvider>().familyMemberId,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _messageController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Enter a message",
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: AppColor.swatchColor,
                  ),
                  onPressed: _sendChatMessage,
                ),
                fillColor: AppColor.subColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 30.0),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
