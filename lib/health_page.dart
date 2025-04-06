import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    const videoUrl = 'https://youtu.be/-eGhAUUd4RY';
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HEALTH"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              "Our AI model, developed using Google Cloud’s Vertex AI AutoML, is trained to detect signs of anemia from images of nails and eye conjunctiva. Leveraging a custom dataset, the model achieved promising results in accurately classifying anemic and non-anemic cases. While the model performs well within the Vertex AI platform, integrating the AutoML model directly into our Flutter app proved to be a complex challenge due to limitations in real-time inference, API authentication, and compatibility with mobile frameworks. As a result, the current MVP demonstrates the AI model’s potential through a standalone test video, which we’ve linked below to showcase the model’s functionality on the Vertex AI platform. Full integration into the app is planned for the next development phase.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
