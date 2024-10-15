class Hour{
  String id;
  String data;
  int minutes;
  String? description;

 Hour({required this.id, required this.data, required this.minutes});

  Hour.fromMap(Map<String, dynamic> map) :
    id = map['id'],
    data = map['data'],
    minutes = map['minutes'],
    description = map['description'];
  

 Map<String, dynamic> toMap(){
  return{
    'id' : id,
    'data': data,
    'minutes': minutes,
    'description': description,
  };
 }
}