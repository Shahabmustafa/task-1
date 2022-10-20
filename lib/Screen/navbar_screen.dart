import 'package:flutter/material.dart';
import 'package:project/Screen/add_data.dart';
import 'package:project/Screen/favourite_screen.dart';
import 'package:project/Screen/home.dart';
import 'package:project/Screen/show_data.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Shahab Mustafa'),
              accountEmail: Text('shahabmustafa57@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('images/123.jpeg',
                width: 90,
                  height: 90.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYTazynhHzBRVOjbKSftHTWSW_ZEaotqSrZg&usqp=CAU',
                ),
                fit: BoxFit.cover
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Add Data'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddDataScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Show Data'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowdataScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourite'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
            },
          ),
        ],
      ),
    );
  }
}
