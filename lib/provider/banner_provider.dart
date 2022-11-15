import 'package:flutter/cupertino.dart';

import '../model/banner.dart';

class BannerProvider extends ChangeNotifier {
  List<Bannerr> _mList = LIST_BANNER;
  List<Bannerr> get mListBanner => _mList;
}
