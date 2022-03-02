import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/ui/auth/login_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/contact_us/contact_us_page.dart';
import 'package:fastfill/ui/profile/profile_page.dart';
import 'package:fastfill/ui/settings/settings_page.dart';
import 'package:fastfill/ui/terms/terms_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../utils/misc.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: backgroundColor1,
        title:
   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //InkWell(
            //onTap: () {
            //},

            PopupMenuButton(
              onSelected: (s) async {
                hideKeyboard(context);
                if (s == LoginPage.route)
                  {
                    showLogoutAlertDialog(context);
                  }
                else if (s == TermsPage.route)
                  {
                    Navigator.pushNamed(context, TermsPage.route);
                  } else if (s == ContactUsPage.route)
                    {
                      Navigator.pushNamed(context, ContactUsPage.route);
                    }else if (s == SettingsPage.route)
                {
                  Navigator.pushNamed(context, SettingsPage.route);
                }
              },
              color: backgroundColor1,
                itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: TermsPage.route,
                      child: Text(translate("labels.terms"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: ContactUsPage.route,
                      child: Text(translate("labels.contactUs"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: SettingsPage.route,
                      child: Text(translate("labels.settings"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: LoginPage.route,
                      child: Text(translate("labels.logout"), style: TextStyle(color: Colors.white),),
                    )
                  ],
            child: Container(
                alignment: Alignment.topLeft,
                height: SizeConfig().h(45),
                width: SizeConfig().h(45),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig().w(12),
                    vertical: SizeConfig().h(55)),
                child: SvgPicture.asset(
                  'assets/svg/menu.svg',
                  width: SizeConfig().w(50),
                ))),
          //),
          Padding(child: InkWell(
            onTap: () {
              hideKeyboard(context);
              Navigator.pushNamed(context, ProfilePage.route);
            },
            child: Container(
                alignment: Alignment.topRight,
                height: SizeConfig().h(45),
                width: SizeConfig().h(45),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig().w(12),
                    vertical: SizeConfig().h(55)),
                child: SvgPicture.asset(
                  'assets/svg/profile.svg',
                  width: SizeConfig().w(50),
                )),
          ), padding: EdgeInsetsDirectional.fromSTEB(0, 37, 0, 30),)
      ],),

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);



}
