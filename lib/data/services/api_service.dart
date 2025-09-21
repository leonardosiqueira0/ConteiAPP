import 'package:contei_app/data/services/prefs.dart';
import 'package:contei_app/utils/config.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio()..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.baseUrl = baseUrl;
        options.headers['Content-Type'] = 'application/json';
        options.headers['Authorization'] = 'Bearer ${await Prefs.getString('accessToken')}';
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              try {
                final refreshToken = await Prefs.getString('refreshToken');
                final response = await _dio.post('/Autenticacao/Refresh', data: {'refreshToken': refreshToken});
                final newAccessToken = response.data['accessToken'];
                final newRefreshToken = response.data['refreshToken'];
                Prefs.saveString('accessToken', newAccessToken);
                Prefs.saveString('refreshToken', newRefreshToken);
                e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                return handler.resolve(await _dio.fetch(e.requestOptions));
              } catch (refreshError) {
                await Prefs.deleteAll();
                return handler.reject(e);
              }
            }
            return handler.next(e);
          }
    )
  );

  static Dio get dio => _dio;
}
