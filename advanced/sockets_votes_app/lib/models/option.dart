class Option {
  String id;
  String name;
  int votes;

  Option({
    required this.id,
    required this.name,
    required this.votes
  });

  factory Option.fromMap(Map<String, dynamic> obj) {
    return Option(
      id: obj['id'], 
      name: obj['name'], 
      votes: obj['votes']
    );
  }
}
