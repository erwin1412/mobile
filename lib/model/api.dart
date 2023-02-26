class Api {
  static const _host = 'https://sistemerwin.my.id/apikc';
  static const _hostKeranjang = '$_host/keranjang';
  static const _hostTransactions = '$_host/transactions';
  static const _hostShoes = '$_host/shoes';
  static const _hostUser = '$_host/user';
  static const _hostFavorite = '$_host/favorite';
  static const hostImage = '$_host/images/';

  // Keranjang
  static const addKeranjang = '$_hostKeranjang/add.php';
  static const deleteKeranjang = '$_hostKeranjang/delete.php';
  static const getKeranjang = '$_hostKeranjang/get.php';
  static const updateKeranjang = '$_hostKeranjang/update.php';

  // Transactions
  static const addTransactions = '$_hostTransactions/add.php';
  static const deleteTransactions = '$_hostTransactions/delete.php';
  static const getHistory = '$_hostTransactions/get_history.php';
  static const getTransactions = '$_hostTransactions/get_transactions.php';
  static const setArrived = '$_hostTransactions/set_arrived.php';

  // Shoes
  static const searchShoes = '$_hostShoes/search.php';
  static const getAllShoes = '$_hostShoes/get_all.php';
  static const getPopularShoes = '$_hostShoes/get_new_items.php';

  // User
  static const checkEmail = '$_hostUser/check_email.php';
  static const login = '$_hostUser/login.php';
  static const register = '$_hostUser/register.php';

  // Favorite
  static const addFavorite = '$_hostFavorite/add.php';
  static const checkFavorite = '$_hostFavorite/check.php';
  static const deleteFavorite = '$_hostFavorite/delete.php';
  static const getFavorite = '$_hostFavorite/get.php';
}
