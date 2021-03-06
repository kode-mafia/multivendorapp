import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shapeyou/Screen/profile_update_screen.dart';
import 'package:shapeyou/Screen/welcome_screen.dart';
import 'package:shapeyou/provider/auth_provider.dart';
import 'package:shapeyou/provider/location_provider.dart';
import 'map_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'profile-screen';

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<AuthProvider>(context);
    var locationData = Provider.of<LocationProvider>(context);
    User user = FirebaseAuth.instance.currentUser;
    userDetails.getUserDetails();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Multi-Vendor Store',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'MY ACCOUNT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                'M',
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userDetails.snapshot.data()['firstName'] !=
                                            null
                                        ? '${userDetails.snapshot.data()['firstName']} ${userDetails.snapshot.data()['lastName']}'
                                        : 'Update Your Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                  if (userDetails.snapshot.data()['email'] !=
                                      null) //other wise hide
                                    Text(
                                      '${userDetails.snapshot.data()['email']}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  Text(
                                    user.phoneNumber,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (userDetails.snapshot != null)
                          ListTile(
                            tileColor: Colors.white,
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            title:
                                Text(userDetails.snapshot.data()['location']),
                            subtitle: Text(
                              userDetails.snapshot.data()['address'],
                              maxLines: 1,
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: OutlineButton(
                                borderSide: BorderSide(color: Colors.redAccent),
                                child: Text(
                                  'Change',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                onPressed: () {
                                  EasyLoading.show(status: 'Please wait...');
                                  locationData
                                      .getCurrentPosition()
                                      .then((value) {
                                    if (value != null) {
                                      EasyLoading.dismiss();
                                      pushNewScreenWithRouteSettings(
                                        context,
                                        settings:
                                            RouteSettings(name: MapScreen.id),
                                        screen: MapScreen(),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    } else {
                                      EasyLoading.dismiss();
                                      print('Permission not allowed');
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: UpdateProfile.id),
                        screen: UpdateProfile(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                )
              ],
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.history),
              title: Text('My Orders'),
              horizontalTitleGap: 2,
            ),
            Divider(),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.comment_outlined),
              title: Text('My Ratings & Reviews'),
              horizontalTitleGap: 2,
            ),
            Divider(),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.notifications_none),
              title: Text('Notifications'),
              horizontalTitleGap: 2,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              horizontalTitleGap: 2,
              onTap: () {
                FirebaseAuth.instance.signOut();
                pushNewScreenWithRouteSettings(
                  context,
                  settings: RouteSettings(name: WelcomeScreen.id),
                  screen: WelcomeScreen(),
                  withNavBar: false,
                  // since navigating to outside made it false 'cause nothing to be accessed without login
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//navigation is different for persistent_nav_bar
