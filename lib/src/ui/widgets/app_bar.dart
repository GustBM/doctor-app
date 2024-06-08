import 'package:doctor247_doutor/src/ui/profile/doctor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:medic_repository/medic_repository.dart';

class DoctorAppBar extends StatelessWidget with PreferredSizeWidget {
  const DoctorAppBar({super.key, required this.medic});
  final Medic medic;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Image(
        image: AssetImage('assets/images/logo-new.png'),
        width: 200,
        height: 50,
      ),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: IconButton(
          icon: const Icon(
            Icons.short_text,
            size: 30,
            color: Colors.black54,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        // IconButton(
        //   icon: const Icon(
        //     Icons.notifications,
        //     color: Colors.black54,
        //     size: 30,
        //   ),
        //   onPressed: () {
        //     // handle the press
        //   },
        // ),
        const SizedBox(width: 10),
        IconButton(
          icon: Hero(
            tag: 'doc_prof_pic',
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.grey,
              backgroundImage: Image.network(
                      'https://thumbs.dreamstime.com/z/senior-doctor-laughing-to-camera-16276713.jpg')
                  .image,
            ),
          ),
          onPressed: () =>
              Navigator.of(context).push(DoctorProfileScreen.route(medic)),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
