import 'package:hello/home/animation/animation.dart';
import 'package:hello/home/animation/animation2.dart';
import 'package:hello/home/animation/animation3.dart';
import 'package:hello/home/animation/animation4.dart';
import 'package:hello/home/animation/animation5.dart';
import 'package:hello/home/animation/animation6.dart';
import 'package:hello/home/animation/animation7.dart';
import 'package:hello/home/base/fitText/baseText.dart';

import 'package:hello/home/base/fitText/caculate_size.dart';
import 'package:hello/home/base/fitText/fitBox.dart';
import 'package:hello/home/base/fitText/fittedBox.dart';
import 'package:hello/home/base/fractionally_sized_box.dart';
import 'package:hello/home/base/future_builder.dart';
import 'package:hello/home/base/future_test_page.dart';
import 'package:hello/home/base/image/image_provider.dart';
import 'package:hello/home/base/image_center_slice.dart';
import 'package:hello/home/base/layoutbuild_page.dart';
import 'package:hello/home/base/listview.dart';
import 'package:hello/home/base/mixin_page.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/home/base/overflow_box.dart';
import 'package:hello/home/base/refresh_indicator.dart';
import 'package:hello/home/base/rotate_test_page.dart';
import 'package:hello/home/base/scroll_view/custom_scroll_view.dart';
import 'package:hello/home/base/scroll_view/list_view_1.dart';
import 'package:hello/home/base/scroll_view/nested_scroll_view.dart';
import 'package:hello/home/base/scroll_view/nested_scroll_view2.dart';
import 'package:hello/home/base/test_mutex_page.dart';
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
    MyRouter(name: 'layoutBuild', routeName: '/base/layoutBuild', widget: new LayoutBuildTestPage()),
    MyRouter(name: 'TestField', routeName: '/base/textfield', widget: new TextFieldPage()),
    MyRouter(name: 'ListView1', routeName: '/base/listview1', widget: new ListViewPage1()),
    MyRouter(name: 'Future Build', routeName: '/base/flutter_build', widget: new FutureBuildPage()),
    MyRouter(name: 'Refresh Indicator', routeName: '/base/refresh_indicator', widget: new RefreshIndicatorPage()),
    MyRouter(name: 'FractionallySizedBox', routeName: '/base/fractional_sizebox', widget: new FractionallBoxPage()),
    MyRouter(name: 'ImageCenterSlicePage', routeName: '/base/imagecenter_slice', widget: new ImageCenterSlicePage()),
    MyRouter(name: 'ObjectdbTestPage', routeName: '/base/objectpage', widget: new ObjectdbTestPage()),
    MyRouter(name: 'fixText/CaculatePage', routeName: '/base/fixText/caculate_page', widget: new CaculatePage()),
    MyRouter(name: 'fixText/FitBoxPage', routeName: '/base/fixText/FitBoxPage', widget: new FitBoxPage()),
    MyRouter(name: 'fixText/FittedBoxPage', routeName: '/base/fixText/FittedBoxPage', widget: new FittedBoxPage()),
    MyRouter(name: 'fixText/BaseTextWidthPage', routeName: '/base/fixText/baseText', widget: new BaseTextWidthPage()),
    MyRouter(name: 'TickerTestPage', routeName: '/base/tickerpage', widget: new TickerTestPage()),
    MyRouter(name: 'FutureTestPage', routeName: '/base/futureTest', widget: new FutureTestPage()),
    MyRouter(name: 'MixinTestPage', routeName: '/base/mixinpage', widget: new MixinTestPage()),
    MyRouter(name: 'MutexTestPage', routeName: '/base/mutexpage', widget: new MutexTestPage()),
    MyRouter(name: 'Rotate', routeName: '/base/rotat1', widget: new TestRotatePage()),
    MyRouter(name: 'Overflow', routeName: '/base/overflowBox', widget: new OverFlowBoxPage()),
    MyRouter(name: 'scroll/listview1', routeName: '/base/scroll/listview1', widget: new TestListView1()),
    MyRouter(name: 'scroll/customScrollview', routeName: '/base/scroll/customScrollview', widget: new TestCustomScrollView()),
    MyRouter(name: 'scroll/nestedScrollview', routeName: '/base/scroll/nestedScrollview', widget: new TestNestScrollViewDemo()),
    MyRouter(name: 'scroll/nestedScrollview2', routeName: '/base/scroll/nestedScrollview2', widget: new TestNestScrollViewDemo2()),
    MyRouter(name: 'image/imageProvider', routeName: '/base/image/imageProvider', widget: new ImageProviderPage()),
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

var globalRouters = new MyRouterList(lists: _globalRouters, name: 'flutter测试'); //表示
