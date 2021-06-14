import 'package:lil_guid/lil_guid.dart';

void main() {
  print(Guid.empty.toString());
  print(Guid.empty.toList());

  print('/------------------/');

  final Guid a = Guid();
  print(a.toString());
  print(a.toBytes());
  print(a.toList());

  print('/------------------/');

  final Guid b = Guid.parseString('ca761232-ed42-11ce-bacd-00aa0057b223');
  print(b.toString());
  print(b.toBytes());
  print(b.toList());
  print(b ==
      Guid.parseList(<int>[
        202,
        118,
        18,
        50,
        237,
        66,
        17,
        206,
        186,
        205,
        0,
        170,
        0,
        87,
        178,
        35
      ]));

  print('/------------------/');

  final Guid c = Guid.parseList(<int>[
    46,
    231,
    148,
    107,
    159,
    84,
    71,
    138,
    151,
    217,
    240,
    247,
    110,
    166,
    105,
    62
  ]);
  print(c.toString());
  print(c.toBytes());
  print(c.toList());
  print(c == Guid.parseString('2ee7946b-9f54-478a-97d9-f0f76ea6693e'));

  print('/------------------/');

  print(Guid.parseString('01e75c83-c6f5-4192-b57e-7427cec5560d')
      .compareTo(Guid.parseString('01e75c83-c6f5-4192-b57e-7427cec5560c')));
  print(Guid.parseString('01e75c83-c6f5-4192-b57e-7427cec5560d')
      .compareTo(Guid.parseString('01e75c83-c6f5-4192-b57e-7427cec5560d')));
  print(Guid.parseString('01e75c83-c6f5-4192-b57e-7427cec5560d')
      .compareTo(Guid.parseString('01e75c84-c6f5-4192-b57e-7427cec5560d')));
}
