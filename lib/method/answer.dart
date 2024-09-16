/* class Answer {
  final String GE01;
  final String GE02;
  final String GE03;
  final String GE04;
  final String GE05;
  final String GE06;
  final String GE07;
  final String GE08;
  final String GE09;
  final String GE10;
  final String GE11;
  final String GE12;
  final String GE13;
  final String GE14;
  final String GE15;
  final String GE16;
  final String GE17;
  final String GE18;
  final String GE19;
  final String GE20;
  final String GE21;
  final String GE22;
  final String GE23;
  final String GE24;
  final String GE25;
  final String GE26;
  final String GE27;
  final String GE28;
  final String GE29;
  final String GE30;
  final String GE31;
  final String GE32;
  final String GE33;
  final String GE34;
  final String GE35;
  final String GE36;

  Answer({
    required this.GE01,
    required this.GE02,
    required this.GE03,
    required this.GE04,
    required this.GE05,
    required this.GE06,
    required this.GE07,
    required this.GE08,
    required this.GE09,
    required this.GE10,
    required this.GE11,
    required this.GE12,
    required this.GE13,
    required this.GE14,
    required this.GE15,
    required this.GE16,
    required this.GE17,
    required this.GE18,
    required this.GE19,
    required this.GE20,
    required this.GE21,
    required this.GE22,
    required this.GE23,
    required this.GE24,
    required this.GE25,
    required this.GE26,
    required this.GE27,
    required this.GE28,
    required this.GE29,
    required this.GE30,
    required this.GE31,
    required this.GE32,
    required this.GE33,
    required this.GE34,
    required this.GE35,
    required this.GE36,
  });

  // Factory method to create an Answer object from a Firestore document
  factory Answer.fromFirestore(Map<String, dynamic> data) {
    return Answer(
      GE01: data['GE01'] ?? '',
      GE02: data['GE02'] ?? '',
      GE03: data['GE03'] ?? '',
      GE04: data['GE04'] ?? '',
      GE05: data['GE05'] ?? '',
      GE06: data['GE06'] ?? '',
      GE07: data['GE07'] ?? '',
      GE08: data['GE08'] ?? '',
      GE09: data['GE09'] ?? '',
      GE10: data['GE10'] ?? '',
      GE11: data['GE11'] ?? '',
      GE12: data['GE12'] ?? '',
      GE13: data['GE13'] ?? '',
      GE14: data['GE14'] ?? '',
      GE15: data['GE15'] ?? '',
      GE16: data['GE16'] ?? '',
      GE17: data['GE17'] ?? '',
      GE18: data['GE18'] ?? '',
      GE19: data['GE19'] ?? '',
      GE20: data['GE20'] ?? '',
      GE21: data['GE21'] ?? '',
      GE22: data['GE22'] ?? '',
      GE23: data['GE23'] ?? '',
      GE24: data['GE24'] ?? '',
      GE25: data['GE25'] ?? '',
      GE26: data['GE26'] ?? '',
      GE27: data['GE27'] ?? '',
      GE28: data['GE28'] ?? '',
      GE29: data['GE29'] ?? '',
      GE30: data['GE30'] ?? '',
      GE31: data['GE31'] ?? '',
      GE32: data['GE32'] ?? '',
      GE33: data['GE33'] ?? '',
      GE34: data['GE34'] ?? '',
      GE35: data['GE35'] ?? '',
      GE36: data['GE36'] ?? '',
    );
  }

  // Convert Answer object to Map<String, dynamic> to save to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'GE01': GE01,
      'GE02': GE02,
      'GE03': GE03,
      'GE04': GE04,
      'GE05': GE05,
      'GE06': GE06,
      'GE07': GE07,
      'GE08': GE08,
      'GE09': GE09,
      'GE10': GE10,
      'GE11': GE11,
      'GE12': GE12,
      'GE13': GE13,
      'GE14': GE14,
      'GE15': GE15,
      'GE16': GE16,
      'GE17': GE17,
      'GE18': GE18,
      'GE19': GE19,
      'GE20': GE20,
      'GE21': GE21,
      'GE22': GE22,
      'GE23': GE23,
      'GE24': GE24,
      'GE25': GE25,
      'GE26': GE26,
      'GE27': GE27,
      'GE28': GE28,
      'GE29': GE29,
      'GE30': GE30,
      'GE31': GE31,
      'GE32': GE32,
      'GE33': GE33,
      'GE34': GE34,
      'GE35': GE35,
      'GE36': GE36,
    };
  }
}
 */
// File: answer_model.dart

// File: answer_model.dart

class Answer {
  Map<String, String> answers;

  Answer({required this.answers});

  // Method untuk memperbarui jawaban dari setiap pertanyaan
  void updateAnswer(String questionId, String answer) {
    answers[questionId] = answer;
  }

  // Method untuk mengonversi semua jawaban ke format numerik
  Map<String, int> toNumeric() {
    Map<String, int> numericAnswers = {};

    answers.forEach((key, value) {
      numericAnswers[key] = convertAnswerToNumeric(value);
    });

    return numericAnswers;
  }

  // Method helper untuk konversi jawaban ke angka
  int convertAnswerToNumeric(String answer) {
    switch (answer) {
      case 'Sangat sering':
        return 4;
      case 'Sering':
        return 3;
      case 'Kadang-kadang':
        return 2;
      case 'Jarang':
        return 1;
      case 'Tidak pernah':
        return 0;
      default:
        return 0;
    }
  }
}
