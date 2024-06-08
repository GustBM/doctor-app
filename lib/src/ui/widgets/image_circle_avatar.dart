import 'package:flutter/material.dart';

class ImageCircleAvatar extends StatelessWidget {
  const ImageCircleAvatar({super.key, this.imageUrl});

  final String? imageUrl;

  // NetworkImage? _getImage() {
  //   try {
  //     if (imageUrl == null) {
  //       return null;
  //     }
  //     return NetworkImage(imageUrl!);
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      radius: 40,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 40,
        child: CircleAvatar(
          backgroundImage: Image.network(
            imageUrl!,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              // Appropriate logging or analytics, e.g.
              // myAnalytics.recordError(
              //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
              //   exception,
              //   stackTrace,
              // );
              return const Text('x');
            },
          ).image,
          radius: 40,
        ),
      ),
    );
  }
}
