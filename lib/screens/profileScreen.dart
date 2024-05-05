import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_testing/classes/userAPI.dart';
import 'package:flutter_testing/classes/userToken.dart';
import 'package:flutter_testing/components/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Esto viene de la api, se hace llamada si token.value.isEmpty

  //late Future<List<ApiMarker>> futureApiMarkers = ApiMarker.getMarkers();

  late bool firstTime = UserToken.isFirstTime();
  late bool editable = firstTime;

  late String avatarSprite = "archerICON.png";

  late TextEditingController nameController = TextEditingController();
  late TextEditingController hobbiesController = TextEditingController();

  int _currentIndex = 0;

  //Esto api?
  List<Widget> items = [
    Image.asset('assets/images/archerICON.png'),
    Image.asset('assets/images/enchantressICON.png'),
    Image.asset('assets/images/knightICON.png'),
    Image.asset('assets/images/wizardICON.png'),
  ];

  List avatarNameFiles = [
    "assets/images/archerICON.png",
    "assets/images/enchantressICON.png",
    "assets/images/knightICON.png",
    "assets/images/wizardICON.png",
  ];

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          textAlign: TextAlign.center,
          selectionColor: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text('Name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              switch (editable) {
                true => TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: user.name,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                false => Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
              },

              const SizedBox(height: 30), //const SizedBox(height: 20),
              const Text('Hobbies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              switch (editable) {
                true => TextField(
                    controller: hobbiesController,
                    decoration: InputDecoration(
                      hintText: user.hobbies,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                false => Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(user.hobbies,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                  ),
              },

              const SizedBox(height: 50),
              Column(
                children: [
                  const Center(
                    child: Text('Choose your avatar:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 40),
                  switch (editable) {
                    true => CarouselSlider(
                        items: items,
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.7,
                          onPageChanged: (index, reason) {
                            _currentIndex = index;
                            setState(() {});
                          },
                          aspectRatio: 1.0,
                          viewportFraction: 0.3,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          scrollDirection: Axis.horizontal,
                        )),
                    false => Image(
                        image: AssetImage(user.getUserAvatar()),
                        width: 200,
                        height: 200),
                  },
                ],
              ),
              const SizedBox(height: 70),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    // Make the button a rectangle
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    //name: nameController.text; hobbies: hobbiesController.text;
                    if (firstTime) {
                      /*
                      var result = await UserAPI.createUser(UserAPI(
                        name: user.name,
                        hobbies: user.hobbies,
                        avatar: _currentIndex,
                      ));
                      user.token = result.token;
                      user.id = result.id;
                      */

                      UserToken.setToken(user.token);

                      Navigator.pushNamed(context, '/plaza');
                    }
                    setState(() async {
                      if (editable) {
                        user.setUserName(nameController.text);
                        user.setUserHobbies(hobbiesController.text);
                        user.setUserAvatar(avatarNameFiles[_currentIndex]);
                        await UserAPI.updateUser(new UserAPI(
                            name: user.name,
                            hobbies: user.hobbies,
                            avatar: _currentIndex,
                            id: user.id,
                            token: user.token));
                      } else {
                        nameController.text = user.name;
                        hobbiesController.text = user.hobbies;
                      }
                      editable = !editable;
                    });
                  },
                  child: switch (editable) {
                    true => const Text("Save changes",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    false => const Text("Edit profile",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
