class UserModel {
  String uid;
  String email;
  String nome;
  String cognome;

  UserModel({this.uid, this.email, this.nome, this.cognome});

  // Dati dal server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nome: map['nome'],
      cognome: map['cognome']
    );
  }

  // Invio dati al server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nome': nome,
      'cognome': cognome
    };
  }

}