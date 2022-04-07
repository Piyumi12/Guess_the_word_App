class Question{
  final String id;
  final String title;
  final Map<String,bool> options;

  Question({
    this.id,
    this.title,
    this.options});

  @override
  String toString(){
    return 'Question(id:$id,title:$title,options:$options)';
  }
}