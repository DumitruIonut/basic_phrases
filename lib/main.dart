import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasicPhrases());
}

class BasicPhrases extends StatelessWidget {
  const BasicPhrases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> expression = <String>[
    'Bine ai venit! ',
    'いらっしゃいませ！',
    'E ceva în neregulă? ',
    '何か間違えている？',
    'Mult noroc! ',
    '幸運を！',
    'Mulțumesc pentru tot! ',
    'すべてに感謝します！'
  ];
  final List<String> audio = <String>[
    'Bine ai venit!.mp3',
    'Bine ai venit! - いらっしゃいませ！.mp3',
    'E ceva în neregulă_.mp3',
    'E ceva în neregulă ？- 何か間違えている？.mp3',
    'Mult noroc!.mp3',
    'Mult noroc! - 幸運を！.mp3',
    'Mulțumesc pentru tot!.mp3',
    'Mulțumesc pentru tot! - すべてに感謝します！.mp3'
  ];
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    final double itemHeight = MediaQuery.of(context).size.height / 4 * 0.88;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Phrases - Japanese'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10.0),
        childAspectRatio: itemWidth / itemHeight,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        crossAxisCount: 2,
        children: List<Widget>.generate(8, (int index) {
          return GestureDetector(
            onTap: () async {
              final File file = await audioCache.loadAsFile(audio[index]);
              final Uint8List bytes = await file.readAsBytes();
              audioCache.playBytes(bytes);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              alignment: Alignment.center,
              child: Text(
                expression[index],
                style: const TextStyle(color: Colors.black87, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      ),
    );
  }
}
