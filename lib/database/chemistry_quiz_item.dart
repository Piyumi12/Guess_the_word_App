import 'chemistry_quiz_model.dart';

class ChemistryQuizItem extends Model{
  static String table = "quizzes";


  int id;
  String name;
  int duration;
  int questionNo;

  ChemistryQuizItem({ this.id, this.name, this.duration, this.questionNo});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'duration': duration,
      'questionNo': questionNo
    };

    if (id != null) {
      map['id'] = id;}
    return map;
  }

  static ChemistryQuizItem fromMap(Map<String, dynamic> map){
    return ChemistryQuizItem(
        id: map['id'],
        name: map['name'],
        duration: map['duration'],
        questionNo: map['questionNo']
    );
  }

}