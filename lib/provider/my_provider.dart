import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/models/chat_model.dart';
import 'package:task_app/models/conversation_model.dart';
import 'package:task_app/models/custom_chat_model.dart';
import 'package:task_app/models/user_model.dart';
import 'package:task_app/utils/constants.dart' as constants;
import 'package:task_app/utils/shared_preference.dart';
import 'package:task_app/utils/unique_id_gernator.dart';

class MyProvider extends ChangeNotifier {
  late String? _password;
  double? _strength = 0;
  String? tempConversationId = '0';
  String? _nextSentence;
  String? _previousSentence;
  int? tempIndex = 0;
  Dio? dio = Dio();
  bool reTry = false;
  bool _islListning = false;
  bool isChatCompleted = false;
  bool isLoading = false;
  UserModel? _user = UserModel();
  UserModel? get user => _user;
  bool get getReTry => reTry;
  bool get getIsLoading => isLoading;
  bool get getIsChatCompleted => isChatCompleted;
  bool get islListning => _islListning;
  List<ChatModelRestaurant?>? _restaurant;
  String? get getTempConversationId => tempConversationId;
  List<CustomChatModel?>? capturedChats = [];
  final List<ConverstaionModel?>? conversationList = [];
  List<ConverstaionModel?>? get getConversationList => conversationList;
  List<CustomChatModel?>? get getCapturedChats => capturedChats!;

  List<ChatModelRestaurant?>? get restaurant => [..._restaurant ?? []];

  // RegExp? numReg = RegExp(r".*[0-9].*");
  // RegExp? letterReg = RegExp(r".*[A-Za-z].*");
  // RegExp regex =
  //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
/*       r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])      // should contain at least one digit
  (?=.*?[!@#\$&*~]) // should contain at least one Special character
  .{8,}             // Must be at least 8 characters in length
$ */
  double? get strength => _strength;
  String? get displayText => _displayText;
  String? get nextSentence => _nextSentence;
  String? get previousSentence => _previousSentence;

  String _displayText = 'Please enter a password';

  void checkPassword(String value) {
    _password = value.trim();

    if (_password!.isEmpty) {
      _strength = 0;
      _displayText = 'Please enter you password';
    } else if (_password!.length < 6) {
      _strength = 1 / 4;
      _displayText = 'Your password is too short';
    } else if (_password!.length < 8) {
      _strength = 2 / 4;
      _displayText = 'Your password is acceptable but not strong';
    } else {
      if (!constants.passwordRegExp.hasMatch(_password!)
          // ||
          // !letterReg!.hasMatch(_password!) ||
          // !numReg!.hasMatch(_password!)
          ) {
        // Password length >= 8
        // But doesn't contain both letter and digit characters
        _strength = 3 / 4;
        _displayText = 'Your password is strong';
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        _strength = 1;
        _displayText = 'Your password is great';
      }
    }
    notifyListeners();
  }

  String? matchInputSetence({String? botSentence, String? humanSentence}) {
    inserHumanSentence(humanSentence);
    // _islListning = false;
    String? result = "Oops you missed something! Do you want to try again";
    String? human =
        humanSentence!.toLowerCase().replaceAll(RegExp(",|!|'"), "");

    String? bot = _islListning
        ? previousSentence!.toLowerCase().replaceAll(RegExp(",|!|'"), "")
        : botSentence!.toLowerCase().replaceAll(RegExp(",|!|'"), "");
    _islListning = false;
    log("Before->>");
    log("$human\t $bot");
    if (reTry) {
      if (human == 'no') {
        reTry = false;
        isLoading = true;
        // await Future.delayed(const Duration(seconds: 1));
        result = " You could say '${restaurant![tempIndex!]!.human}'";
        // capturedChats!.add(CustomChatModel(
        //   text: _result,
        //   textId: GUIDGen.generate(),
        //   time: DateTime.now().toString(),
        // ));
        insertBotSentence(botSentence: result);

        // await Future.delayed(const Duration(seconds: 1));
        isLoading = false;
        // Future.delayed(const Duration(seconds: 1)).then((value) {
        var nextIndex = tempIndex! + 1;
        tempIndex = nextIndex;
        if (tempIndex == _restaurant!.length) {
          isChatCompleted = true;
          result = 'Thank you!!';
          log("Result--> $result");
          // inserHumanSentence(humanSentence);
          // capturedChats!.add(CustomChatModel(
          //   text: _result,
          //   textId: GUIDGen.generate(),
          //   time: DateTime.now().toString(),
          // ));
          insertBotSentence(botSentence: result);
          // notifyListeners();
          return result;
        }
        result = restaurant![nextIndex]!.bot;
        insertBotSentence(botSentence: result);
        // capturedChats!.add(CustomChatModel(
        //   text: _result,
        //   textId: GUIDGen.generate(),
        //   time: DateTime.now().toString(),
        // ));
        notifyListeners();
        return result;
      } else {
        reTry = false;
        result = 'I am listening';
        _islListning = true;
        // capturedChats!.add(CustomChatModel(
        //   text: _result,
        //   textId: GUIDGen.generate(),
        //   time: DateTime.now().toString(),
        // ));
        insertBotSentence(botSentence: result);
        getPreviousSentence();
        //  tempsentence =  restaurant[tempIndex-1]
        notifyListeners();
        return result;
      }
    }
    var index = restaurant!.indexWhere(
      (element) =>
          element!.bot!.toLowerCase().replaceAll(RegExp(",|!|'"), "") == bot &&
          element.human!.toLowerCase().replaceAll(RegExp(",|!|'"), "") == human,
    );
    log('index-->$index');
    // var data = restaurant!.firstWhere(
    //     (element) =>
    //         humanSentence!.toLowerCase() == element!.human!.toLowerCase() &&
    //         element.bot == botSentence!.toLowerCase(),
    //     orElse: () => null);
    if (index == -1) {
      isLoading = true;
      reTry = true;
      result = "Your sentence is invalid! Do you want to try again?";
      // capturedChats!.add(ChatModelRestaurant(bot: _result ));
      // inserHumanSentence(humanSentence);

      // capturedChats!.add(CustomChatModel(
      //   text: _result,
      //   textId: GUIDGen.generate(),
      //   time: DateTime.now().toString(),
      // ));
      // insertBotSentence(botSentence: result);
      // await Future.delayed(const Duration(seconds: 1));
      // result = 'Do you want to try again?';
      insertBotSentence(botSentence: result);
      isLoading = false;
      log("Result--> $result");
      notifyListeners();
      return result;
    }
    // return _result =
    index = index + 1;
    tempIndex = index;
    if (index == _restaurant!.length) {
      result = 'Thank you!!';
      log("Result--> $result");
      // inserHumanSentence(humanSentence);
      // capturedChats!.add(CustomChatModel(
      //   text: _result,
      //   textId: GUIDGen.generate(),
      //   time: DateTime.now().toString(),
      // ));
      insertBotSentence(botSentence: result);
      return result;
    } else {
      result = restaurant![index]!.bot;
    }
    log("Result--> $result");
    // inserHumanSentence(humanSentence);

    // capturedChats!.add(CustomChatModel(
    //   text: _result,
    //   textId: GUIDGen.generate(),
    //   time: DateTime.now().toString(),
    //   isValid: true, //for checking end valid message.
    // ));
    insertBotSentence(botSentence: result);
    notifyListeners();
    return result;
  }

  getNextSentence() {
    if (tempIndex == restaurant!.length - 1) {
      return _nextSentence = "Thank You";
    }
    var data = _restaurant!.elementAt(tempIndex!);
    if (data == null) {
      _nextSentence = "Thank You";
    } else {
      _nextSentence = data.human;
    }
    notifyListeners();
  }

  getPreviousSentence() {
    if (tempIndex == restaurant!.length - 1) {
      return "Thank You";
    }
    var data = _restaurant!.elementAt(tempIndex!);
    if (data == null) {
      _previousSentence = "Thank You";
    } else {
      _previousSentence = data.bot;
    }
    notifyListeners();
  }

  insertBotSentence({String? botSentence}) {
    capturedChats!.add(CustomChatModel(
      text: botSentence,
      textId: GUIDGen.generate(),
      time: DateTime.now().toString(),

      //for checking end valid message.
    ));

    for (var element in conversationList!) {
      if (element!.chatId == tempConversationId) {
        element.chatList!.clear();
        element.chatList!.addAll(capturedChats!);
        element.time = DateTime.now().toString();
      }
    }
    getNextSentence();
    // log(conversationList!.length.toString());

    notifyListeners();
  }

  inserHumanSentence(
    String? humanSentence,
    // String? botSetntence,
  ) {
    capturedChats!.add(CustomChatModel(
        text: humanSentence,
        textId: GUIDGen.generate(),
        time: DateTime.now().toString(),
        userId: 1));
    // var ele = _conversationList!.firstWhere(
    //     (element) => element!.chatId == tempConversationId,
    //     orElse: () => null);
    // if (ele == null) return;
    for (var element in conversationList!) {
      if (element!.chatId == tempConversationId) {
        element.chatList!.clear();
        element.chatList!.addAll(capturedChats!);
        element.time = DateTime.now().toString();
      }
      // log(conversationList!.length.toString());
    }
    getNextSentence();
    // var endEleIndex = capturedChats!.length - 1;
    // capturedChats![endEleIndex]!.isMe = true;
    // capturedChats!.insert(
    //     endEleIndex,
    //     ChatModelRestaurant(
    //       bot: capturedChats![endEleIndex]!.bot,
    //       human: humanSentence,
    //     ));
    notifyListeners();
  }

  clearChats() {
    tempConversationId = "0";
    tempIndex = 0;
    isChatCompleted = false;
    isLoading = false;
    isChatCompleted = false;
    _islListning = false;
    reTry = false;
    capturedChats!.clear();
    notifyListeners();
  }

  Future<int?> getChatData() async {
    try {
      log("${constants.chatData}");
      final response = await dio!.get(constants.chatData!);
      // Map<String, dynamic>? json =
      //     jsonDecode(response.data) as Map<String, dynamic>;
      log(jsonEncode(response.data));
      ChatModel chatModel = ChatModel.fromJson(response.data);
      _restaurant = chatModel.restaurant;

      // log(_restaurant!.length.toString());
      notifyListeners();
      return response.statusCode;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
      rethrow;
    } on TimeoutException {
      Fluttertoast.showToast(msg: "Request Timed Out, please try later!");
      // log(err.message.toString());
      rethrow;
    } catch (e) {
      log("${constants.chatData!} api error  -> ${e.toString()}");
      rethrow;
    }
  }

  signUp(UserModel user) async {
    log("saved data-->${jsonEncode(user)}");
    await Future.delayed(const Duration(seconds: 2));
    await MySharedPreferences.instance.setStringValue('user', jsonEncode(user));
  }

  getUser() async {
    await MySharedPreferences.instance.reload();
    var data = await MySharedPreferences.instance.getStringValue('user');
    // inspect(data);
    // log(data.toString());
    if (data == null || data.isEmpty) return;
    log("fetched data from pref-->$data");
    var json = jsonDecode(data);
    _user = UserModel.fromJson(json);
  }
}
