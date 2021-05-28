import 'package:app/base/common/lang.dart';
import 'package:app/base/common/resource.dart';
import 'package:app/page/models/complaint_option.dart';
import 'package:flutter/widgets.dart';

class ComplaintOptionCell extends StatelessWidget {
  final ComplaintOption option;
  const ComplaintOptionCell({Key? key, required this.option}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: R.color_white
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(toString2(option.option)),
              ],
            )
          ],
        )
      );
  }

}