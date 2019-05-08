import 'package:rxdart/rxdart.dart';
import '../models/item_module.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Reposity();
  final _topsIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Observable<Map<int, Future<ItemModel>>> items;

  // Getters  to Streams
  Observable<List<int>> get topIds => _topsIds.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topsIds.sink.add(ids);
  }

  // Transformer
  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topsIds.close();
    _items.close();
  }
}
