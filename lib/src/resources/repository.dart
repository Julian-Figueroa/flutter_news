import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_module.dart';

class Reposity {
  List<Source> sources = <Source>[
    newsDatabaseProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDatabaseProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
