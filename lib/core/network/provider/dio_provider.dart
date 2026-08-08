import 'package:flutter_assessment_task/core/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => DioClient.create());
