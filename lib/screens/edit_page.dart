import 'package:flutter/material.dart';
import 'package:flutter_app_validus/Util/storage_manager.dart';
import 'package:flutter_app_validus/models/profile_details.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final String fieldName;

  final String? value;

  final ProfileDetails profileDetails;

  const EditPage(
      {required this.fieldName,
      this.value,
      required this.profileDetails,
      Key? key})
      : super(key: key);

  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _textEditingController;
  late ProfileDetails _updatedProfileDetails;

  @override
  void initState() {
    super.initState();
    _updatedProfileDetails = widget.profileDetails;
    _textEditingController = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.95,
      initialChildSize: 0.95,
      builder: (BuildContext context, ScrollController controller) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context, _updatedProfileDetails);
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Edit ' + widget.fieldName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          widget.fieldName == 'Email'
                              ? Text(
                                  'We\'ll send you an email to confirm you new email address',
                                  style: Theme.of(context).textTheme.subtitle1,
                                )
                              : Container(),
                          SizedBox(
                            height: widget.fieldName == 'Email' ? 20 : 0,
                          ),
                          Form(
                            key: _formKey,
                            child: _getFormField(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                    left: 25,
                    right: 25,
                    bottom: 20,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pop(context, _updatedProfileDetails);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).indicatorColor,
                            minimumSize: const Size(double.infinity, 50)),
                        child: Text(
                          'Save',
                          style: Theme.of(context).textTheme.headline2,
                        )))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getFormField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: Theme.of(context).hintColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _getLabelText(),
            style: Theme.of(context).textTheme.overline,
          ),
          TextFormField(
            controller: _textEditingController,
            autovalidateMode: AutovalidateMode.always,
            validator: _validateTextField,
            style: Theme.of(context).textTheme.headline3,
            onSaved: (String? value) {
              _updatedProfileDetails = _getUpdatedFormField(value);
              ProfileStorage.writeProfileDetails(_updatedProfileDetails);
            },
            keyboardType: _getTextInputType(),
            textAlignVertical: TextAlignVertical.center,
            readOnly: widget.fieldName == 'Date Of Birth',
            decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                suffixIcon: widget.fieldName == 'Date Of Birth'
                    ? IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final DateTime today = DateTime.now();
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime(
                                  today.year - 18, today.month, today.day),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));

                          if (date != null) {
                            _textEditingController.text =
                                DateFormat('yyyy-MM-dd').format(date);
                          }
                        },
                      )
                    : null),
          )
        ],
      ),
    );
  }

  String? _validateTextField(String? value) {
    if (widget.fieldName == 'Email') {
      return emailValidator(value);
    } else if (widget.fieldName == 'Name' || widget.fieldName == 'Address') {
      if (value == null || value.isEmpty) {
        return widget.fieldName + ' must not be empty';
      }
    } else if (widget.fieldName == 'Date Of Birth' &&
        value != null &&
        value.isNotEmpty) {
      final DateTime today = DateTime.now();
      final int difference =
          today.difference(DateTime.parse(value)).inDays.abs();
      if (difference < 18) {
        return 'Must be 18 years old to manage stocks';
      }
    }

    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email must not be empty';
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    RegExp emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");
    if (!regex.hasMatch(value) || !value.contains(emailRegex)) {
      return 'Please enter valid email id';
    }
    return null;
  }

  String _getLabelText() {
    if (widget.fieldName == 'Name') {
      return 'Name';
    } else if (widget.fieldName == 'Email') {
      return 'Email address';
    } else if (widget.fieldName == 'Address') {
      return 'Address';
    }

    return 'Date Of Birth';
  }

  TextInputType _getTextInputType() {
    if (widget.fieldName == 'Email') {
      return TextInputType.emailAddress;
    } else if (widget.fieldName == 'Date Of Birth') {
      return TextInputType.datetime;
    }

    return TextInputType.text;
  }

  ProfileDetails _getUpdatedFormField(String? value) {
    if (widget.fieldName == 'Name') {
      return widget.profileDetails.copyWith(name: value);
    } else if (widget.fieldName == 'Email') {
      return widget.profileDetails.copyWith(email: value);
    } else if (widget.fieldName == 'Address') {
      return widget.profileDetails.copyWith(address: value);
    }

    return widget.profileDetails.copyWith(dateOfBirth: value);
  }
}
