///
//  Generated code. Do not modify.
//  source: tab_bar.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TabBarModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TabBarModel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'com.protos'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'backGroundColor', protoName: 'backGroundColor')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentIndex', $pb.PbFieldType.O3, protoName: 'currentIndex')
    ..pc<TabBarItemModel>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: TabBarItemModel.create)
    ..hasRequiredFields = false
  ;

  TabBarModel._() : super();
  factory TabBarModel({
    $core.String backGroundColor,
    $core.int currentIndex,
    $core.Iterable<TabBarItemModel> items,
  }) {
    final _result = create();
    if (backGroundColor != null) {
      _result.backGroundColor = backGroundColor;
    }
    if (currentIndex != null) {
      _result.currentIndex = currentIndex;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory TabBarModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TabBarModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  factory TabBarModel.fromJsonObject($core.Object o) => create()..mergeFromProto3Json(o, ignoreUnknownFields: true);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TabBarModel clone() => TabBarModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TabBarModel copyWith(void Function(TabBarModel) updates) => super.copyWith((message) => updates(message as TabBarModel)) as TabBarModel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TabBarModel create() => TabBarModel._();
  TabBarModel createEmptyInstance() => create();
  static $pb.PbList<TabBarModel> createRepeated() => $pb.PbList<TabBarModel>();
  @$core.pragma('dart2js:noInline')
  static TabBarModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TabBarModel>(create);
  static TabBarModel _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get backGroundColor => $_getSZ(0);
  @$pb.TagNumber(1)
  set backGroundColor($core.String v) { if (v == null) return;$_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBackGroundColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearBackGroundColor() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get currentIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set currentIndex($core.int v) { if (v == null) return;$_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<TabBarItemModel> get items => $_getList(2);
}

class TabBarItemModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TabBarItemModel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'com.protos'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image')
    ..hasRequiredFields = false
  ;

  TabBarItemModel._() : super();
  factory TabBarItemModel({
    $core.String title,
    $core.String image,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (image != null) {
      _result.image = image;
    }
    return _result;
  }
  factory TabBarItemModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TabBarItemModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  factory TabBarItemModel.fromJsonObject($core.Object o) => create()..mergeFromProto3Json(o, ignoreUnknownFields: true);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TabBarItemModel clone() => TabBarItemModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TabBarItemModel copyWith(void Function(TabBarItemModel) updates) => super.copyWith((message) => updates(message as TabBarItemModel)) as TabBarItemModel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TabBarItemModel create() => TabBarItemModel._();
  TabBarItemModel createEmptyInstance() => create();
  static $pb.PbList<TabBarItemModel> createRepeated() => $pb.PbList<TabBarItemModel>();
  @$core.pragma('dart2js:noInline')
  static TabBarItemModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TabBarItemModel>(create);
  static TabBarItemModel _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { if (v == null) return;$_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get image => $_getSZ(1);
  @$pb.TagNumber(2)
  set image($core.String v) { if (v == null) return;$_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => clearField(2);
}

