class Apis{

  //Base url
  static const String baseURL = "http://fastfill.developitech.com/api/";

  //  LOGIN
  static const String login = "Login";

  //  USER
  static const String user = "User";
  static const String updateUserProfile = "User/UpdateUserProfile";

  //  OTP
  static const String otpSendCode = "https://d7networks.com/api/verifier/send";
  static const String otpResendCode = "https://d7networks.com/api/verifier/resend";
  static const String otpVerifyCode = "https://d7networks.com/api/verifier/verify";

  // Stations
  static const String station = "station";

  //Companies
  static const String company = "Company";
  static const String allCompanies = "Company/AllCompanies";
  static const String companyByCode = "Company/CompanyByCode";
  static const String companiesByName = "Company/CompaniesByName";
  static const String allCompaniesBranches = "Company/AllCompaniesBranches";
  static const String companyBranches = "Company/CompanyBranches";
  static const String companyBranchByCode = "Company/CompanyBranchByCode";
  static const String companyBranchesByAddress = "Company/CompanyBranchesByAddress";
  static const String addCompanyToFavorite = "Company/AddToFavorite";
  static const String removeCompanyFromFavorite = "Company/RemoveFromFavorite";
  static const String favoriteCompaniesBranches = "Company/FavoriteCompaniesBranches";
  static const String frequentlyVisitedCompaniesBranches = "Company/FrequentlyVisitedCompaniesBranches";

}