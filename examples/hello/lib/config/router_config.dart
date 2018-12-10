import 'package:hello/home/animation/animation.dart';
import 'package:hello/home/animation/animation2.dart';
import 'package:hello/home/animation/animation3.dart';
import 'package:hello/home/animation/animation4.dart';
import 'package:hello/home/animation/animation5.dart';
import 'package:hello/home/animation/animation6.dart';
import 'package:hello/home/animation/animation7.dart';

import 'package:hello/home/base/caculate_size.dart';
import 'package:hello/home/base/fitBox.dart';
import 'package:hello/home/base/fittedBox.dart';
import 'package:hello/home/base/fractionally_sized_box.dart';
import 'package:hello/home/base/future_builder.dart';
import 'package:hello/home/base/future_test_page.dart';
import 'package:hello/home/base/image_center_slice.dart';
import 'package:hello/home/base/listview.dart';
import 'package:hello/home/base/mixin_page.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/home/base/refresh_indicator.dart';
import 'package:hello/home/base/textfield.dart';
import 'package:hello/home/base/ticker.dart';
import 'package:hello/home/combine/bottomSheet.dart';
import 'package:hello/home/combine/dialog.dart';
import 'package:hello/home/combine/loading.dart';
import 'package:hello/home/combine/pop_drag_view.dart';
import 'package:hello/home/combine/popview.dart';
import 'package:hello/home/combine/video_demo.dart';
import 'package:hello/home/logic/import_test.dart';

import 'package:hello/utils/route.dart';

List<dynamic> _globalRouters = [
  MyRouterList(name: 'Base', lists: [
    MyRouter(name: 'TestField', routeName: '/base/textfield', widget: new TextFieldPage()),
    MyRouter(name: 'ListView1', routeName: '/base/listview1', widget: new ListViewPage1()),
    MyRouter(name: 'Future Build', routeName: '/base/flutter_build', widget: new FutureBuildPage()),
    MyRouter(name: 'Refresh Indicator', routeName: '/base/refresh_indicator', widget: new RefreshIndicatorPage()),
    MyRouter(name: 'FractionallySizedBox', routeName: '/base/fractional_sizebox', widget: new FractionallBoxPage()),
    MyRouter(name: 'ImageCenterSlicePage', routeName: '/base/imagecenter_slice', widget: new ImageCenterSlicePage()),
    MyRouter(name: 'ObjectdbTestPage', routeName: '/base/objectpage', widget: new ObjectdbTestPage()),
    MyRouter(name: 'CaculatePage', routeName: '/base/caculate_page', widget: new CaculatePage()), //
    MyRouter(name: 'FitBoxPage', routeName: '/base/objectpage', widget: new FitBoxPage()),
    MyRouter(name: 'TickerTestPage', routeName: '/base/tickerpage', widget: new TickerTestPage()),
    MyRouter(name: 'FutureTestPage', routeName: '/base/futureTest', widget: new FutureTestPage()),
    MyRouter(name: 'FittedBoxPage', routeName: '/base/objectpage', widget: new FittedBoxPage()),
    MyRouter(name: 'MixinTestPage', routeName: '/base/mixinpage', widget: new MixinTestPage()),
  ]),
  MyRouterList(name: 'Animation', lists: [
    MyRouter(name: 'animation', widget: new AnimationPage()),
    MyRouter(name: 'animation2', widget: new AnimatePage2()),
    MyRouter(name: 'animation3', widget: new AnimatePage3()),
    MyRouter(name: 'animation4', widget: new AnimatePage4()),
    MyRouter(name: 'animation5', widget: new AnimatePage5()),
    MyRouter(name: 'animation6', widget: new AnimatePage6()),
    MyRouter(name: 'animation7', widget: new AnimatePage7()),
  ]),
  MyRouterList(name: 'Combine', lists: [
    MyRouter(name: 'Dialog', widget: new DialogPage()),
    MyRouter(name: 'PopView', widget: new PopViewPage()),
    MyRouter(name: 'PopDragView', widget: new PopDragViewPage()),
    MyRouter(name: 'Loading', widget: new LoadingPage()), //VideoDemo
    MyRouter(name: 'VideoDemo', widget: new VideoDemo()),
    MyRouter(name: 'BottomSheet', widget: new BottomSheetPage()),
  ]),
  MyRouterList(name: 'logics', lists: [
    MyRouter(name: 'importTestPage', widget: new ImportTestPage()),
  ]),
  MyRouterList(name: 'others', lists: []),
];

var globalRouters = new MyRouterList(lists: _globalRouters, name: 'flutter demos');
