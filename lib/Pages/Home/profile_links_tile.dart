import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileLinksTile extends StatelessWidget {

  final String platform;
  final String url;

  ProfileLinksTile({this.platform, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(_getIcon()),
            SizedBox(width: 10,),
            Text(platform, style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }

  _getIcon() {
    switch(platform){
      case 'Facebook': {
        return MdiIcons.facebook;
      }
      case 'LinkedIn': {
        return MdiIcons.linkedin;
      }
      case 'Twitter': {
        return MdiIcons.twitter;
      }
      case 'Instagram': {
        return MdiIcons.instagram;
      }
      case 'Website': {
        return MdiIcons.web;
      }
    }
  }

  _launchURL( String launchUrl) async {
    //const url = launchUrl;
    if (await canLaunch(launchUrl)) {
      await launch(launchUrl);
    } else {
      throw 'Could not launch $launchUrl';
    }
  }
}
