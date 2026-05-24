import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/transaction_dto_model.dart';
import 'model/wallet_dto_model.dart';

part 'wallet_service.g.dart';

@RestApi()
abstract class WalletService {
  factory WalletService(Dio dio, {String baseUrl}) = _WalletService;

  @GET('wallet/wallet')
  Future<WalletDtoModel> getWallet();

  @GET('wallet/transactions')
  Future<TransactionResponseDtoModel> getTransactions({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('transaction_type') String? transactionType,
    @Query('sub_plan') String? subPlanId,
    @Query('search') String? search,
    @Query('ordering') String? ordering,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });
}
