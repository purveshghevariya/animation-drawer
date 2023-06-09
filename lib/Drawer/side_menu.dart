import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SideMenuScreenState createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  List<SideMenuCard> sideMenuCardList = [
    SideMenuCard("Home", CupertinoIcons.home),
    SideMenuCard("Search", CupertinoIcons.search),
    SideMenuCard("Favorites", CupertinoIcons.heart),
    SideMenuCard("Help", CupertinoIcons.doc),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
            child: Column(
          children: [
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Purvesh ghevariya",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Flutter developer",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
            const Divider(
              color: Colors.white24,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: sideMenuCardList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedIndex = index;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            height: 56,
                            width: selectedIndex == index
                                ? MediaQuery.of(context).size.width / 1.6
                                : 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF6792FF),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              sideMenuCardList[index].iconData,
                              color: Colors.white,
                            ),
                            title: Text(
                              sideMenuCardList[index].title,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        )),
      ),
    );
  }
}

class SideMenuCard {
  final String title;
  final IconData iconData;
  SideMenuCard(this.title, this.iconData);
}
