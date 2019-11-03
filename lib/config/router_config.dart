import 'package:hello/components/test_custom_painter.dart';
import 'package:hello/home/animation/animation.dart';
import 'package:hello/home/animation/animation2.dart';
import 'package:hello/home/animation/animation3.dart';
import 'package:hello/home/animation/animation4.dart';
import 'package:hello/home/animation/animation5.dart';
import 'package:hello/home/animation/animation6.dart';
import 'package:hello/home/animation/animation7.dart';
import 'package:hello/home/animation/two_widget.dart';
import 'package:hello/home/base/fitText/baseText.dart';
import 'package:hello/home/base/fitText/caculate_size.dart';
import 'package:hello/home/base/fitText/fitBox.dart';
import 'package:hello/home/base/fitText/fittedBox.dart';
import 'package:hello/home/base/fitText/text_font_family.dart';
import 'package:hello/home/base/fitText/wisdom_fit_text.dart';
import 'package:hello/home/base/fractionally_sized_box.dart';
import 'package:hello/home/base/future_builder.dart';
import 'package:hello/home/base/future_test_page.dart';
import 'package:hello/home/base/image/image_provider.dart';
import 'package:hello/home/base/image_center_slice.dart';
import 'package:hello/home/base/layoutbuild_page.dart';
import 'package:hello/home/base/mixin_page.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/home/base/overflow_box.dart';
import 'package:hello/home/base/refresh_indicator.dart';
import 'package:hello/home/base/rotate_test_page.dart';
import 'package:hello/home/base/scroll_view/custom_scroll_view.dart';
import 'package:hello/home/base/scroll_view/custom_scroll_view2.dart';
import 'package:hello/home/base/scroll_view/list_view_1.dart';
import 'package:hello/home/base/scroll_view/list_view_2.dart';
import 'package:hello/home/base/scroll_view/listview.dart';
import 'package:hello/home/base/scroll_view/nested_scroll_view.dart';
import 'package:hello/home/base/scroll_view/nested_scroll_view2.dart';
import 'package:hello/home/base/scroll_view/overflow_page.dart';
import 'package:hello/home/base/scroll_view/slives/sliver_app_bar.dart';
import 'package:hello/home/base/scroll_view/slives/sliver_fill_viewport.dart';
import 'package:hello/home/base/scroll_view/slives/sliver_persistent_header.dart';
import 'package:hello/home/base/scroll_view/slives/sliver_prototype_extent_list.dart';
import 'package:hello/home/base/test_box.dart';
import 'package:hello/home/base/test_mutex_page.dart';
import 'package:hello/home/base/test_render_box.dart';
import 'package:hello/home/base/textfield.dart';
import 'package:hello/home/base/ticker.dart';
import 'package:hello/home/base/webview_flutter.dart';
import 'package:hello/home/combine/bottomSheet.dart';
import 'package:hello/home/combine/dialog.dart';
import 'package:hello/home/combine/draw_panel/draw_panel_page.dart';
import 'package:hello/home/combine/loading.dart';
import 'package:hello/home/combine/pop_drag_view.dart';
import 'package:hello/home/combine/popview.dart';
import 'package:hello/home/combine/video_demo.dart';
import 'package:hello/home/logic/backdrop_filter.dart';
import 'package:hello/home/logic/capture_image.dart';
import 'package:hello/home/logic/exception.dart';
import 'package:hello/home/logic/import_test.dart';
import 'package:hello/home/logic/inheritedWidget_test.dart';
import 'package:hello/home/logic/isolate_page.dart';
import 'package:hello/home/logic/json_parse/json_parse.dart';
import 'package:hello/home/logic/lifecycle/first_page.dart';
import 'package:hello/home/logic/lifecycle/second_page.dart';
import 'package:hello/home/logic/size_notification.dart';
import 'package:hello/home/logic/test_map.dart';
import 'package:hello/home/logic/test_navBack.dart';
import 'package:hello/home/logic/upload_file_page.dart';
import 'package:hello/home/logic/websocket.dart';
import 'package:hello/home/platform_view_test.dart';
import 'package:hello/utils/route.dart';

List<dynamic> _globalRouters = [
  MyRouterList(name: 'Base', lists: [
    MyRouterList(name: 'scroll', lists: [
      MyRouterList(name: 'slives', lists: [
        MyRouter(name: 'SliverProtoTypeExtentListPage', routeName: 'SliverProtoTypeExtentListPage', widget: SliverProtoTypeExtentListPage()),
        MyRouter(name: 'SliverFillViewportPage', routeName: 'SliverFillViewportPage', widget: SliverFillViewportPage()),
        MyRouter(name: 'SliverAppBarPage', routeName: 'SliverAppBarPage', widget: SliverAppBarPage()),
        MyRouter(name: 'SliverPersistentHeaderPage', routeName: 'SliverPersistentHeaderPage', widget: SliverPersistentHeaderPage()),
        MyRouter(name: 'SliverFillViewportPage', routeName: 'SliverFillViewportPage', widget: SliverFillViewportPage()),
        MyRouter(name: 'SliverFillViewportPage', routeName: 'SliverFillViewportPage', widget: SliverFillViewportPage()),
      ]),
      MyRouter(name: 'listview1', routeName: '/base/listview1', widget: TestListView1()),
      MyRouter(name: 'listview2', routeName: '/base/listview2', widget: TestListView2()),
      MyRouter(name: 'customScrollview', routeName: '/base/scroll/customScrollview', widget: TestCustomScrollView()),
      MyRouter(name: 'nestedScrollview', routeName: '/base/scroll/nestedScrollview', widget: TestNestScrollViewDemo()),
      MyRouter(name: 'nestedScrollview2', routeName: '/base/scroll/nestedScrollview2', widget: TestNestScrollViewDemo2()),
      MyRouter(name: 'CustomScrollViewTest2', routeName: '/base/scroll/CustomScrollViewTest2', widget: CustomScrollViewTest2()),
      MyRouter(name: 'ListView1', routeName: '/base/scroll/listview1', widget: ListViewPage1()),
    ]),
    MyRouterList(name: 'fixText', lists: [
      MyRouter(name: 'WisdomFitTextPage', routeName: '/base/fixText/WisdomFitTextPage', widget: WisdomFitTextPage()),
      MyRouter(name: 'CaculatePage', routeName: '/base/fixText/caculate_page', widget: CalculatePage()),
      MyRouter(name: 'FitBoxPage', routeName: '/base/fixText/FitBoxPage', widget: FitBoxPage()),
      MyRouter(name: 'FittedBoxPage', routeName: '/base/fixText/FittedBoxPage', widget: FittedBoxPage()),
      MyRouter(name: 'BaseTextWidthPage', routeName: '/base/fixText/baseText', widget: BaseTextWidthPage()),
      MyRouter(name: 'TextFontFamilyPage', routeName: '/base/fixText/FittedBoxPage', widget: TextFontFamilyPage()),
    ]),
    MyRouter(name: 'layoutBuild', routeName: '/base/layoutBuild', widget: LayoutBuildTestPage()),
    MyRouter(name: 'WebViewFlutterTestPage', routeName: '/base/layoutBuild', widget: WebViewFlutterTestPage()),
    MyRouter(name: 'PlatformViewTestPage', routeName: '/base/layoutBuild', widget: PlatformViewTestPage()),
    MyRouter(name: 'TestRenderBoxPage', routeName: '/base/layoutBuild', widget: TestRenderBoxPage()),
    MyRouter(name: 'TestField', routeName: '/base/textfield', widget: TextFieldPage()),
    MyRouter(name: 'BoxTestPage', routeName: '/base/listview1', widget: BoxTestPage()),
    MyRouter(name: 'Future Build', routeName: '/base/flutter_build', widget: FutureBuildPage()),
    MyRouter(name: 'Refresh Indicator', routeName: '/base/refresh_indicator', widget: RefreshIndicatorPage()),
    MyRouter(name: 'FractionallySizedBox', routeName: '/base/fractional_sizebox', widget: FractionallBoxPage()),
    MyRouter(name: 'ImageCenterSlicePage', routeName: '/base/imagecenter_slice', widget: ImageCenterSlicePage()),
    MyRouter(name: 'ObjectdbTestPage', routeName: '/base/objectpage', widget: ObjectdbTestPage()),
    MyRouter(name: 'TickerTestPage', routeName: '/base/tickerpage', widget: TickerTestPage()),
    MyRouter(name: 'FutureTestPage', routeName: '/base/futureTest', widget: FutureTestPage()),
    MyRouter(name: 'MixinTestPage', routeName: '/base/mixinpage', widget: MixinTestPage()),
    MyRouter(name: 'MutexTestPage', routeName: '/base/mutexpage', widget: MutexTestPage()),
    MyRouter(name: 'Rotate', routeName: '/base/rotat1', widget: TestRotatePage()),
    MyRouter(name: 'Overflow', routeName: '/base/overflowBox', widget: OverFlowBoxPage()),
    MyRouter(name: 'image/imageProvider', routeName: '/base/image/imageProvider', widget: ImageProviderPage()),
    MyRouter(name: 'overflow', routeName: '/base/overflow', widget: TestOverflowPage()),
  ]),
  MyRouterList(name: 'Animation', lists: [
    MyRouter(name: 'animation', widget: AnimationPage()),
    MyRouter(name: 'animation2', widget: AnimatePage2()),
    MyRouter(name: 'animation3', widget: AnimatePage3()),
    MyRouter(name: 'animation4', widget: AnimatePage4()),
    MyRouter(name: 'animation5', widget: AnimatePage5()),
    MyRouter(name: 'animation6', widget: AnimatePage6()),
    MyRouter(name: 'animation7', widget: AnimatePage7()),
    MyRouter(name: 'TestTwoWidgetAnimationPage', widget: TestTwoWidgetAnimationPage()),
  ]),
  MyRouterList(name: 'Combine', lists: [
    MyRouter(name: 'Dialog', widget: DialogPage()),
    MyRouter(name: 'PopView', widget: PopViewPage()),
    MyRouter(name: 'PopDragView', widget: PopDragViewPage()),
    MyRouter(name: 'Loading', widget: LoadingPage()), //VideoDemo
    MyRouter(name: 'VideoDemo', widget: VideoDemo()),
    MyRouter(name: 'BottomSheet', widget: BottomSheetPage()),
    MyRouter(name: 'TestCustomPainterInListView', widget: TestCustomPainterInListView()),
    MyRouter(name: 'DrawPanelPage', widget: DrawPanelPage()),
  ]),
  MyRouterList(name: 'logics', lists: [
    MyRouterList(name: 'lifecycle', lists: [
      MyRouter(name: 'firstTestPage', widget: FirstTestPage()),
      MyRouter(name: 'secondTestPage', widget: SecondTestPage()),
    ]),
    MyRouter(name: 'importTestPage', widget: ImportTestPage()),
    MyRouter(name: 'InheritedWidgetTest', widget: InheritedWidgetTest()),
    MyRouter(name: 'SizeChangedNotification', widget: SizeChangedLayoutNotification()),
    MyRouter(name: 'TestCaptureImage', widget: TestCaptureImage()),
    MyRouter(name: 'TestBackdropFilterPage', widget: TestBackdropFilterPage()),
    MyRouter(name: 'TestNavBackPage', widget: TestNavBackPage()),
    MyRouter(name: 'JsonParsePage', widget: JsonParsePage()),
    MyRouter(name: 'UploadFilePage', widget: UploadFilePage()),
    MyRouter(name: 'IsolateTestPage', widget: IsolateTestPage()),
    MyRouter(name: 'TestMapPage', widget: TestMapPage()),
    MyRouter(name: 'ExceptionTestPage', widget: ExceptionTestPage()),
    MyRouter(name: 'WebSocketTestPage', widget: WebSocketTestPage()),
  ]),
  MyRouterList(name: 'others', lists: []),
];

var globalRouters = MyRouterList(lists: _globalRouters, name: 'flutter测试123'); //表示
