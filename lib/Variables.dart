import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Variables {
  final String isLoggedIn = "isLoggedIn";
  final String phoneNumber = "phone_number";
  final String minusCharacter = '−';
  final String multiplyCharacter = '×';
  final String divideCharacter = '÷';

  var parser = EmojiParser();
  String score0 = EmojiParser().get('disappointed').code;
  String score1 = EmojiParser().get('worried').code;
  String score2 = EmojiParser().get('neutral_face').code;
  String score3 = EmojiParser().get('grin').code;
  String score4 = EmojiParser().get('smile').code;

  final int maxScore = 4;
  List<List<String>> levelDetails = [
    [
      "Single Digit , 5 rows - 10 Questions\n\nAnswer will be positive",
      "Single Double Digit, 5 rows - 10 Questions\n\nAnswer will be positive",
      "Single Double Triple Digit, 3 rows - 10 Questions\n\nAnswer will be positive",
      "Single Double Triple Digit, 4 rows - 10 Questions\n\nAnswer can be negative",
      "Single Double Triple Four Digit, 4 rows - 10 Questions\n\nAnswer can be negative",
      "Single Double Triple Four Five Digit, 4 rows - 10 Questions\n\nAnswer can be negative",
    ],
    [
      "Single Digit x Single Digit Multiplication - 10 Questions",
      "Double Digit x Single Digit Multiplication - 10 Questions",
      "Triple Digit x Single Digit Multiplication - 10 Questions\n\nDouble Digit x Double Digit Multiplication - 10 Questions",
      "Triple Digit x Double Digit Multiplication - 10 Questions",
      "Triple Digit x Triple Digit Multiplication - 10 Questions\n\nFour Digit x Double Digit Multiplication - 10 Questions",
    ],
    [
      "Single Digit Number division by Single Digit - 10 Questions",
      "Double Digit Number division by Single Digit - 10 Questions",
      "Four Digit Number division by Double Digit - 10 Questions",
      "Five Digit Number division by Three Digit - 10 Questions",
    ],
    [
      "Addition Subtraction - Level 1 and Level 2\n\nMuliplication - Level 2",
      "Addition Subtraction - Level 3 and Level 4\n\nMuliplication - Level 3 and Level 4\nDivision - Level 3 and Level 4",
      "Addition Subtraction - Level 5 and Level 6\n\nMuliplication - Level 5 and Level 6\nDivision - Level 5 and Level 6",
    ]
  ];
}
