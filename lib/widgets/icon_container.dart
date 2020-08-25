import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class IconContainer extends StatelessWidget {
  final double size;
  const IconContainer({Key key, @required this.size}) : assert(size != null && size > 0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.width * 0.17,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 20)
          )
        ]
      ),
      padding: EdgeInsets.all(this.size*4),
      child: Center(
        child: SvgPicture.asset(
          'assets/icon.svg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,

        ),
      ),
    );
  }
}