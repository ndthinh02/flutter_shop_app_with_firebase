class UserModel {
  String? name;
  String? email;
  String? id;
  String? urlImage;
  String? address;
  String? bio;
  String? phoneNumber;
  UserModel(
      {required this.name,
      required this.email,
      required this.id,
      required this.urlImage,
      this.address,
      this.bio,
      this.phoneNumber});
}
