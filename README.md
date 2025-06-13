# custom_tab_view

A Flutter widget that provides a **dynamic and robust tab view solution**, addressing common limitations and bugs in Flutter’s default `TabBar` and `TabBarView` when working with changing tab counts and advanced tab interaction needs.

## Motivation

Flutter’s built-in tab system works well for static tab counts but often struggles when the number of tabs changes dynamically during runtime. Common issues include:

- `TabController` becoming out of sync with the tab count.
- Index errors when the current tab position exceeds the new tab count.
- Lack of easy hooks to listen to tab scroll progress.
- No straightforward way to show placeholder content when there are no tabs.

This package solves those issues by automatically managing the `TabController` lifecycle, enforcing valid tab indices, and exposing detailed callbacks for tab position changes and scroll events.

## Features

- Automatic handling of **dynamic tab count changes** without UI glitches or crashes.
- Safe management of **initial tab index** with bounds checks.
- Callbacks for **tab position changes** and **scroll progress** to enable custom reactions.
- Flexible `IndexedWidgetBuilder` APIs for tabs and pages.
- Optional placeholder widget support when no tabs are present.

## Usage

```dart
CustomTabView(
  itemCount: tabs.length,
  tabBuilder: (context, index) => Tab(text: tabs[index]),
  pageBuilder: (context, index) => TabContentWidget(index: index),
  initPosition: 0,
  indicatorColor: Colors.blue,
  labelColor: Colors.black,
  onPositionChange: (index) {
    print("Current tab: $index");
  },
  onScroll: (position) {
    print("Scroll progress: $position");
  },
  stub: Center(child: Text("No tabs available")),
)
