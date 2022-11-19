import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:green_ai/answer.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  speechToText.SpeechToText? speech;
  String textString = "Press The Button";
  bool isListen = false;
  double confidence = 1.0;

  void listen() async {
    if (!isListen) {
      bool avail = await speech!.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        var locales = await speech!.locales();
        print("LOCALES:${locales.length}");
        speech!.listen(onResult: (value) {
          setState(() {
            textString = value.recognizedWords;
            if (value.hasConfidenceRating && value.confidence > 0) {
              confidence = value.confidence;
            }
          });
        });
      }
    } else {
      setState(() {
        isListen = false;
      });
      speech!.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice assistance"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              "Confidence: ${(confidence * 100.0).toStringAsFixed(1)}%",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              textString,
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          answer(),
        ],
      ),
      floatingActionButton: AvatarGlow(
        animate: isListen,
        glowColor: Colors.red,
        endRadius: 65.0,
        duration: Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          child: Icon(isListen ? Icons.mic : Icons.mic_none),
          onPressed: () {
            listen();
          },
        ),
      ),
    );
  }
}
