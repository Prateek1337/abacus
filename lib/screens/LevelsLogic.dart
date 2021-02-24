import 'dart:math';
import '../Variables.dart';

class AdditionLevelUtils {
  int _range1, _range2, numberOfValues;
  bool _valueIsPos, _ansIsPos;
  AdditionLevelUtils(
    this._range1,
    this._range2,
    this.numberOfValues,
    this._ansIsPos,
    this._valueIsPos,
  );
}

class MultiplicationLevelUtils {
  // int _range1, _range2;
  List<List<int>> numbers = [];
  MultiplicationLevelUtils(this.numbers);
}

class DivisionLevelUtils {
  // int _range1, _range2;
  List<List<int>> numbers = [];
  DivisionLevelUtils(this.numbers);
}

class LevelsLogic {
  // bool _valueIsPos;
  List additionLevelInfo, multiplicationLevelInfo, divisionLevelInfo;
  List<List<List<int>>> speedRunInfo;
  LevelsLogic(_valueIsPos) {
    additionLevelInfo = [
      AdditionLevelUtils(1, 1, 5, true, _valueIsPos),
      AdditionLevelUtils(1, 2, 5, true, _valueIsPos),
      AdditionLevelUtils(1, 3, 3, true, _valueIsPos),
      AdditionLevelUtils(1, 3, 4, false, _valueIsPos),
      AdditionLevelUtils(1, 4, 4, false, _valueIsPos),
      AdditionLevelUtils(1, 5, 4, false, _valueIsPos),
    ];
    multiplicationLevelInfo = [
      MultiplicationLevelUtils([
        [1, 1]
      ]),
      MultiplicationLevelUtils([
        [2, 1]
      ]),
      MultiplicationLevelUtils([
        [3, 1],
        [2, 2],
      ]),
      MultiplicationLevelUtils([
        [3, 2],
      ]),
      MultiplicationLevelUtils([
        [3, 3],
        [4, 2],
      ]),
    ];
    divisionLevelInfo = [
      DivisionLevelUtils([
        [1, 1]
      ]),
      DivisionLevelUtils([
        [2, 1]
      ]),
      DivisionLevelUtils([
        [4, 2],
      ]),
      DivisionLevelUtils([
        [5, 3],
      ]),
    ];
    speedRunInfo = [
      [
        [1, 2],
        [
          2,
        ]
      ],
      [
        [3, 4],
        [3, 4],
        [3, 4]
      ],
      [
        [5, 6],
        [5, 6],
        [5, 6]
      ]
    ];
  }
  var maxMap = {
    '1': 9,
    '2': 99,
    '3': 999,
    '4': 9999,
    '5': 99999,
    '6': 999999,
    '7': 9999999,
  };

  var minMap = {
    '0': 0,
    '1': 1,
    '2': 10,
    '3': 100,
    '4': 1000,
    '5': 10000,
    '6': 100000,
    '7': 1000000
  };
  var rng = new Random();
  List addStringCustom(var params) {
    int _numberOfValues = params['numberOfValues'],
        _range1 = params['range1'],
        _range2 = params['range2'];
    List<String> questionTtsList = [];

    bool _valueIsPos = params['valIsPos'], _ansIsPos = params['ansIsPos'];
    int _lowerNum = minMap[_range1.toString()];
    int _upperNum = maxMap[_range2.toString()];

    int res = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
    String question = res.toString();
    // questionTts += res.toString();
    questionTtsList.add(res.toString());
    for (int i = 0; i < _numberOfValues - 1; i++) {
      int _num = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
      int sign = rng.nextInt(2);
      // 0 for sub and 1 for add
      if (_valueIsPos == false && sign == 0) {
        //when subtraction is allowed
        if ((_ansIsPos == true && res - _num >= 0) || _ansIsPos == false) {
          //when result is positive or negative result is allowed
          res = res - _num;
          question = question +
              '\n' +
              Variables().minusCharacter +
              ' ' +
              _num.toString();
          // questionTts += " minus " + _num.toString();
          questionTtsList.addAll([
            "minus",
            _num.toString(),
          ]);
        } else {
          //when result is getting negative but it shouldn't
          res = res + _num;
          question = question + '\n ' + _num.toString();
          // questionTts += " plus " + _num.toString();
          questionTtsList.addAll([
            // "plus",
            _num.toString(),
          ]);
        }
      } else {
        res = res + _num;
        question = question + '\n ' + _num.toString();
        // questionTts += " plus " + _num.toString();
        questionTtsList.addAll([
          // "plus",
          _num.toString(),
        ]);
      }
    }

    return [res.toString(), question, questionTtsList];
  }

  List addStringLevel(int lev) {
    AdditionLevelUtils level = additionLevelInfo[lev - 1];
    int _numberOfValues = level.numberOfValues,
        _range1 = level._range1,
        _range2 = level._range2;
    List<String> questionTtsList = [];
    bool _valueIsPos = level._valueIsPos, _ansIsPos = level._ansIsPos;
    int _lowerNum = minMap[_range1.toString()];
    int _upperNum = maxMap[_range2.toString()];

    int res = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
    String question = res.toString();
    // questionTts += res.toString();
    questionTtsList.add(res.toString());
    for (int i = 0; i < _numberOfValues - 1; i++) {
      int _num = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
      int sign = rng.nextInt(2);
      // 0 for sub and 1 for add
      if (_valueIsPos == false && sign == 0) {
        //when subtraction is allowed
        if ((_ansIsPos == true && res - _num >= 0) || _ansIsPos == false) {
          //when result is positive or negative result is allowed
          res = res - _num;
          question = question +
              '\n' +
              Variables().minusCharacter +
              ' ' +
              _num.toString();
          // questionTts += " minus " + _num.toString();
          questionTtsList.addAll([
            "minus",
            _num.toString(),
          ]);
        } else {
          //when result is getting negative but it shouldn't
          res = res + _num;
          question = question + '\n ' + _num.toString();
          // questionTts += " plus " + _num.toString();
          questionTtsList.addAll([
            // "plus",
            _num.toString(),
          ]);
        }
      } else {
        res = res + _num;
        question = question + '\n ' + _num.toString();
        // questionTts += " plus " + _num.toString();
        questionTtsList.addAll([
          // "plus",
          _num.toString(),
        ]);
      }
    }

    return [res.toString(), question, questionTtsList];
  }

  List multiplyStringLevel(int lev) {
    List<List<int>> multiplycomb = multiplicationLevelInfo[lev - 2].numbers;
    int num = rng.nextInt(multiplycomb.length);
    int _range1 = multiplycomb[num][0], _range2 = multiplycomb[num][1];
    int _lowerNumMin = minMap[_range1.toString()];
    int _upperNumMin = minMap[_range2.toString()];
    int _lowerNumMax = maxMap[_range1.toString()];
    int _upperNumMax = maxMap[_range2.toString()];
    List<String> questionTtsList = [];
    //generic algo to generate random number between min and max.
    int num1 = rng.nextInt(_lowerNumMax - _lowerNumMin + 1) + _lowerNumMin;
    int num2 = rng.nextInt(_upperNumMax - _upperNumMin + 1) + _upperNumMin;
    int res = num1 * num2;
    // questionTts = num1.toString() + ' multiplied by ' + num2.toString();
    questionTtsList.addAll([num1.toString(), 'multiplied by', num2.toString()]);

    return [
      res.toString(),
      num1.toString() + Variables().multiplyCharacter + num2.toString(),
      questionTtsList
    ];
  }

  List multiplyStringCustom(var params) {
    int _range1 = params['range1'], _range2 = params['range2'];
    List<String> questionTtsList = [];
    int _lowerNumMin = minMap[_range1.toString()];
    int _upperNumMin = minMap[_range2.toString()];
    int _lowerNumMax = maxMap[_range1.toString()];
    int _upperNumMax = maxMap[_range2.toString()];
    //generic algo to generate random number between min and max.
    int num1 = rng.nextInt(_lowerNumMax - _lowerNumMin + 1) + _lowerNumMin;
    int num2 = rng.nextInt(_upperNumMax - _upperNumMin + 1) + _upperNumMin;
    int res = num1 * num2;
    // questionTts = num1.toString() + ' multiplied by ' + num2.toString();
    questionTtsList.addAll([num1.toString(), 'multiplied by', num2.toString()]);

    return [
      res.toString(),
      num1.toString() + Variables().multiplyCharacter + num2.toString(),
      questionTtsList
    ];
  }

  List divideStringCustom(var params) {
    List<String> questionTtsList = [];

    int _range1 = params['range1'], _range2 = params['range2'];

    int _lowerNumMin = minMap[_range1.toString()];
    int _lowerNumMax = maxMap[_range1.toString()];
    int num1 = rng.nextInt(_lowerNumMax - _lowerNumMin + 1) + _lowerNumMin;
    int _upperNumMin = minMap[_range2.toString()];
    int _upperNumMax = min(num1, maxMap[_range2.toString()]);
    int num2 =
        max(rng.nextInt(_upperNumMax - _upperNumMin + 1) + _upperNumMin, 2);
    double res = double.parse((num1 / num2).toStringAsFixed(2));
    //this string is for speaking
    // questionTts = num1.toString() + ' divided by ' + num2.toString();
    questionTtsList.addAll([num1.toString(), 'divided by', num2.toString()]);
    if (res.ceil() == res.floor()) {
      return [
        res.toInt().toString(),
        num1.toString() + Variables().divideCharacter + num2.toString(),
        questionTtsList
      ];
    }
    return [
      res.toString(),
      num1.toString() + Variables().divideCharacter + num2.toString(),
      questionTtsList
    ];
  }

  List divideStringLevel(int lev) {
    List<String> questionTtsList = [];
    List<List<int>> dividecomb = divisionLevelInfo[lev - 3].numbers;
    int num = rng.nextInt(dividecomb.length);
    int _range1 = dividecomb[num][0], _range2 = dividecomb[num][1];

    int _lowerNumMin = minMap[_range1.toString()];
    int _lowerNumMax = maxMap[_range1.toString()];
    int num1 = rng.nextInt(_lowerNumMax - _lowerNumMin + 1) + _lowerNumMin;
    int _upperNumMin = minMap[_range2.toString()];
    int _upperNumMax = min(num1, maxMap[_range2.toString()]);
    int num2 =
        max(rng.nextInt(_upperNumMax - _upperNumMin + 1) + _upperNumMin, 2);
    double res = double.parse((num1 / num2).toStringAsFixed(2));

    //this string is for speaking
    // questionTts = num1.toString() + ' divided by ' + num2.toString();
    questionTtsList.addAll([num1.toString(), 'divided by', num2.toString()]);
    if (res.ceil() == res.floor()) {
      return [
        res.toInt().toString(),
        num1.toString() + Variables().divideCharacter + num2.toString(),
        questionTtsList
      ];
    }
    return [
      res.toString(),
      num1.toString() + Variables().divideCharacter + num2.toString(),
      questionTtsList
    ];
  }

  List speedRunLevel(int lev) {
    List<List<int>> levInfo = speedRunInfo[lev - 1];
    int rndOper = rng.nextInt(levInfo.length);
    int rndlev = rng.nextInt(levInfo[rndOper].length);
    if (rndOper == 0) {
      return addStringLevel(levInfo[rndOper][rndlev]);
    } else if (rndOper == 1) {
      return multiplyStringLevel(levInfo[rndOper][rndlev]);
    } else {
      return divideStringLevel(levInfo[rndOper][rndlev]);
    }
  }
}
