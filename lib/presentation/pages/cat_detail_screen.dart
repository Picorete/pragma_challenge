import 'dart:ui';

import 'package:cats/common/constants/colors.dart';
import 'package:cats/common/widgets/custom_app_padding.dart';
import 'package:cats/common/widgets/custom_elevated_button.dart';
import 'package:cats/domain/entities/cat.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CatDetailPage extends StatelessWidget {
  CatDetailPage({Key? key, required this.cat}) : super(key: key);

  final Cat cat;
  late ThemeData themeData;
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    themeData = Theme.of(context);

    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            _catImageHeader(context),
            _contentContainer(
                child: Column(
              children: [
                _nameContainer(),
                _buildTemperamentText(),
                const SizedBox(
                  height: 10,
                ),
                _buildWeightTextAndOrigin(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  cat.description,
                  style: themeData.textTheme.bodyText1,
                ),
                _buildExtraCaracteristics(),
                _buildInfoUrls(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _catImageHeader(BuildContext context) {
    return SizedBox(
        height: size.height * .35,
        child: Stack(
          children: [
            Container(
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      cat.image.url,
                    ),
                    fit: BoxFit.fill),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Center(
              child: Hero(
                tag: cat.name,
                child: Image.network(
                  cat.image.url,
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: primaryColor,
                  )),
            )
          ],
        ));
  }

  Widget _contentContainer({required Widget child}) {
    return Positioned(
      bottom: 0,
      height: size.height * .67,
      width: size.width,
      child: Container(
        decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        height: size.height * .6,
        child: CustomAppPadding(
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _nameContainer() {
    return Column(
      children: [
        Text(
          cat.name,
          style: themeData.textTheme.headline2,
        ),
        Divider(
          color: primaryColor,
          endIndent: size.width * .1,
          indent: size.width * .1,
          thickness: 3,
        ),
      ],
    );
  }

  Widget _buildTemperamentText() {
    return Row(
      children: [
        const Icon(
          Icons.sentiment_satisfied_alt_rounded,
          color: primaryColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            cat.temperament,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: themeData.textTheme.bodyText1,
          ),
        )
      ],
    );
  }

  Widget _buildWeightTextAndOrigin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.monitor_weight_outlined,
              color: primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Imperial: ${cat.weight.imperial}\nMetric: ${cat.weight.metric}',
              style: themeData.textTheme.bodyText1,
            )
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.flag_outlined,
              color: primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cat.origin,
              style: themeData.textTheme.bodyText1,
            )
          ],
        )
      ],
    );
  }

  Widget _buildExtraCaracteristics() {
    return GridView.count(
      padding: const EdgeInsets.symmetric(vertical: 10),
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (cat.affectionLevel != null)
          _caracteristics(
              icon: Icons.favorite_border_outlined,
              points: cat.affectionLevel!,
              text: 'Affection'),
        if (cat.childFriendly != null)
          _caracteristics(
              icon: Icons.child_care,
              points: cat.childFriendly!,
              text: 'Child friendly'),
        if (cat.dogFriendly != null)
          _caracteristics(
              icon: Icons.pets_outlined,
              points: cat.dogFriendly!,
              text: 'Dog friendly'),
        if (cat.energyLevel != null)
          _caracteristics(
              icon: Icons.battery_4_bar_outlined,
              points: cat.energyLevel!,
              text: 'Energy level'),
        if (cat.healthIssues != null)
          _caracteristics(
              icon: Icons.heart_broken_outlined,
              points: cat.healthIssues!,
              text: 'Health issues'),
        _caracteristics(
            icon: Icons.smart_toy_outlined,
            points: cat.intelligence,
            text: 'Intelligence'),
        if (cat.socialNeeds != null)
          _caracteristics(
              icon: Icons.social_distance_outlined,
              points: cat.socialNeeds!,
              text: 'Social needs'),
        if (cat.strangerFriendly != null)
          _caracteristics(
              icon: Icons.person_search_outlined,
              points: cat.strangerFriendly!,
              text: 'Stranger friendly'),
        _caracteristics(
            icon: Icons.h_mobiledata_rounded,
            points: cat.hairless,
            text: 'Hairless'),
        _caracteristics(
            icon: Icons.shower, points: cat.grooming, text: 'Grooming'),
        if (cat.sheddingLevel != null)
          _caracteristics(
              icon: Icons.alt_route_outlined,
              points: cat.sheddingLevel!,
              text: 'Shedding level'),
        if (cat.lifeSpan != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Life span',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: themeData.textTheme.bodyText1!
                    .copyWith(fontWeight: FontWeight.bold, color: primaryColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.numbers_outlined,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    cat.lifeSpan!,
                    style: themeData.textTheme.bodyText1,
                  )
                ],
              ),
            ],
          )
      ],
    );
  }

  Widget _caracteristics(
      {required IconData icon, required String text, required int points}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: themeData.textTheme.bodyText1!
              .copyWith(fontWeight: FontWeight.bold, color: primaryColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: primaryColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '$points/10',
              style: themeData.textTheme.bodyText1,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildInfoUrls() {
    return Column(
      children: [
        Text(
          'Info Urls',
          style: themeData.textTheme.headline2,
        ),
        GridView.count(
          padding: const EdgeInsets.symmetric(vertical: 10),
          crossAxisCount: 2,
          childAspectRatio: 3,
          shrinkWrap: true,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
          children: [
            if (cat.wikipediaUrl != null)
              CustomElevatedButton(
                  onPressed: () async {
                    await launchUrlString(cat.wikipediaUrl!);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Wikipedia',
                        style: themeData.textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.link)
                    ],
                  )),
            if (cat.cfaUrl != null)
              CustomElevatedButton(
                  onPressed: () async {
                    await launchUrlString(cat.cfaUrl!);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Cfa',
                        style: themeData.textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.link)
                    ],
                  )),
            if (cat.vetstreetUrl != null)
              CustomElevatedButton(
                  onPressed: () async {
                    await launchUrlString(cat.vetstreetUrl!);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Vetstreet',
                        style: themeData.textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.link)
                    ],
                  )),
            if (cat.vcahospitalsUrl != null)
              CustomElevatedButton(
                  onPressed: () async {
                    await launchUrlString(cat.vcahospitalsUrl!);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Vcahospitals',
                        style: themeData.textTheme.bodyText1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.link)
                    ],
                  )),
          ],
        ),
      ],
    );
  }
}
