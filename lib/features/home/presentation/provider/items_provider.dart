import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sources/items_firestore.dart';

final itemsProvider = Provider<ItemsFirestore>((ref) => ItemsFirestore());
