import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Weather parameters',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Hubballi',
              color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 120),
          width: size.width,
          height: size.height,
          color: const Color(0xff081b25),
          child: ListView(
            padding: const EdgeInsets.all(8),
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              const ListTile(
                title: Text("Unit", style: TextStyle(color: Colors.white)),
                subtitle: Text("°C", style: TextStyle(color: Colors.blue)),
                leading: Icon(Icons.thermostat, color: Colors.white),
              ),
              const ListTile(
                title: Text("Use current position",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text("Refuser", style: TextStyle(color: Colors.blue)),
                leading: Icon(Icons.location_on, color: Colors.white),
              ),
              const ListTile(
                title: Text("Automatic update",
                    style: TextStyle(color: Colors.white)),
                subtitle:
                    Text("Every 6 hours", style: TextStyle(color: Colors.blue)),
                leading: Icon(Icons.refresh, color: Colors.white),
              ),
              const ListTile(
                title: Text("Notifications",
                    style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.notifications, color: Colors.white),
              ),
              const ListTile(
                title: Text("Weather alerts",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(
                    "Receive weather alerts and badges on the Weather widget, in the app and on the side screen.",
                    style: TextStyle(color: Colors.grey)),
                leading: Icon(Icons.campaign, color: Colors.white),
                trailing: Icon(Icons.toggle_on, color: Colors.white),
              ),
              const ListTile(
                title: Text("Adding the Weather icon",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text("Add the Weather icon to the Apps screen",
                    style: TextStyle(color: Colors.grey)),
                leading: Icon(Icons.sunny_snowing, color: Colors.white),
                trailing: Icon(Icons.toggle_off, color: Colors.white),
              ),
              const ListTile(
                title: Text("Customisation service",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(
                    "Get personalised content based on your phone's usage",
                    style: TextStyle(color: Colors.grey)),
                leading: Icon(Icons.edit, color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: ListTile(
                  title: Text("About the Weather application",
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.info, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
