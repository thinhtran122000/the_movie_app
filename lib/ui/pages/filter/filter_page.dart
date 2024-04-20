import 'package:flutter/material.dart';
import 'package:tmdb/ui/components/components.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        // title: const CustomAppBarTitle(titleAppBar: 'Filter'),
        onTapLeading: () => Navigator.of(context).pop(),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Filter',
            ),
          ],
        ),
      ),
    );
  }
}
