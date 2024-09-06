class Answer {
  final String question1;
  final String question2;
  final String question3;
  final String question4;
  final String question5;
  final String question6;
  final String question7;
  final String question8;
  final String question9;
  final String question10;
  final String question11;
  final String question12;
  final String question13;
  final String question14;
  final String question15;
  final String question16;
  final String question17;
  final String question18;
  final String question19;
  final String question20;
  final String question21;
  final String question22;
  final String question23;
  final String question24;
  final String question25;
  final String question26;
  final String question27;
  final String question28;
  final String question29;
  final String question30;
  final String question31;
  final String question32;
  final String question33;
  final String question34;
  final String question35;
  final String question36;

  Answer({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
    required this.question7,
    required this.question8,
    required this.question9,
    required this.question10,
    required this.question11,
    required this.question12,
    required this.question13,
    required this.question14,
    required this.question15,
    required this.question16,
    required this.question17,
    required this.question18,
    required this.question19,
    required this.question20,
    required this.question21,
    required this.question22,
    required this.question23,
    required this.question24,
    required this.question25,
    required this.question26,
    required this.question27,
    required this.question28,
    required this.question29,
    required this.question30,
    required this.question31,
    required this.question32,
    required this.question33,
    required this.question34,
    required this.question35,
    required this.question36,
  });

  // Factory method to create an Answer object from a Firestore document
  factory Answer.fromFirestore(Map<String, dynamic> data) {
    return Answer(
      question1: data['question1'] ?? '',
      question2: data['question2'] ?? '',
      question3: data['question3'] ?? '',
      question4: data['question4'] ?? '',
      question5: data['question5'] ?? '',
      question6: data['question6'] ?? '',
      question7: data['question7'] ?? '',
      question8: data['question8'] ?? '',
      question9: data['question9'] ?? '',
      question10: data['question10'] ?? '',
      question11: data['question11'] ?? '',
      question12: data['question12'] ?? '',
      question13: data['question13'] ?? '',
      question14: data['question14'] ?? '',
      question15: data['question15'] ?? '',
      question16: data['question16'] ?? '',
      question17: data['question17'] ?? '',
      question18: data['question18'] ?? '',
      question19: data['question19'] ?? '',
      question20: data['question20'] ?? '',
      question21: data['question21'] ?? '',
      question22: data['question22'] ?? '',
      question23: data['question23'] ?? '',
      question24: data['question24'] ?? '',
      question25: data['question25'] ?? '',
      question26: data['question26'] ?? '',
      question27: data['question27'] ?? '',
      question28: data['question28'] ?? '',
      question29: data['question29'] ?? '',
      question30: data['question30'] ?? '',
      question31: data['question31'] ?? '',
      question32: data['question32'] ?? '',
      question33: data['question33'] ?? '',
      question34: data['question34'] ?? '',
      question35: data['question35'] ?? '',
      question36: data['question36'] ?? '',
    );
  }

  // Convert Answer object to Map<String, dynamic> to save to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'question1': question1,
      'question2': question2,
      'question3': question3,
      'question4': question4,
      'question5': question5,
      'question6': question6,
      'question7': question7,
      'question8': question8,
      'question9': question9,
      'question10': question10,
      'question11': question11,
      'question12': question12,
      'question13': question13,
      'question14': question14,
      'question15': question15,
      'question16': question16,
      'question17': question17,
      'question18': question18,
      'question19': question19,
      'question20': question20,
      'question21': question21,
      'question22': question22,
      'question23': question23,
      'question24': question24,
      'question25': question25,
      'question26': question26,
      'question27': question27,
      'question28': question28,
      'question29': question29,
      'question30': question30,
      'question31': question31,
      'question32': question32,
      'question33': question33,
      'question34': question34,
      'question35': question35,
      'question36': question36,
    };
  }
}
