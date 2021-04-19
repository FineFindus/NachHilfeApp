import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/global/globals.dart';
import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:mdi/mdi.dart';

import 'offer_create_screen.dart';
import 'offer_create_screen.dart';
import 'screens.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //dark mode, get default value form hive
  bool switchDarkMode = Hive.box(settingsBox).get('darkMode',
      defaultValue: SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark);

  //default class year, get default from hve
  int classYear =
      Hive.box(settingsBox).get('defaultClassYear', defaultValue: 5);

  //default class year, get default from hve
  Subject subject = getSubjectFromString(Hive.box(settingsBox)
      .get('defaultSubject', defaultValue: Subject.math.toString()));

  //secure storage for mail address
  var secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_screen_title),
        centerTitle: true,
      ),
      body: ListView(children: [
        Card(
          child: Column(children: [
            FutureBuilder(
              future: secureStorage.read(key: "user_email"),
              builder: (context, snapshot) => ListTile(
                leading: Icon(Icons.account_circle),
                title: snapshot.hasData
                    ? Text(snapshot.data)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()]),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(S.of(context).settings_screen_button_label_logout),
              onTap: () => logOut(),
            ),
          ]),
        ),
        SwitchListTile.adaptive(
          secondary: Icon(Mdi.themeLightDark),
          title: Text(S.of(context).settings_screen_switch_label_darkmode),
          value: switchDarkMode,
          onChanged: (value) => setState(() {
            switchDarkMode = value;
            Hive.box(settingsBox).put("darkMode", value);
          }),
        ),
        ListTile(
          leading: Icon(Mdi.teach),
          title:
              Text(S.of(context).settings_screen_listtile_label_default_year),
          trailing: Text("${classYear ?? 5}"),
          onTap: () => showDialog(
              context: context,
              builder: (context) => ChooseYearDialog(
                    startPosition: classYear,
                    onValueChanged: (value) {
                      setState(() {
                        classYear = value;
                        Hive.box(settingsBox).put("defaultClassYear", value);
                      });
                    },
                  )),
        ),
        ListTile(
            leading: Icon(Icons.class_),
            title: Text(
                S.of(context).settings_screen_listtile_label_default_subject),
            trailing: Text(
                "${getTranlatedSubject(context, subject ?? Subject.math)}"),
            onTap: () => showDialog(
                context: context,
                builder: (context) => ChooseSubjectDialog(
                      startPosition: subject,
                      onSubjectChanged: (value) {
                        setState(() {
                          subject = value;
                          Hive.box(settingsBox)
                              .put("defaultSubject", value.toString());
                        });
                      },
                    ))),
      ]),
    );
  }

  ///LogOut function,
  ///Deletes the usermailAddress in the keyChain and pushes the login screen
  logOut() async {
    await secureStorage.deleteAll();
    //show login screen
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
        (r) => false);
  }
}
