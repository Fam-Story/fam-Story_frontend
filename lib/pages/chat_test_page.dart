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
      // _loadChatHistory(); // 필요한 경우 활성화
    }).catchError((e) {
      _showErrorDialog("Failed to link web socket server: $e");
    });
  }

  void _loadChatHistory() async {
    try {
      var history = await ChatApiService.getChatHistory(1);
      setState(() {
        chatHistory = history;
      });
    } catch (e) {
      // 에러 핸들링: 채팅 히스토리 로딩 실패
      _showErrorDialog("Failed to load chat history: $e");
    }
  }

  void _sendChatMessage() {
    if (_messageController.text.isNotEmpty) {
      final chat = ChatModel(
        //TODO: 프로바이더로 수신
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
                  // 여기서 새 메시지를 리스트에 추가
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: 1, // 현재 스냅샷에 있는 하나의 메시지만 표시
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.message),
                        subtitle: Text("From: ${snapshot.data!.familyId}"),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
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
