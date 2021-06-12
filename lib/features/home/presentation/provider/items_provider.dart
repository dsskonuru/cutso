import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sources/items_repository.dart';

final itemsProvider = Provider<ItemsRepository>((ref) => ItemsRepository());
