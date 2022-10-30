import 'package:flutter/material.dart';


class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            children: [

            ],
          )
        ],
      ),
    );
  }
}


/*class ProfileNavigation extends StatefulWidget {
  const ProfileNavigation({Key? key}) : super(key: key);

  @override
  State<ProfileNavigation> createState() => _ProfileNavigationState();
}*/

/*class _ProfileNavigationState extends State<ProfileNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
    );
  }
  Widget buildHeader(BuildContext context)=>Material(

    child: InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 52,
              backgroundColor: Colors.amber,
            ),
            SizedBox(height: 10,),
            Text('Farhana'),
          ],
        ),
      ),
    ),
  );
  Widget buildMenuItems(BuildContext context)=>Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.home),
          title: Text('Home'),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: Text('Home'),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: Text('Home'),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: Text('Home'),
          onTap: (){},
        ),
      ],

    ),
  );
}*/
