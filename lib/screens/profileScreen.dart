import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController hobbiesController = TextEditingController();

  List<Widget> items = [
    Image.asset('assets/images/profile_icon.png'),
    Image.asset('assets/images/profile_icon2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                //Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('Plaza'),
              onTap: () {
                Navigator.pushNamed(context, '/plaza');
              },
            ),
          ],
        ),
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
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 30), //const SizedBox(height: 20),
              const Text('Hobbies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              TextField(
                controller: hobbiesController,
                decoration: const InputDecoration(
                  hintText: 'Enter your hobbies',
                ),
              ),
/* Image(
                    image: AssetImage('assets/images/profile_icon.png'),
                    width: 200,
                    height: 200), */
              const SizedBox(height: 50),
              Column(
                children: [
                  const Text('Choose your avatar:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  CarouselSlider(
                      items: items,
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 1.0,
                        viewportFraction: 0.67,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        /* autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn, */
                        //enlargeCenterPage: true,
                        //enlargeFactor: 0.3,
                        //onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      )),
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
                  onPressed: () {
                    //name: nameController.text; hobbies: hobbiesController.text;
                    //Navigator.pushNamed(context, '/plaza');
                  },
                  child: const Text(
                    'Start!',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
