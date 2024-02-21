import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';
import 'package:logger/logger.dart';

class Storage {
  final refreshtime = const Duration(minutes: 2);
  Future<void> uploadUserProfile({
    required List<int> bytes,
    required String key,
    required String contentType,
  }) async {
    try {
      //Grab Bytes and upload data
      final result = await Amplify.Storage.uploadData(
        options: const StorageUploadDataOptions(
            pluginOptions: S3UploadDataPluginOptions(getProperties: true),
            accessLevel: StorageAccessLevel.protected),
        data: S3DataPayload.bytes(
          bytes,
          contentType: contentType,
        ),
        key: key,
      ).result;

      safePrint('Uploaded Profile Image: ${result.uploadedItem.key}');
    } on StorageException catch (e) {
      safePrint('Error uploading data: ${e.message}');
      rethrow;
    }
  }
}
