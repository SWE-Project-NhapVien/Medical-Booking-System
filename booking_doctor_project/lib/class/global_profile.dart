class GlobalProfile {
  static final GlobalProfile _instance = GlobalProfile._internal();

  String? profileId;

  factory GlobalProfile() {
    return _instance;
  }

  GlobalProfile._internal();

  void resetProfileId() {
    profileId = null;
  }
}
