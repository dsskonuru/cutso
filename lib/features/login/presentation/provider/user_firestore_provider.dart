import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sources/users_firestore.dart';

final userProvider = Provider((ref) => UserFirestore());
