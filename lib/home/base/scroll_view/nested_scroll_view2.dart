// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class _Page {
  _Page({this.label});
  final String label;
  String get id => label[0];
  @override
  String toString() => '$runtimeType("$label")';
}

class _CardData {
  const _CardData({this.title, this.imageAsset, this.imageAssetPackage});
  final String title;
  final String imageAsset;
  final String imageAssetPackage;
}

final Map<_Page, List<_CardData>> _allPages = <_Page, List<_CardData>>{
  _Page(label: 'HOME'): <_CardData>[
    const _CardData(
      title: 'Flatwear',
      imageAsset: 'products/flatwear.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Pine Table',
      imageAsset: 'products/table.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Blue Cup',
      imageAsset: 'products/cup.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Tea Set',
      imageAsset: 'products/teaset.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Desk Set',
      imageAsset: 'products/deskset.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],
  _Page(label: 'APPAREL'): <_CardData>[
    const _CardData(
      title: 'Cloud-White Dress',
      imageAsset: 'products/dress.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Ginger Scarf',
      imageAsset: 'products/scarf.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Blush Sweats',
      imageAsset: 'products/sweats.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],
};

/// ignore: unused_element
class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: page.id == 'H' ? Alignment.centerLeft : Alignment.centerRight,
              child: CircleAvatar(child: Text('${page.id}')),
            ),
            SizedBox(
              width: 144.0,
              height: 144.0,
              child: Image.asset(
                data.imageAsset,
                package: data.imageAssetPackage,
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                data.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestNestScrollViewDemo2 extends StatelessWidget {
//  static const String routeName = '/material/tabs';

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: new SliverAppBar(
                  title: const Text('Tabs and scrolling'),
                  actions: <Widget>[], //MaterialDemoDocumentationButton(routeName)
                  pinned: true,
                  expandedHeight: 350.0,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: new SafeArea(
                    child: new Container(
                      width: 100.0,
                      height: 350.0,
                      color: Colors.green,
                      child: new Center(
                        child: new SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
//                          maxHeight: 250.0,
                          child: new Column(
                            children: ['aa', 'bb', 'cc', 'dd', 'ee', 'ff']
                                .map((str) => new Container(
                                      height: 60.0,
                                      child: Text('$str'),
                                      color: Colors.red,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
//                  bottom: TabBar(
//                    tabs: _allPages.keys
//                        .map<Widget>(
//                          (_Page page) => Tab(text: page.label),
//                        )
//                        .toList(),
//                  ),
                ),
              ),
              new SliverFixedExtentList(
                  delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //构建一个测试列表
                      return new Container(
                        alignment: Alignment.center,
                        color: Colors.blueGrey,
                        child: new Text(
                          'SliverFixedExtentList',
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    childCount: 1,
                  ),

                  ///强制孩子在滚动方向上有指定的范围
                  ///指定itemExtent比让孩子确定自己的范围更有效率
                  itemExtent: 200.0),
              new SliverAppBar(
                  //列表在滚动的时候appbar是否一直保持可见
                  pinned: true,
                  expandedHeight: 150.0,
                  //flexibleSpace高度和appbar高度一致
                  //FlexibleSpaceBar:一个灵活空间控制appbar扩展和伸缩
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('SliverAppBar'),
                    //centerTitle值表示:appbar缩回去之后是否居中展示title
                    centerTitle: true,
                    //背景,final Widget background;
                    //我们要使用的Image对象必须是const声明的常量对象,对象不可变
                    background: Image(
                      image: AssetImage("images/lake.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: <Widget>[
                    new IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      tooltip: 'Search',
                      onPressed: () {
                        /* search content */
                      },
                    ),
                  ]),
            ];
          },
          body: new Container(
            height: 200.0,
            color: Colors.blue,
            child: new Center(
              child: new ListView.builder(itemBuilder: (context, index) {
                return new Center(
                  child: new Container(
                    height: 60.0,
                    child: Text('index = $index'),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
