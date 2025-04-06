import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TalkWithAIPage extends StatefulWidget {
  const TalkWithAIPage({super.key});

  @override
  _TalkWithAIPageState createState() => _TalkWithAIPageState();
}

class _TalkWithAIPageState extends State<TalkWithAIPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  final String apiKey =
      "AIzaSyBQiaV40HxiWhvBOEm7350bufMJC4Htq50"; // Replace with your API key
  final String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=";

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add("You: $message");
    });

    final Uri uri = Uri.parse("$apiUrl$apiKey");

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": message}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData.containsKey('candidates') &&
          responseData['candidates'].isNotEmpty &&
          responseData['candidates'][0].containsKey('content') &&
          responseData['candidates'][0]['content'].containsKey('parts') &&
          responseData['candidates'][0]['content']['parts'].isNotEmpty) {
        String aiResponse =
            responseData['candidates'][0]['content']['parts'][0]['text'];

        setState(() {
          _messages.add("AI: $aiResponse");
        });
      } else {
        setState(() {
          _messages.add("AI: Unexpected response format");
        });
      }
    } else {
      setState(() {
        _messages.add("AI: Error fetching response");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade100],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "TALK WITH AI",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Spacer(),
                      Icon(Icons.circle, color: Colors.purple, size: 8),
                      SizedBox(width: 5),
                      Icon(Icons.circle, color: Colors.green, size: 8),
                      SizedBox(width: 5),
                      Icon(Icons.circle, color: Colors.red, size: 8),
                      SizedBox(width: 5),
                      Icon(Icons.circle, color: Colors.orange, size: 8),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Meet ClaraAI, your smart health companion, providing AI-driven insights and early detection for better well-being.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Divider(thickness: 1),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message.startsWith("You: ");
                  final displayMessage = message
                      .replaceFirst("You: ", "")
                      .replaceFirst("AI: ", "");

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.grey.shade300
                            : Colors.blue.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: Radius.circular(isUser ? 20 : 0),
                          bottomRight: Radius.circular(isUser ? 0 : 20),
                        ),
                      ),
                      child: Text(
                        isUser ? displayMessage : "✨ $displayMessage",
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "How can I help you?",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            _sendMessage(_controller.text);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
