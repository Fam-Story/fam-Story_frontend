import 'package:fam_story_frontend/controllers/chat_controller.dart';
import 'package:fam_story_frontend/models/chat_model.dart';
import 'package:fam_story_frontend/services/chat_api_service.dart';
import 'package:flutter/material.dart';

class ChatTestPage extends StatefulWidget {
  const ChatTestPage({super.key});

  @override
  _ChatTestPageState createState() => _ChatTestPageState();
}

class _ChatTestPageState extends State<ChatTestPage> {
  final ChatController _chatController = ChatController();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatModel> chatHistory = []; // 채팅 히스토리를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _chatController.connectToServer().then((_) {
      _chatController.listenToMessages();
      _loadChatHistory(); // 필요한 경우 활성화
    }).catchError((e) {
      _showErrorDialog("Failed to link web socket server: $e");
    });
  }

  void _loadChatHistory() async {
    try {
      var history = await ChatApiService.getChat(8);
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
        //TODO: 프로바이더 Provider로 수신
        familyId: 8,
        familyMemberId: 6,
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
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: <Widget>[
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
                    return ListTile(
                      title: Text(item.message),
                      subtitle: Text("From: ${item.familyId}"),
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
              decoration: InputDecoration(
                hintText: "Enter a message",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendChatMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
