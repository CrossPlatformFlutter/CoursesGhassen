class User{
  int id;
  String  nom;
  String email;

  User({required this.id, required this.nom,required this.email});


 factory User.fromjson(Map<String,dynamic> json){
    return User(
       id: json['id'],
        nom: json['nom'],
         email: json['email']
      );
 }

  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "nom":nom,
      "email":email
    };
  }
  String toString(){
    return "id :$id nom:$nom email:$email";
  }
}