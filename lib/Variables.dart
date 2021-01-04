import 'package:flutter_emoji/flutter_emoji.dart';

class Variables {
  final String isLoggedIn = "isLoggedIn";
  final String phoneNumber = "phone_number";
  //final String minusCharacter = '−';
  final String minusCharacter = '-';
  var parser = EmojiParser();
  String score0 = EmojiParser().get('disappointed').code;
  String score1 = EmojiParser().get('worried').code;
  String score2 = EmojiParser().get('neutral_face').code;
  String score3 = EmojiParser().get('grin').code;
  String score4 = EmojiParser().get('smile').code;

  final int maxScore = 4;
}
