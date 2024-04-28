import 'package:flutter/material.dart';
import 'package:todoappvb/ui/shared/styles/text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const CustomCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
      child: Card(
        elevation: 20,
        child: ListTile(
          title: Text(
            title,
            style: titleStyle,
          ),
          subtitle: Text(subtitle),
          trailing: imagePlace,
        ),
      ),
    );
  }

  Widget get imagePlace {
    return imageUrl.isEmpty
        ? const SizedBox(width: 100, child: Placeholder())
        : Image.network(imageUrl);
  }
}
