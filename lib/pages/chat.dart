// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screnn';

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = false;
  bool _isListening = false;
  final List<String> messages = [
    'Hello, how are you?',
    'Flutter is awesome!',
    'I love coding in Dart.',
    'What\'s your favorite programming language?',
    'This is a random message.',
    'Flutter is great for building cross-platform apps.',
    'Dart is a language optimized for building mobile, desktop, server, and web applications.',
    'Let\'s build something amazing with Flutter!',
  ];

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final speech = stt.SpeechToText();
    double _buttonSize = 60;
    double _borderRadius = 30;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("lib/img.jpg"),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manjunath K.V',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Online',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Handle video call button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Handle voice call button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options button press
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  padding: const EdgeInsets.all(5.0),
                  controller: _listScrollController,
                  reverse: true,
                  itemCount: messages.length, //chatList.length,
                  itemBuilder: (context, index) {
                    return ChatMessage(
                      text: messages[index], // chatList[index].msg,
                      chatIndex: index, //chatList[index].chatIndex,
                      // shouldAnimate:
                      //     chatProvider.getChatList.length - 1 == index,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const Divider(height: 1.0),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: SizedBox(
                //height: 90,
                child: Row(
                  children: [
                    //MIC STT
                    CircleAvatar(
                      backgroundColor: const Color(0xff17CE92),
                      radius: 25,
                      child: GestureDetector(
                        onTapUp: (details) {
                          speech.stop();
                          setState(() {
                            _isListening = false;
                            _buttonSize = 50.0;
                            _borderRadius = 25.0;
                          });
                        },
                        onTapDown: (details) async {
                          final isAvailable = await speech.initialize();
                          if (isAvailable) {
                            setState(() {
                              _isListening = true;
                              _buttonSize = 60.0;
                              _borderRadius = 30.0;
                            });
                            await speech.listen(
                              onResult: (result) {
                                textEditingController.text =
                                    result.recognizedWords;
                              },
                            );
                          }
                        },
                        //  child:  Icon(Icons.mic,color: _isListening ? Colors.blue : Colors.white,)
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: _buttonSize,
                          height: _buttonSize,
                          decoration: BoxDecoration(
                            color: const Color(0xff17CE92),
                            borderRadius: BorderRadius.circular(_borderRadius),
                          ),
                          child: Icon(
                            _isListening ? Icons.mic : Icons.mic_none_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // child: IconButton(
                      //   icon: const Icon(
                      //     Icons.mic,
                      //     color: Colors.white,
                      //   ),
                      //   onPressed: () {
                      //     // logic for mic button
                      //   },
                      // ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black12,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 30, top: 10, bottom: 10),
                                child: TextField(
                                  controller: textEditingController,
                                  onSubmitted: null,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: 'How can I help you',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 167, 166, 166),
                                      fontFamily: 'Gotham',
                                    ),
                                    filled: false,

                                    // textAlign: TextAlign.center,
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: const Color(0xff17CE92),
                      radius: 25,
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          //Here we will add the logic to send the message
                          if (textEditingController.text.isNotEmpty) {
                            setState(() {
                              messages.insert(0, textEditingController.text);
                            });

                            textEditingController.clear();
                            scrollListToEND();
                          }
                        },
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({
    super.key,
    required this.text,
    required this.chatIndex,
  });

  final String text;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment:
            (chatIndex == 0) ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: (chatIndex == 0)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        color: const Color(0xff17CE92),
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular((chatIndex == 0) ? 15.0 : 0),
                          bottomRight:
                              Radius.circular((chatIndex == 0) ? 0 : 15.0),
                          topLeft: const Radius.circular(15.0),
                          topRight: const Radius.circular(15.0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Gotham',
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Visibility(
                        visible: !(chatIndex == 0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(70),
                          onTap: () {},
                          child: const Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: !(chatIndex == 0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(70),
                          onTap: () async {
                            FlutterTts flutterTts = FlutterTts();
                            flutterTts.setLanguage("en-US");
                            flutterTts.setPitch(1.0);
                            flutterTts.setSpeechRate(0.5);
                            await flutterTts.speak(
                              text.toString(),
                            );
                          },
                          child: const Icon(
                            Icons.mic,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
