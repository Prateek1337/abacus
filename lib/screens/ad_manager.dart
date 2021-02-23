import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3863033260345796~5986487911";
      // } else if (Platform.isIOS) {
      //   return "ca-app-pub-3940256099942544~2594085930";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get ScoreScreenbannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3863033260345796/9786132121";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4339318960";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get SolveScreenbannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3863033260345796/5519584051";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4339318960";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
