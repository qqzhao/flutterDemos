

### 单例

```
class Injector {

  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();// 命名构造函数，空的实现

  ContactsRepository get contactRepository {
    return new GetContactsRepository();
  }
}
```
[from](https://www.dartlang.org/guides/language/effective-dart/usage#do-use--instead-of--for-empty-constructor-bodies)

### ListTile 类似于系统提供的tableviewCell，复用的方法

```
class _ContactListItem extends ListTile {
  _ContactListItem({ Contact contact,
     GestureTapCallback onTap}) :
        super(
          title : new Text(contact.fullName),
          subtitle: new Text(contact.email),
          leading: new CircleAvatar(
              child: new Text(contact.fullName[0])
          ),
          onTap: onTap
      );
}
```

### CircleAvatar 原型头像

```
new CircleAvatar(
    child: new Text(contact.fullName[0])
),
```

### IconButton

```
new IconButton(icon: new Icon(Icons.print), onPressed: () {
  print("right clicked");
})
```