class RegisterModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String username;
  String companyName;
  RegisterModel({required this.firstName, required this.lastName, required this.email, required this.phoneNumber,required this.password, required this.username,required this.companyName});

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "password": password,
    "username": email,
    "company_name":companyName
  };
}