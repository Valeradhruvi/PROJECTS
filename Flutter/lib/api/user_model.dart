class UserData{
  String id;
  String name;
  String address;
  String email;
  String number;
  String age;
  String hEducation;
  String occupaation;
  String country;
  String state;
  String city;
  String gender;
  String dob;
  String hobby;
  String password;
  String confirmPassword;
  bool isFav = false;

  UserData({required this.id , required this.name , required this.address , required this.email , required this.number , required this.age , required this.hEducation , required this.occupaation , required this.country , required this.state , required this.city , required this.gender ,  required this.dob ,required this.hobby , required this.password , required this.confirmPassword , this.isFav = false});

  static UserData toUser(Map<String, dynamic> m) {
    return UserData(
      id: m["id"] ?? "",
      name: m["name"] ?? "Unknown",
      address: m["address"] ?? "N/A",
      email: m["email"] ?? "N/A",
      number: m["number"] ?? "N/A",
      age: m["age"]?.toString() ?? "0",  // Ensure age is a string
      hEducation: m["hEducation"] ?? "N/A",
      occupaation: m["occupaation"] ?? "N/A",
      country: m["country"] ?? "N/A",
      state: m["state"] ?? "N/A",
      city: m["city"] ?? "N/A",
      gender: m["gender"] ?? "N/A",
      dob: m["dob"] ?? "N/A",
      hobby: m["hobby"] ?? "N/A",
      password: m["password"] ?? "N/A",
      confirmPassword: m["confirmPassword"] ?? "N/A",
      isFav: m['isFav'] ?? false,
    );
  }


  Map<String , dynamic> toMap(){
    return {"id" : this.id , "name" : this.name , "address" : this.address , "email" : this.email , "number" : this.number , "age" : this.age , "hEducation" : this.hEducation , "occupation" : this.occupaation , "country" : this.country , "state" : this.state , "city" : this.city , "gender" : this.gender , "dob" : this.dob , "hobby" : this.hobby , "password" : this.password , "confrimPassword" : this.confirmPassword , "isFav": this.isFav};
  }
}