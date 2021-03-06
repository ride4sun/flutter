// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

import 'rendering_tester.dart';

void main() {
  test('RenderViewport basic test - no children', () {
    final RenderViewport root = new RenderViewport(
      offset: new ViewportOffset.zero(),
    );
    // TODO(jacobr): remove extra trailing line break.
    expect(root, isNot(hasAGoodToStringDeep));
    expect(
      root.toStringDeep(),
      equalsIgnoringHashCodes(
        'RenderViewport#00000 NEEDS-LAYOUT NEEDS-PAINT DETACHED\n'
        ' │ parentData: null\n'
        ' │ constraints: null\n'
        ' │ size: MISSING\n'
        ' │ AxisDirection.down\n'
        ' │ offset: _FixedViewportOffset#da23b(offset: 0.0)\n'
        ' │ anchor: 0.0\n'
        '\n'
      ),
    );
    layout(root);
    root.offset = new ViewportOffset.fixed(900.0);
    // TODO(jacobr): remove extra trailing line break.
    expect(root, isNot(hasAGoodToStringDeep));
    expect(
      root.toStringDeep(),
      equalsIgnoringHashCodes(
        'RenderViewport#00000 NEEDS-LAYOUT NEEDS-PAINT\n'
        ' │ parentData: <none>\n'
        ' │ constraints: BoxConstraints(w=800.0, h=600.0)\n'
        ' │ size: Size(800.0, 600.0)\n'
        ' │ AxisDirection.down\n'
        ' │ offset: _FixedViewportOffset#00000(offset: 900.0)\n'
        ' │ anchor: 0.0\n'
        '\n',
      ),
    );

    pumpFrame();
  });

  test('RenderViewport basic test - down', () {
    RenderBox a, b, c, d, e;
    final RenderViewport root = new RenderViewport(
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(100.0, 400.0))),
      ],
    );
    expect(root, hasAGoodToStringDeep);
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    expect(root, hasAGoodToStringDeep);
    expect(
      root.toStringDeep(),
      equalsIgnoringHashCodes(
        'RenderViewport#00000 NEEDS-PAINT\n'
        ' │ parentData: <none>\n'
        ' │ constraints: BoxConstraints(w=800.0, h=600.0)\n'
        ' │ size: Size(800.0, 600.0)\n'
        ' │ AxisDirection.down\n'
        ' │ offset: _FixedViewportOffset#00000(offset: 0.0)\n'
        ' │ anchor: 0.0\n'
        ' │\n'
        ' ├─center child: RenderSliverToBoxAdapter#00000 relayoutBoundary=up1 NEEDS-PAINT\n'
        ' │ │ parentData: paintOffset=Offset(0.0, 0.0) (can use size)\n'
        ' │ │ constraints: SliverConstraints(AxisDirection.down,\n'
        ' │ │   GrowthDirection.forward, ScrollDirection.idle, scrollOffset:\n'
        ' │ │   0.0, remainingPaintExtent: 600.0, crossAxisExtent: 800.0,\n'
        ' │ │   viewportMainAxisExtent: 600.0)\n'
        ' │ │ geometry: SliverGeometry(scrollExtent: 400.0, paintExtent: 400.0,\n'
        ' │ │   maxPaintExtent: 400.0, )\n'
        ' │ │\n'
        ' │ └─child: RenderSizedBox#00000 NEEDS-PAINT\n'
        ' │     parentData: paintOffset=Offset(0.0, -0.0) (can use size)\n'
        ' │     constraints: BoxConstraints(w=800.0, 0.0<=h<=Infinity)\n'
        ' │     size: Size(800.0, 400.0)\n'
        ' │\n'
        ' ├─child 1: RenderSliverToBoxAdapter#00000 relayoutBoundary=up1 NEEDS-PAINT\n'
        ' │ │ parentData: paintOffset=Offset(0.0, 400.0) (can use size)\n'
        ' │ │ constraints: SliverConstraints(AxisDirection.down,\n'
        ' │ │   GrowthDirection.forward, ScrollDirection.idle, scrollOffset:\n'
        ' │ │   0.0, remainingPaintExtent: 200.0, crossAxisExtent: 800.0,\n'
        ' │ │   viewportMainAxisExtent: 600.0)\n'
        ' │ │ geometry: SliverGeometry(scrollExtent: 400.0, paintExtent: 200.0,\n'
        ' │ │   maxPaintExtent: 400.0, hasVisualOverflow: true, )\n'
        ' │ │\n'
        ' │ └─child: RenderSizedBox#00000 NEEDS-PAINT\n'
        ' │     parentData: paintOffset=Offset(0.0, -0.0) (can use size)\n'
        ' │     constraints: BoxConstraints(w=800.0, 0.0<=h<=Infinity)\n'
        ' │     size: Size(800.0, 400.0)\n'
        ' │\n'
        ' ├─child 2: RenderSliverToBoxAdapter#00000 relayoutBoundary=up1 NEEDS-PAINT\n'
        ' │ │ parentData: paintOffset=Offset(0.0, 600.0) (can use size)\n'
        ' │ │ constraints: SliverConstraints(AxisDirection.down,\n'
        ' │ │   GrowthDirection.forward, ScrollDirection.idle, scrollOffset:\n'
        ' │ │   0.0, remainingPaintExtent: 0.0, crossAxisExtent: 800.0,\n'
        ' │ │   viewportMainAxisExtent: 600.0)\n'
        ' │ │ geometry: SliverGeometry(scrollExtent: 400.0, hidden,\n'
        ' │ │   maxPaintExtent: 400.0, hasVisualOverflow: true, )\n'
        ' │ │\n'
        ' │ └─child: RenderSizedBox#00000 NEEDS-PAINT\n'
        ' │     parentData: paintOffset=Offset(0.0, -0.0) (can use size)\n'
        ' │     constraints: BoxConstraints(w=800.0, 0.0<=h<=Infinity)\n'
        ' │     size: Size(800.0, 400.0)\n'
        ' │\n'
        ' ├─child 3: RenderSliverToBoxAdapter#00000 relayoutBoundary=up1 NEEDS-PAINT\n'
        ' │ │ parentData: paintOffset=Offset(0.0, 600.0) (can use size)\n'
        ' │ │ constraints: SliverConstraints(AxisDirection.down,\n'
        ' │ │   GrowthDirection.forward, ScrollDirection.idle, scrollOffset:\n'
        ' │ │   0.0, remainingPaintExtent: 0.0, crossAxisExtent: 800.0,\n'
        ' │ │   viewportMainAxisExtent: 600.0)\n'
        ' │ │ geometry: SliverGeometry(scrollExtent: 400.0, hidden,\n'
        ' │ │   maxPaintExtent: 400.0, hasVisualOverflow: true, )\n'
        ' │ │\n'
        ' │ └─child: RenderSizedBox#00000 NEEDS-PAINT\n'
        ' │     parentData: paintOffset=Offset(0.0, -0.0) (can use size)\n'
        ' │     constraints: BoxConstraints(w=800.0, 0.0<=h<=Infinity)\n'
        ' │     size: Size(800.0, 400.0)\n'
        ' │\n'
        ' └─child 4: RenderSliverToBoxAdapter#00000 relayoutBoundary=up1 NEEDS-PAINT\n'
        '   │ parentData: paintOffset=Offset(0.0, 600.0) (can use size)\n'
        '   │ constraints: SliverConstraints(AxisDirection.down,\n'
        '   │   GrowthDirection.forward, ScrollDirection.idle, scrollOffset:\n'
        '   │   0.0, remainingPaintExtent: 0.0, crossAxisExtent: 800.0,\n'
        '   │   viewportMainAxisExtent: 600.0)\n'
        '   │ geometry: SliverGeometry(scrollExtent: 400.0, hidden,\n'
        '   │   maxPaintExtent: 400.0, hasVisualOverflow: true, )\n'
        '   │\n'
        '   └─child: RenderSizedBox#00000 NEEDS-PAINT\n'
        '       parentData: paintOffset=Offset(0.0, -0.0) (can use size)\n'
        '       constraints: BoxConstraints(w=800.0, 0.0<=h<=Infinity)\n'
        '       size: Size(800.0, 400.0)\n',
      ),
    );
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 400.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    expect(a.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 400.0));
    expect(b.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 800.0));
    expect(c.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 1000.0));
    expect(d.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 1000.0));
    expect(e.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 1000.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -200.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 200.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -600.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -200.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 200.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -900.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -500.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -100.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 300.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(130.0, 150.0));
    expect(result.path.first.target, equals(c));
  });

  test('RenderViewport basic test - up', () {
    RenderBox a, b, c, d, e;
    final RenderViewport root = new RenderViewport(
      axisDirection: AxisDirection.up,
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(100.0, 400.0))),
      ],
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 200.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -200.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 400.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 800.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 400.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 1100.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 700.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 300.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -100.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(150.0, 350.0));
    expect(result.path.first.target, equals(c));
  });

  Offset _getPaintOrigin(RenderObject render) {
    final Vector3 transformed3 = render.getTransformTo(null).perspectiveTransform(new Vector3(0.0, 0.0, 0.0));
    return new Offset(transformed3.x, transformed3.y);
  }

  test('RenderViewport basic test - right', () {
    RenderBox a, b, c, d, e;
    final RenderViewport root = new RenderViewport(
      axisDirection: AxisDirection.right,
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(400.0, 100.0))),
      ],
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    final RenderSliver sliverA = a.parent;
    final RenderSliver sliverB = b.parent;
    final RenderSliver sliverC = c.parent;
    final RenderSliver sliverD = d.parent;
    final RenderSliver sliverE = e.parent;

    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(400.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));

    expect(_getPaintOrigin(sliverA), const Offset(0.0, 0.0));
    expect(_getPaintOrigin(sliverB), const Offset(400.0, 0.0));
    expect(_getPaintOrigin(sliverC), const Offset(800.0, 0.0));
    expect(_getPaintOrigin(sliverD), const Offset(800.0, 0.0));
    expect(_getPaintOrigin(sliverE), const Offset(800.0, 0.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));

    expect(_getPaintOrigin(sliverA), const Offset(000.0, 0.0));
    expect(_getPaintOrigin(sliverB), const Offset(200.0, 0.0));
    expect(_getPaintOrigin(sliverC), const Offset(600.0, 0.0));
    expect(_getPaintOrigin(sliverD), const Offset(800.0, 0.0));
    expect(_getPaintOrigin(sliverE), const Offset(800.0, 0.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(-600.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));

    expect(_getPaintOrigin(sliverA), const Offset(000.0, 0.0));
    expect(_getPaintOrigin(sliverB), const Offset(000.0, 0.0));
    expect(_getPaintOrigin(sliverC), const Offset(200.0, 0.0));
    expect(_getPaintOrigin(sliverD), const Offset(600.0, 0.0));
    expect(_getPaintOrigin(sliverE), const Offset(800.0, 0.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(-900.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(-500.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(-100.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(300.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(700.0, 0.0));

    expect(_getPaintOrigin(sliverA), const Offset(000.0, 0.0));
    expect(_getPaintOrigin(sliverB), const Offset(000.0, 0.0));
    expect(_getPaintOrigin(sliverC), const Offset(000.0, 0.0));
    expect(_getPaintOrigin(sliverD), const Offset(300.0, 0.0));
    expect(_getPaintOrigin(sliverE), const Offset(700.0, 0.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(150.0, 450.0));
    expect(result.path.first.target, equals(c));
  });

  test('RenderViewport basic test - left', () {
    RenderBox a, b, c, d, e;
    final RenderViewport root = new RenderViewport(
      axisDirection: AxisDirection.left,
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(400.0, 100.0))),
      ],
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(400.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(1000.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(1300.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(900.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(500.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(100.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-300.0, 0.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(550.0, 150.0));
    expect(result.path.first.target, equals(c));
  });

  // TODO(ianh): test anchor
  // TODO(ianh): test center
  // TODO(ianh): test semantics

  test('RenderShrinkWrappingViewport basic test - no children', () {
    final RenderShrinkWrappingViewport root = new RenderShrinkWrappingViewport(
      offset: new ViewportOffset.zero(),
    );
    // TODO(jacobr): remove extra trailing line break.
    expect(root, isNot(hasAGoodToStringDeep));
    layout(root);
    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
  });

  test('RenderShrinkWrappingViewport basic test - down', () {
    RenderBox a, b, c, d, e;
    final RenderShrinkWrappingViewport root = new RenderShrinkWrappingViewport(
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(100.0, 400.0))),
      ],
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 400.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    expect(a.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 400.0));
    expect(b.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 800.0));
    expect(c.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 1000.0));
    expect(d.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 1000.0));
    expect(e.localToGlobal(const Offset(800.0, 400.0)), const Offset(800.0, 1000.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -200.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 200.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -600.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -200.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 200.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -900.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -500.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -100.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 300.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 600.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(130.0, 150.0));
    expect(result.path.first.target, equals(c));
  });

  test('RenderShrinkWrappingViewport basic test - up', () {
    RenderBox a, b, c, d, e;
    final RenderShrinkWrappingViewport root = new RenderShrinkWrappingViewport(
      axisDirection: AxisDirection.up,
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(100.0, 400.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(100.0, 400.0))),
      ],
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 200.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -200.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 400.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 800.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 400.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 1100.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 700.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 300.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -100.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, -400.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(150.0, 350.0));
    expect(result.path.first.target, equals(c));
  });

  test('RenderShrinkWrappingViewport basic test - right', () {
    RenderBox a, b, c, d, e;
    final RenderShrinkWrappingViewport root = new RenderShrinkWrappingViewport(
      axisDirection: AxisDirection.right,
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(400.0, 100.0))),
      ],
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(400.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(-600.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(800.0, 0.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(-900.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(-500.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(-100.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(300.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(700.0, 0.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(150.0, 450.0));
    expect(result.path.first.target, equals(c));
  });

  test('RenderShrinkWrappingViewport basic test - left', () {
    RenderBox a, b, c, d, e;
    final RenderShrinkWrappingViewport root = new RenderShrinkWrappingViewport(
      axisDirection: AxisDirection.left,
      offset: new ViewportOffset.zero(),
      children: <RenderSliver>[
        new RenderSliverToBoxAdapter(child: a = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: b = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: c = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: d = new RenderSizedBox(const Size(400.0, 100.0))),
        new RenderSliverToBoxAdapter(child: e = new RenderSizedBox(const Size(400.0, 100.0))),
      ],
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));

    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(400.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(0.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));

    root.offset = new ViewportOffset.fixed(200.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));

    root.offset = new ViewportOffset.fixed(600.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(1000.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(600.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(200.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(-200.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-400.0, 0.0));

    root.offset = new ViewportOffset.fixed(900.0);
    pumpFrame();
    expect(a.localToGlobal(const Offset(0.0, 0.0)), const Offset(1300.0, 0.0));
    expect(b.localToGlobal(const Offset(0.0, 0.0)), const Offset(900.0, 0.0));
    expect(c.localToGlobal(const Offset(0.0, 0.0)), const Offset(500.0, 0.0));
    expect(d.localToGlobal(const Offset(0.0, 0.0)), const Offset(100.0, 0.0));
    expect(e.localToGlobal(const Offset(0.0, 0.0)), const Offset(-300.0, 0.0));

    final HitTestResult result = new HitTestResult();
    root.hitTest(result, position: const Offset(550.0, 150.0));
    expect(result.path.first.target, equals(c));
  });

  test('RenderShrinkWrappingViewport shrinkwrap test - 1 child', () {
    RenderBox child;
    final RenderBox root = new RenderPositionedBox(
      child: child = new RenderShrinkWrappingViewport(
        axisDirection: AxisDirection.left,
        offset: new ViewportOffset.fixed(200.0),
        children: <RenderSliver>[
          new RenderSliverToBoxAdapter(child: new RenderSizedBox(const Size(400.0, 100.0))),
        ],
      ),
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));
    expect(child.size.width, equals(400.0));
    expect(child.size.height, equals(600.0));
  });

  test('RenderShrinkWrappingViewport shrinkwrap test - 2 children', () {
    RenderBox child;
    final RenderBox root = new RenderPositionedBox(
      child: child = new RenderShrinkWrappingViewport(
        axisDirection: AxisDirection.right,
        offset: new ViewportOffset.fixed(200.0),
        children: <RenderSliver>[
          new RenderSliverToBoxAdapter(child: new RenderSizedBox(const Size(300.0, 100.0))),
          new RenderSliverToBoxAdapter(child: new RenderSizedBox(const Size(150.0, 100.0))),
        ],
      ),
    );
    layout(root);

    expect(root.size.width, equals(800.0));
    expect(root.size.height, equals(600.0));
    expect(child.size.width, equals(450.0));
    expect(child.size.height, equals(600.0));
  });

  test('SliverGeometry toString', () {
    // TODO(jacobr): cleanup the spurious trailing commas from the toString for
    // SliverGeometry.
    expect(
        const SliverGeometry().toString(),
        equals('SliverGeometry(scrollExtent: 0.0, hidden, maxPaintExtent: 0.0, )'));
    expect(
        const SliverGeometry(scrollExtent: 100.0, paintExtent: 50.0, layoutExtent: 20.0, visible: true).toString(),
        equals('SliverGeometry(scrollExtent: 100.0, paintExtent: 50.0, layoutExtent: 20.0, maxPaintExtent: 0.0, )'));
    expect(const SliverGeometry(scrollExtent: 100.0, paintExtent: 0.0, layoutExtent: 20.0).toString(),
        equals('SliverGeometry(scrollExtent: 100.0, hidden, layoutExtent: 20.0, maxPaintExtent: 0.0, )'));
  });
}
