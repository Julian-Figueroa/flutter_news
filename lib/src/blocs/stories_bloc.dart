import 'package:rxdart/rxdart.dart';
// import '../models/item_module.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Reposity();
  final _topsIds = PublishSubject<List<int>>();

  // Getters  to Streams
  Observable<List<int>> get topIds => _topsIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topsIds.sink.add(ids);
  }

  dispose() {
    _topsIds.close();
  }
}
