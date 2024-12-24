sealed class UpdateProfileEvent {}

class UpdateProfileDataEvent extends UpdateProfileEvent {
  final String id;
  final String fname;
  final String lname;
  final String pnum;
  final String rela;
  final String address;
  final String gender;
  final String dob;
  final List<String> econtact;
  final String blood;
  final double weight;
  final double height;
  final List<String> medlist;
  final List<String> allergy;

  UpdateProfileDataEvent({
    required this.id,
    required this.fname,
    required this.lname,
    required this.pnum,
    required this.rela,
    required this.address,
    required this.gender,
    required this.dob,
    required this.econtact,
    required this.blood,
    required this.weight,
    required this.height,
    required this.medlist,
    required this.allergy,
  });
}

class UpdateProfileImageEvent extends UpdateProfileEvent {
  final String id;
  final String imageUrl;

  UpdateProfileImageEvent({
    required this.id,
    required this.imageUrl,
  });
}
