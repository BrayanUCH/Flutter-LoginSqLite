class Users {
  static final List<String> values = [id, gmail, userName, password];

  static final String id = '_id';
  static final String gmail = 'gmail';
  static final String userName = 'userName';
  static final String password = 'password';
} 

class User {
  final int id;
  final String gmail;
  final String userName;
  final String password;

  const User({
    this.id,
    this.gmail,
    this.userName,
    this.password,
  });

  User copy({
    int id,
    String gmail,
    String userName,
    String password,
  }) =>
      User(
        id: id ?? this.id,
        gmail: gmail ?? this.gmail,
        userName: userName ?? this.userName,
        password: password ?? this.password,
      );

  static User fromJson(Map<String, Object> json) => User(
      id: json[Users.id] as int,
      gmail: json[Users.gmail] as String,
      userName: json[Users.userName] as String,
      password: json[Users.password] as String);

  Map<String, Object> toJson() => {
        Users.id: id,
        Users.gmail: gmail,
        Users.userName: userName,
        Users.password: password,
      };
}
