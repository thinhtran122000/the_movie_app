import 'package:flutter/material.dart';
import 'package:tmdb/router/router.dart';
import 'package:tmdb/shared_ui/colors/color.dart';

class StreamingView extends StatefulWidget {
  const StreamingView({super.key});

  @override
  State<StreamingView> createState() => _StreamingViewState();
}

class _StreamingViewState extends State<StreamingView> {
  String a = 'a';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/authentication',
          arguments: {
            'is_later_login': true,
            'route': '/navigation/explore/discovery/streaming',
          },
        ).then(
          (results) {
            if (results != null) {
              PopResults popResult = results as PopResults;
              if (popResult.toPage == AppSubRoutes.streaming) {
                setState(() {
                  a = popResult.results?.values.toList()[0];
                });
              }
            }
          },
        );
      },
      child: Center(
        child: Column(
          children: [
            const FlutterLogo(
              size: 200,
            ),
            Text(
              a,
              style: TextStyle(
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
