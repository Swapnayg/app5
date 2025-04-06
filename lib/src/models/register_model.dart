class RegisterModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String username;
  String companyName;
  RegisterModel({this.firstName, this.lastName, this.email, this.phoneNumber, this.password, this.username,this.companyName});

  Map<String, dynamic> toJson() => {
    "first_name": firstName ?? '',
    "last_name": lastName ?? '',
    "email": email ?? '',
    "phone_number": phoneNumber ?? '',
    "password": password ?? '',
    "username": email ?? '',
    "company_name":companyName ?? ''
  };
}