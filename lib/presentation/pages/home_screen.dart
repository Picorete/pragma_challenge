import 'package:cats/common/constants/colors.dart';
import 'package:cats/presentation/widgets/cats_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cats/presentation/widgets/custom_search_form_field.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/custom_app_padding.dart';
import '../notifiers/cats_list_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final CatsListNotifier _catsListNotifier = CatsListNotifier();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      body: CustomAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight - 30,
            ),
            Text(
              'Catbreeds',
              style: appTheme.textTheme.headline2,
            ),
            _buildHomeHeader(appTheme),
            const SizedBox(
              height: 10,
            ),
            CustomSearchFormField(),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: _buildCatsCardList(appTheme)),
          ],
        ),
      ),
    );
  }

  Widget _buildCatsCardList(ThemeData appTheme) {
    return AnimatedBuilder(
        animation: _catsListNotifier,
        builder: (context, _) {
          if (_catsListNotifier.cats.isNotEmpty) {
            return MasonryGridView.count(
              padding: const EdgeInsets.symmetric(vertical: 10),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              addAutomaticKeepAlives: true,
              itemCount: _catsListNotifier.cats.length,
              itemBuilder: (context, index) {
                return CatsCard(
                  cat: _catsListNotifier.cats[index],
                );
              },
            );
          } else {
            return Center(
                child: Text(
              'Without results',
              style: appTheme.textTheme.bodyText1,
            ));
          }
        });
  }

  Widget _buildHomeHeader(ThemeData appTheme) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColorLight, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppPadding(
            child: Column(
              children: [
                Text(
                  'knows the different',
                  style: appTheme.textTheme.bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Breed of cats',
                  style: appTheme.textTheme.headline2!
                      .copyWith(color: primaryColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/gatito.png',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
