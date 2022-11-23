import 'package:flutter/material.dart';

class TripAppbar extends StatelessWidget {
  const TripAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Trips");
  }
}
class NotificationAppbar extends StatelessWidget {
  const NotificationAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Reminder");
  }
}
class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Profile");
  }
}
class SuggestionAppBar extends StatelessWidget {
  const SuggestionAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Places");
  }
}


