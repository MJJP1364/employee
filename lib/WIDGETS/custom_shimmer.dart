import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustumShimmer extends StatelessWidget {
  const CustumShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 1000),
        baseColor: Colors.grey,
        highlightColor: Colors.black45,
        child: Container(
          height: 10,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
