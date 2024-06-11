import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pidenomas/ui/general/colors.dart'; // Asegúrate de que los colores estén definidos correctamente

class ShimmerLoadingWidget extends StatefulWidget {
  @override
  _ShimmerLoadingWidgetState createState() => _ShimmerLoadingWidgetState();
}

class _ShimmerLoadingWidgetState extends State<ShimmerLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedContainer() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width*0.3,
      height: 16.0,
      decoration: BoxDecoration(
        color: Color(0xffFEF7FF),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAnimatedContainer(),
          SizedBox(height: 10),
          _buildAnimatedContainer(),
          SizedBox(height: 10),
          _buildAnimatedContainer(),
        ],
      ),
    );
  }
}
