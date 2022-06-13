import 'package:cats/common/constants/colors.dart';
import 'package:cats/domain/entities/cat.dart';
import 'package:flutter/material.dart';

class CatsCard extends StatefulWidget {
  const CatsCard({Key? key, required this.cat}) : super(key: key);

  final Cat cat;

  @override
  State<CatsCard> createState() => _CatsCardState();
}

class _CatsCardState extends State<CatsCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.pushNamed(context, 'detail', arguments: widget.cat);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: primaryColorLight, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Hero(
                  tag: widget.cat.name,
                  child: Image.network(
                    widget.cat.image.url,
                    height: size.height * .15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return SizedBox(
                            height: size.height * .15,
                            child: const Center(
                                child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(primaryColor),
                            )));
                      }
                    },
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Text(widget.cat.name,
                style: appTheme.textTheme.bodyText1!
                    .copyWith(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
