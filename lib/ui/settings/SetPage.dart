import 'package:flutter/material.dart';
import 'package:gitclub/app/GlobalTranslations.dart';
import 'package:gitclub/constance/UserData.dart';
import 'package:gitclub/constance/colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gitclub/model/ThemeStateModel.dart';

class SetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SetPageState();
}

class SetPageState extends State<SetPage> {
  bool check = false;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  void initState() {
    super.initState();
    getPreferredLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text(Translations.of(context).text('set_title')),
        title: Text(allTranslations.text('set_title')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              allTranslations.text('general_setting'),
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 2.0,
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Colors.amber,
                    ),
                    title: Text(allTranslations.text('english')),
                    trailing: Switch(
                      value: check,
                      activeColor: Colors.pink,
                      onChanged: (val) {
                        setLanguage(val);
                        setState(() {
                          this.check = val;
                        });
                      },
                    )),
                ListTile(
                  leading: Icon(
                    Icons.color_lens,
                    color: Colors.deepOrange,
                  ),
                  title: Text(allTranslations.text('theme')),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    showThemeDialog();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.green,
                  ),
                  title: Text(allTranslations.text('email')),
                  trailing: Icon(Icons.arrow_right),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        child: RaisedButton(
          child: Text(
            allTranslations.text('sign_out'),
            style: TextStyle(color: AppColors.textWhite),
          ),
          color: AppColors.colorPrimary,
          onPressed: () {
            UserData.clearLoginInfo();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/person', (Route<dynamic> route) => false);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
            Navigator.pushReplacementNamed(context, "/login");
          },
        ),
      ),
    );
  }

  void setLanguage(var val) async {
    await allTranslations.setNewLanguage(val == true ? 'en' : 'zn', true);
  }

  void getPreferredLanguage() async {
    String language = await allTranslations.getPreferredLanguage();
    setState(() {
      check = language == "en" ? true : false;
    });
  }

  // bind some values with [ValueChanged<Color>] callback
  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void showThemeDialog() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          // Use Material color picker
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   enableLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
//              changeTheme(pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  changeTheme(Color color) async {
    ThemeStateModel().of(context).changeTheme(color);
  }
}
