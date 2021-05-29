import 'package:lil_pipe/lil_pipe.dart';

void main() {
  const List<int> list = <int>[1, 2, 3];
  final List<int> mutationList = (list >>
      (List<int> l) =>
          List<int>.of(l) >>
          (List<int> l) => l.map((int e) => e + 1).toList()) as List<int>;

  print(list);
  print(mutationList);
  print(list >> (List<int> l) => l.first);
  print(mutationList >> (List<int> l) => l.first);

  print('');

  const Map<String, int> map = <String, int>{'a': 1, 'b': 2, 'c': 3};
  final Map<String, int> mutationMap = (map >>
          (Map<String, int> m) =>
              Map<String, int>.of(m) >>
              (Map<String, int> m) => m..updateAll((String k, int v) => v + 1)) as Map<String, int>;

  print(map);
  print(mutationMap);
  print(map >> (Map<String, int> m) => m.entries.first);
  print(mutationMap >> (Map<String, int> m) => m.entries.first);
}
