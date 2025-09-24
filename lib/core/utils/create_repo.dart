import '../../features/currency/data/datasources/currency_local_datasource.dart';
import '../../features/currency/data/datasources/currency_remote_datasource.dart';
import '../../features/currency/data/repositories/currency_repository_impl.dart';
import '../../features/currency/domain/repositories/currency_repository.dart';
import '../../features/expense/data/datasources/expense_local_datasource.dart';
import '../../features/expense/data/repositories/expense_repository_impl.dart';
import '../../features/expense/domain/repositories/expense_repository.dart';
import '../network/api_client.dart';

class CreateRepo {

  ExpenseRepository createExpenseRepository() {
    final apiClient = ApiClient();
    final localDataSource = ExpenseLocalDataSourceImpl();
    final currencyRemoteDataSource = CurrencyRemoteDataSourceImpl(apiClient: apiClient);

    return ExpenseRepositoryImpl(
      localDataSource: localDataSource,
      currencyRemoteDataSource: currencyRemoteDataSource,
    );
  }

  CurrencyRepository createCurrencyRepository() {
    final apiClient = ApiClient();
    final localDataSource = CurrencyLocalDataSourceImpl();
    final remoteDataSource = CurrencyRemoteDataSourceImpl(apiClient: apiClient);

    return CurrencyRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );
  }
}