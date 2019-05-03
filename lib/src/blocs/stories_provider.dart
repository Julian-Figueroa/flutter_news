import 'package:flutter/material.dart';
import 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc = StoriesBloc();

  StoriesProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider) as StoriesProvider).bloc;
  }
}
