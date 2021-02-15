import 'package:flutter/material.dart';
import 'package:abacus/screens/HomeScreen.dart';
import 'package:abacus/screens/GlobalSettings.dart';
import 'package:abacus/screens/AboutUsScreen.dart';
import 'package:share/share.dart';

class AppDrawer extends StatelessWidget {
  final String user;
  AppDrawer({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Dashboard',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(user: user)),
                  )),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GlobalSettings(user: user)),
                  )),
          _createDrawerItem(
            icon: Icons.share,
            text: 'Share',
            onTap: () => {
              Share.share(
                  'Check out this wonderful app https://play.google.com/store/apps/details?id=com.abacus.abacus')
            },
          ),
          // Navigator.pushReplacementNamed(context, Routes.notes)),
          Divider(),
          _createDrawerItem(
              icon: Icons.collections_bookmark,
              text: 'About Us',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutUsScreen(user: user)),
                  )),
          // _createDrawerItem(icon: Icons.face, text: 'Authors'),
          // _createDrawerItem(
          //     icon: Icons.account_box, text: 'Flutter Documentation'),
          // _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
          Divider(),
          _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
          // ListTile(
          //   title: Text('0.0.1'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/drawer_header_background.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Menu",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
