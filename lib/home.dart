import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  TextEditingController _textController = TextEditingController();

  void sendMessage(String message) {
    print(message);

    WebSocketChannel channel;
    try {
      channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3000'));
      channel.sink.add(message);

      channel.stream.listen((message) {
        print(message);
        channel.sink.close();
      });
    } catch (e) {
      print("error is : $e");
    }
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Web socket"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter Text ",
              ),
              controller: _textController,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
            onPressed: () {
              sendMessage(_textController.text);
            },
            icon: const Icon(
              Icons.send,
              size: 15,
            ),
            label: const Text("Send"),
          ),
        ],
      ),
    );
  }
}
