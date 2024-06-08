import 'package:doctor247_doutor/theme/extention.dart';
import 'package:doctor247_doutor/theme/light_color.dart';
import 'package:doctor247_doutor/theme/text_styles.dart';
import 'package:doctor247_doutor/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:medic_repository/medic_repository.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key, required this.medic}) : super(key: key);
  final Medic medic;

  static Route<void> route(Medic medic) {
    return MaterialPageRoute<void>(
        builder: (_) => DoctorProfileScreen(
              medic: medic,
            ));
  }

  @override
  _DoctorProfileScreen createState() => _DoctorProfileScreen();
}

class _DoctorProfileScreen extends State<DoctorProfileScreen> {
  late Medic medic;

  @override
  void initState() {
    medic = widget.medic;
    super.initState();
  }

  // Widget _appbar() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       BackButton(color: Theme.of(context).primaryColor),
  //       IconButton(
  //           icon: Icon(
  //             model.isfavourite ? Icons.favorite : Icons.favorite_border,
  //             color: model.isfavourite ? Colors.red : LightColor.grey,
  //           ),
  //           onPressed: () {
  //             setState(() {
  //               model.isfavourite = !model.isfavourite;
  //             });
  //           })
  //     ],
  //   );
  // }

  dynamicChips() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 3.0,
      children: List<Widget>.generate(medic.specialty.length, (int index) {
        return Chip(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 1,
          label: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              medic.specialty[index].name,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      // backgroundColor: LightColor.extraLightBlue,
      extendBodyBehindAppBar: true,
      // backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: 'doc_prof_pic',
              child: Image.network(
                  'https://thumbs.dreamstime.com/z/senior-doctor-laughing-to-camera-16276713.jpg'),
            ),
            AppBar(
              leading: const BackButton(color: Colors.black54),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            DraggableScrollableSheet(
              maxChildSize: 1,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: const EdgeInsets.only(left: 19, right: 19, top: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                medic.name,
                                style: titleStyle,
                              ),
                              const SizedBox(width: 10),
                              // Icon(Icons.check_circle,
                              //     size: 18,
                              //     color: Theme.of(context).primaryColor),
                              const Spacer(),
                              Text(
                                '#${medic.crm}',
                                style: TextStyles.bodySm.subTitleColor.bold,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.mail_outline),
                                  const SizedBox(width: 10),
                                  Text(
                                    ' - ',
                                    style: TextStyles.body,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.phone_outlined),
                                  const SizedBox(width: 10),
                                  Text(
                                    medic.tel,
                                    style: TextStyles.body,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.house_outlined),
                                  const SizedBox(width: 10),
                                  Text(
                                    medic.adress,
                                    style: TextStyles.body,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        dynamicChips(),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("Sobre", style: titleStyle).vP16,
                        Text(
                          'Lorem ipsum dolor sit amet. Aut suscipit rerum aut harum laudantium aut impedit modi vel natus deleniti et sint officia sit quaerat cupiditate qui facilis inventore. Aut quasi itaque nam voluptatum vero sit enim omnis ut dolores commodi ut perferendis blanditiis.',
                          style: TextStyles.body.black,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //_appbar(),
          ],
        ),
      ),
    );
  }
}
