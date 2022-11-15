import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../value/loading.dart';

class DialogProvider {
  void showDialogLoading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) => Center(
              child: LottieBuilder.network(
                ImageURL.loading,
                width: 100,
                height: 100,
              ),
            )));
  }
}
