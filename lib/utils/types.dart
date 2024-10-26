typedef ChangeCallback<T> = void Function(T value);
typedef AsyncChangeCallback<T> = Future<void> Function(T value);
