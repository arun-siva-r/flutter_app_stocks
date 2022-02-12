import 'package:flutter/material.dart';
import 'package:flutter_app_validus/models/profile_details.dart';
import 'package:flutter_app_validus/providers/profile_provider.dart';
import 'package:flutter_app_validus/screens/edit_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late ProfileProvider _profileProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileProvider = Provider.of<ProfileProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getProfileElement(
                  'Name', _profileProvider.profileDetails.name ?? ''),
              const SizedBox(
                height: 40,
              ),
              _getProfileElement(
                  'Email', _profileProvider.profileDetails.email ?? ''),
              const SizedBox(
                height: 40,
              ),
              _getProfileElement(
                  'Address', _profileProvider.profileDetails.address ?? ''),
              const SizedBox(
                height: 40,
              ),
              _getProfileElement('Date Of Birth',
                  _profileProvider.profileDetails.dateOfBirth ?? '')
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProfileElement(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextButton(
              child: Text(
                'Edit',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(decoration: TextDecoration.underline),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              onPressed: () async {
                _profileProvider.profileDetails = await showGeneralDialog(
                    context: context,
                    transitionBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return SlideTransition(
                        position: Tween(
                                begin: const Offset(0, 1),
                                end: const Offset(0, 0))
                            .animate(animation),
                        child: child,
                      );
                    },
                    barrierDismissible: true,
                    barrierLabel: 'Label1',
                    barrierColor: Colors.black45,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return EditPage(
                        fieldName: label,
                        profileDetails: _profileProvider.profileDetails,
                        value: value,
                      );
                    }) as ProfileDetails;

                // _profileProvider.profileDetails = await Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         fullscreenDialog: true,
                //         builder: (BuildContext context) => EditPage(
                //               fieldName: label,
                //               value: value,
                //               profileDetails: _profileProvider.profileDetails,
                //             )));
              },
            )
          ],
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
