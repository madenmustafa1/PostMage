import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter(ref);
});

class Counter extends StateNotifier<int> {
  Counter(this.ref): super(0);

  final Ref ref;

  void increment() {
    // Counter can use the "ref" to read other providers
    //final repository = ref.read(repositoryProvider);
    //repository.post('...');
  }
}