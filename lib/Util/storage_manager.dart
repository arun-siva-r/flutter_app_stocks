import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_validus/models/profile_details.dart';
import 'package:path_provider/path_provider.dart';

class ProfileStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/profile_details.txt');
  }

  static Future<ProfileDetails?> readProfileDetails() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return ProfileDetails.fromJson(jsonDecode(contents));
    } catch (e) {
      return null;
    }
  }

  static Future<File> writeProfileDetails(ProfileDetails details) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(details));
  }
}
