//
//  Generated code. Do not modify.
//  source: tab_bar.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TabBarModel extends $pb.GeneratedMessage {
  factory TabBarModel() => create();
  TabBarModel._() : super();
  factory TabBarModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TabBarModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TabBarModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'com.protos'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'backGroundColor', protoName: 'backGroundColor')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'currentIndex', $pb.PbFieldType.O3, protoName: 'currentIndex')
    ..pc<TabBarItemModel>(3, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: TabBarItemModel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TabBarModel clone() => TabBarModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TabBarModel copyWith(void Function(TabBarModel) updates) => super.copyWith((message) => updates(message as TabBarModel)) as TabBarModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TabBarModel create() => TabBarModel._();
  TabBarModel createEmptyInstance() => create();
  static $pb.PbList<TabBarModel> createRepeated() => $pb.PbList<TabBarModel>();
  @$core.pragma('dart2js:noInline')
  static TabBarModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TabBarModel>(create);
  static TabBarModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get backGroundColor => $_getSZ(0);
  @$pb.TagNumber(1)
  set backGroundColor($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBackGroundColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearBackGroundColor() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get currentIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set currentIndex($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentIndex() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<TabBarItemModel> get items => $_getList(2);
}

class TabBarItemModel extends $pb.GeneratedMessage {
  factory TabBarItemModel() => create();
  TabBarItemModel._() : super();
  factory TabBarItemModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TabBarItemModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TabBarItemModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'com.protos'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOS(2, _omitFieldNames ? '' : 'image')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TabBarItemModel clone() => TabBarItemModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TabBarItemModel copyWith(void Function(TabBarItemModel) updates) => super.copyWith((message) => updates(message as TabBarItemModel)) as TabBarItemModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TabBarItemModel create() => TabBarItemModel._();
  TabBarItemModel createEmptyInstance() => create();
  static $pb.PbList<TabBarItemModel> createRepeated() => $pb.PbList<TabBarItemModel>();
  @$core.pragma('dart2js:noInline')
  static TabBarItemModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TabBarItemModel>(create);
  static TabBarItemModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get image => $_getSZ(1);
  @$pb.TagNumber(2)
  set image($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
