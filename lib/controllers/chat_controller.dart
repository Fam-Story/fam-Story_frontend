import 'dart:async';
import 'dart:convert';

import 'package:fam_story_frontend/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController {
  late IO.Socket socket;
  final _messageStreamController = StreamController<ChatModel>.broadcast();

  Stream<ChatModel> get messages => _messageStreamController.stream;

  Future<void> connectToServer() async {
    const serverUrl = "https://famstory.thisiswandol.com/chat";

    // const storage = FlutterSecureStorage();
    // // 로그인 토큰 불러오기
    // String? userInfoString = await storage.read(key: 'login');

    // if (userInfoString == null) {
    //   throw ErrorDescription('Your login token has expired. Please Login Again.');
    // }
    // Map<String, dynamic> userInfo = json.decode(userInfoString);
    // String loginToken = userInfo['token'];

    // print('socket start');
    try {
      // socket = IO.io(
      //     serverUrl,
      //     IO.OptionBuilder()
      //         .setTransports(['websocket'])
      //         .disableAutoConnect() // disable auto-connection
      //         .setExtraHeaders({
      //           'Authorization': 'Bearer $loginToken',
      //         }) // optional
      //         .build());

      socket = IO.io(serverUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        // Socket.IO 클라이언트 버전 설정 (v4)
        'forceNew': true,
      });

      socket.connect();

      socket.onConnectError((data) => print('Connect Error: $data'));
      socket.onConnectTimeout((data) => print('Connect Timeout: $data'));
      socket.onError((data) => print('Error: $data'));

      socket.onConnect((_) {
        print('Connected');
        socket.emit('joinFamily', {'familyId': '8'});
        print('joinFamily!!!!!');
      });
      socket.onDisconnect((_) => print('Disconnected'));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void sendMessage(ChatModel chat) {
    socket.emit('sendMessage', chat.toChatDto());
  }

  void listenToMessages() {
    socket.on('receiveMessage', (chatDto) {
      final chatModel = ChatModel.fromChatDto(chatDto);
      _messageStreamController.add(chatModel);
    });
  }

  void disconnect() {
    if (socket.connected) {
      socket.disconnect();
    }
  }

  void dispose() {
    _messageStreamController.close();
    socket.dispose();
  }
}
