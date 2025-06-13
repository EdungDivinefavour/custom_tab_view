import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:customtabview/custom_tab_view.dart';

void main() {
  testWidgets('CustomTabView renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CustomTabView(
        itemCount: 2,
        tabBuilder: (context, i) => Tab(text: 'Tab $i'),
        pageBuilder: (context, i) => Center(child: Text('Page $i')),
      ),
    ));

    expect(find.text('Tab 0'), findsOneWidget);
    expect(find.text('Page 0'), findsOneWidget);
  });
}
