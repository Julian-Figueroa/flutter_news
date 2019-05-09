import 'package:rxdart/rxdart.dart';
import '../models/item_module.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Reposity();
  final _topsIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters  to Streams
  Observable<List<int>> get topIds => _topsIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topsIds.sink.add(ids);
  }

  // Transformer
  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topsIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
