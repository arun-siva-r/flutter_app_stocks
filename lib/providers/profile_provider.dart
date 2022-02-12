import 'package:flutter/cupertino.dart';

import '../Util/storage_manager.dart';
import '../models/profile_details.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileDetails _profileDetails = ProfileDetails();

  set profileDetails(ProfileDetails value) {
    _profileDetails = value;
    notifyListeners();
  }

  ProfileDetails get profileDetails => _profileDetails;

  ProfileProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    profileDetails =
        await ProfileStorage.readProfileDetails() ?? profileDetails;
  }
}
