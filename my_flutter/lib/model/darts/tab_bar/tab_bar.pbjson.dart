///
//  Generated code. Do not modify.
//  source: tab_bar.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use tabBarModelDescriptor instead')
const TabBarModel$json = const {
  '1': 'TabBarModel',
  '2': const [
    const {'1': 'backGroundColor', '3': 1, '4': 1, '5': 9, '10': 'backGroundColor'},
    const {'1': 'currentIndex', '3': 2, '4': 1, '5': 5, '10': 'currentIndex'},
    const {'1': 'items', '3': 3, '4': 3, '5': 11, '6': '.com.protos.TabBarItemModel', '10': 'items'},
  ],
};

/// Descriptor for `TabBarModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tabBarModelDescriptor = $convert.base64Decode('CgtUYWJCYXJNb2RlbBIoCg9iYWNrR3JvdW5kQ29sb3IYASABKAlSD2JhY2tHcm91bmRDb2xvchIiCgxjdXJyZW50SW5kZXgYAiABKAVSDGN1cnJlbnRJbmRleBIxCgVpdGVtcxgDIAMoCzIbLmNvbS5wcm90b3MuVGFiQmFySXRlbU1vZGVsUgVpdGVtcw==');
@$core.Deprecated('Use tabBarItemModelDescriptor instead')
const TabBarItemModel$json = const {
  '1': 'TabBarItemModel',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'image', '3': 2, '4': 1, '5': 9, '10': 'image'},
  ],
};

/// Descriptor for `TabBarItemModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tabBarItemModelDescriptor = $convert.base64Decode('Cg9UYWJCYXJJdGVtTW9kZWwSFAoFdGl0bGUYASABKAlSBXRpdGxlEhQKBWltYWdlGAIgASgJUgVpbWFnZQ==');
