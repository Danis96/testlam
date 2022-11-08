// ignore: constant_identifier_names
/// ApiPath
///
/// helper class in which we define paths that
/// we concatenate to our base url
enum ApiPath {
  get_token,
  user_info,
  user_main_info,
  get_all_news,
  news_by_id,
  upload_image,
  delete_image,
  check_pin,
  change_password,
  logout,
  get_categories,
  get_cities,
  get_merchants,
  get_merchant_address,
  pomozi_ba_donacija,
  set_user_to_donate,
  get_mobile_operators,
  get_refill_amount,
  send_refill,
  get_recipient_info,
  points_sending_number,
  send_points,
  get_user_notifications,
  get_user_purchase_reports,
  set_seen_notification,
  get_awards,
  send_promo_code,
  buy_award,
  award_details,
}

class ApiPathHelper {
  static String getValue(ApiPath path, {String concatValue = '', String secondConcatValue = '', String thirdConcatValue = ''}) {
    switch (path) {
      case ApiPath.get_token:
        return '/token';
      case ApiPath.user_info:
        return '/api/Account/UserInfo';
      case ApiPath.user_main_info:
        return '/api/UserMainInformations';
      case ApiPath.get_all_news:
        return '/api/News?index=$concatValue&size=$secondConcatValue';
      case ApiPath.news_by_id:
        return '/api/News/$concatValue';
      case ApiPath.upload_image:
        return '/api/UserMainInformations/ProfileImage';
      case ApiPath.delete_image:
        return '/api/UserMainInformations/RemoveProfileImage';
      case ApiPath.check_pin:
        return '/api/Account/CheckPin?pin=$concatValue';
      case ApiPath.change_password:
        return '/api/Account/ChangePassword?cardNumber=$concatValue';
      case ApiPath.logout:
        return '/api/Account/Logout?registrationId=$concatValue';
      case ApiPath.get_categories:
        return '/api/SalesLocation/Categories';
      case ApiPath.get_cities:
        return '/api/SalesLocation/Cities';
      case ApiPath.get_merchants:
        return '/api/SalesLocation/Merchants?$concatValue$secondConcatValue&index=$thirdConcatValue&size=10&isLampicaSalesLocation=true';
      case ApiPath.get_merchant_address:
        return '/api/SalesLocation/MerchantSalesLocations?id=$concatValue&index=null&size=null';
      case ApiPath.pomozi_ba_donacija:
        return '/api/Donation';
      case ApiPath.set_user_to_donate:
        return '/api/Donation/SetDonation';
      case ApiPath.get_mobile_operators:
        return '/api/SendSMSTopUp/GetMobileOperators';
      case ApiPath.get_refill_amount:
        return '/api/SendSMSTopUp/GetAmendmentValues';
      case ApiPath.send_refill:
        return '/api/SendSMSTopUp';
      case ApiPath.get_recipient_info:
        return '/api/SendPoints/GetRecipientInfo?cardNo=$concatValue&amount=$secondConcatValue';
      case ApiPath.points_sending_number:
        return '/api/SendPoints/PointsSendingNumber';
      case ApiPath.send_points:
        return '/api/SendPoints';
      case ApiPath.get_user_notifications:
        return '/api/UserMainInformations/GetUserNotifications';
      case ApiPath.get_user_purchase_reports:
        return '/api/UserPurchaseReports?monthNumber=$concatValue&yearNumber=$secondConcatValue&index=$thirdConcatValue&size=30';
      case ApiPath.set_seen_notification:
        return '/api/UserMainInformations/NotificationSeen?id=$concatValue';
      case ApiPath.get_awards:
        return '/api/Awards/List?index=$concatValue&size=100';
      case ApiPath.send_promo_code:
        return '/api/Articles/ArticlesCode';
      case ApiPath.buy_award:
        return '/api/Awards/BuyAward';
      case ApiPath.award_details:
        return '/api/Awards/Details?id=$concatValue';
      default:
        return '';
    }
  }
}
