# Annotation 註解

Dart 本身支持反射，但 Flutter 幾乎放棄「手稿語言（英語：Scripting language）」動態化的特性，如不支持反射、也不支持動態建立函數

所以序列化只有靠攔截註解來動態產生程式碼

## 註解

- 為程式碼提供語意訊息、詮釋資料（metadata）的標註
- 可以作用於類別、方法、屬性等

```dart
library todo;

class Todo {
  final String who;
  final String what;

  // 有 const 的建構子就可以使用註解
  const Todo(this.who, this.what);
}
```

使用方式

```dart
import 'todo.dart';

@Todo('seth', 'make this do something')
void doSomething() {
  print('do something');
}
```