import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<T> useFetch<T>(
  Future<T> Function(Dio fetch) fetcher,
) async {
  final fetch = Dio();

  late final T result;

  try {
    result = await fetcher(fetch);
  } catch (error, stackTrace) {
    debugPrint('/// ERROR');
    debugPrint('/// $error');
    debugPrint('/// STACK TRACE');
    debugPrintStack(stackTrace: stackTrace);

    rethrow;
  }

  fetch.close();

  return result;
}
