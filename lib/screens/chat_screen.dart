import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:task_app/common_widgets/chat_bubble/receive_bubble.dart';
import 'package:task_app/common_widgets/chat_bubble/send_message.dart';
import 'package:task_app/models/conversation_model.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';
import 'package:task_app/utils/unique_id_gernator.dart';
import 'package:task_app/utils/extensions.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chatscreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final _speechTextClt = TextEditingController();
  bool isLoading = true;
  var messages = [
    const SentMessageScreen(message: "Hello"),
    const ReceivedMessageScreen(message: "Hi, how are you"),
    const SentMessageScreen(message: "I am great how are you doing"),
    const ReceivedMessageScreen(message: "I am also fine"),
    const SentMessageScreen(message: "Can we meet tomorrow?"),
    const ReceivedMessageScreen(
        message: "Yes, of course we will meet tomorrow"),
  ];
  bool _hasSpeech = false;
  final String defaultLanguage = 'en-US';

  TextToSpeech tts = TextToSpeech();

  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2
  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;

  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  // String _lastWords = '';

  @override
  void initState() {
    _initSpeech();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
    Future.delayed(Duration.zero, () {
      setInitialChat();
    });
    super.initState();
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await tts.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages = await tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await tts.getDisplayLanguageByCode(languageCode!);

    /// get voice
    voice = await getVoiceByLang(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  ///
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _speechTextClt.text = result.recognizedWords.capitalize();
      _hasSpeech = true;
    });
  }

  // void errorListener(SpeechRecognitionError error) {
  //   log('Received error status: $error, listening: ${speech.isListening}');
  //   setState(() {
  //     lastError = '${error.errorMsg} - ${error.permanent}';
  //   });
  // }

  // void statusListener(String status) {
  //   log('Received listener status: $status, listening: ${speech.isListening}');
  //   setState(() {
  //     lastStatus = status;
  //   });
  // }

  // Future<void> initSpeechState() async {
  //   log('Initialize');
  //   try {
  //     var hasSpeech = await speech.initialize(
  //       onError: errorListener,
  //       onStatus: statusListener,
  //       debugLogging: true,
  //     );
  //     if (hasSpeech) {
  //       // Get the list of languages installed on the supporting platform so they
  //       // can be displayed in the UI for selection by the user.
  //       _localeNames = await speech.locales();

  //       var systemLocale = await speech.systemLocale();
  //       _currentLocaleId = systemLocale?.localeId ?? '';
  //     }
  //     if (!mounted) return;

  //     setState(() {
  //       _hasSpeech = hasSpeech;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       lastError = 'Speech recognition failed: ${e.toString()}';
  //       _hasSpeech = false;
  //     });
  //   }
  // }

  setInitialChat() async {
    final provider = Provider.of<MyProvider>(context, listen: false);
    await provider.getChatData();
    provider.clearChats();
    provider.tempConversationId = GUIDGen.generate();
    provider.conversationList!.add(ConverstaionModel(
        chatId: provider.tempConversationId,
        chatTitle: 'Restaurant',
        time: DateTime.now().toString(),
        chatList: []));
    provider.insertBotSentence(botSentence: 'Hello');
    tts.speak(provider.capturedChats!.first!.text.toString());

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    log(jsonEncode(provider.capturedChats));
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   tts.speak('Hello Good Morning');
        // }),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: UiHelper.height(context) * 0.08,
                    child: Row(
                      children: [
                        SizedBox(
                          width: UiHelper.width(context) * 0.04,
                        ),
                        Text(
                          'Restaurant',
                          style: Styles.headingStyle3(isBold: true),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 20,
                            ),
                            SizedBox(
                              width: UiHelper.width(context) * 0.04,
                            ),
                            const Icon(
                              Icons.flag,
                              color: AppColors.purple,
                              size: 20,
                            ),
                            SizedBox(
                              width: UiHelper.width(context) * 0.04,
                            ),
                            const Icon(
                              Icons.settings,
                              color: AppColors.purple,
                              size: 20,
                            ),
                            SizedBox(
                              width: UiHelper.width(context) * 0.04,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        // padding: const EdgeInsets.all(20),
                        itemCount: provider.capturedChats!.length,
                        itemBuilder: (context, index) {
                          if (provider.capturedChats![index]!.userId == null) {
                            return ReceivedMessageScreen(
                              message: provider.capturedChats![index]!.text,
                              key: UniqueKey(),
                            );
                          } else {
                            return SentMessageScreen(
                              message: provider.capturedChats![index]!.text,
                              key: UniqueKey(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   // If listening is active show the recognized words
                          //   _speechToText.isListening
                          //       ? _lastWords
                          //       // If listening isn't active but could be tell the user
                          //       // how to start it, otherwise indicate that speech
                          //       // recognition is not yet ready or not supported on
                          //       // the target device
                          //       : _speechEnabled
                          //           ? 'Tap the microphone to start listening...'
                          //           : 'Speech not available',
                          // ),
                          // if (provider.getIsLoading == false)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_hasSpeech)
                                Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          _speechTextClt.clear();
                                          _hasSpeech = false;
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColors.purple,
                                          // size: 30,
                                        ),
                                      ),
                                    ),
                                    // const Spacer(),
                                    Expanded(
                                      flex: 3,
                                      child: TextFormField(
                                        controller: _speechTextClt,
                                        autofocus: true,
                                        // textAlign: TextAlign.end,
                                        // style: const TextStyle(
                                        //     color: Colors.white, fontSize: 30),
                                        decoration:
                                            const InputDecoration.collapsed(
                                          hintText: "",
                                          border: InputBorder.none,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    // Text(
                                    //   _lastWords,
                                    //   style: Styles.headingStyle5(),
                                    // ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        final provider =
                                            Provider.of<MyProvider>(context,
                                                listen: false);
                                        if (provider.isChatCompleted) {
                                          Fluttertoast.showToast(
                                              msg: 'chat is completed!!');
                                          return;
                                        }

                                        provider.matchInputSetence(
                                            botSentence: provider.capturedChats!
                                                .elementAt(provider
                                                        .capturedChats!.length -
                                                    1)!
                                                .text,
                                            humanSentence: _speechTextClt.text);
                                        tts.speak(provider
                                            .capturedChats!.last!.text
                                            .toString());
                                        await Future.delayed(
                                            const Duration(milliseconds: 1200));
                                        if (_scrollController.hasClients) {
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            curve: Curves.easeOut,
                                            duration: const Duration(
                                                milliseconds: 300),
                                          );
                                        }
                                        setState(() {
                                          _hasSpeech = false;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: AppColors.purple,
                                        size: 30,
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {},
                                    //   child: const Icon(
                                    //     Icons.send,
                                    //     color: AppColors.purple,
                                    //     size: 30,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              if (!_hasSpeech)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Suggestions",
                                    style: Styles.headingStyle4(),
                                  ),
                                ),
                              const Divider(),
                              ListTile(
                                leading: Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.yellow.shade700,
                                ),
                                title: Text(
                                  provider.reTry
                                      ? "Yes or no"
                                      : provider.nextSentence ?? "Yes or no",
                                  style: Styles.headingStyle5(),
                                ),
                                subtitle: Text(
                                  "Reply by",
                                  style: Styles.headingStyle5(isBold: true),
                                ),
                                trailing: const Icon(
                                  Icons.headset,
                                  color: AppColors.purple,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: IconButton(
                                    onPressed: () async {
                                      _speechToText.isNotListening
                                          ? _startListening()
                                          : _stopListening();

                                      // var endEleIndex =
                                      //     provider.capturedChats!.length - 1;
                                      // provider.capturedChats!.insert(endEleIndex,
                                      //     ChatModelRestaurant(bot: data!));
                                    },
                                    icon: Icon(
                                      _speechToText.isNotListening
                                          ? Icons.mic_off
                                          : Icons.mic,
                                      color: AppColors.purple,
                                      size: 30,
                                    )),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: IconButton(
                                    onPressed: () {
                                      // final provider = Provider.of<MyProvider>(
                                      //     context,
                                      //     listen: false);
                                      // var data = provider.matchInputSetence(
                                      //     botSentence: "Would you like some water?",
                                      //     humanSentence: "yes please");
                                      // Fluttertoast.showToast(msg: data.toString());
                                    },
                                    icon: const Icon(
                                      Iconsax.keyboard_open5,
                                      color: AppColors.purple,
                                      size: 28,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
