import 'package:get/get.dart';

import '_en.dart';
import '_th.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'th_TH': th,
        'en_US': en,
      };
}
