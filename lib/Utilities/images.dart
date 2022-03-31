

class AppImage{
  static String getPath(String name){
    switch(name){
      case "logo": {
        return "assets/images/logo.webp";
      }
      case "splash_bottom": {
        return "assets/images/splash_bottom.webp";
      }
      case "splash_top": {
        return "assets/images/splash_top.webp";
      }
      case "getStart_top": {
        return "assets/images/getStart_top.png";
      }
      case "user": {
        return "assets/images/user.webp";
      }
      case "users": {
        return "assets/images/users.webp";
      }
      case "history": {
        return "assets/images/history.webp";
      }
      default : {
        return "assets/images/logo.webp";
      }
    }
  }
}



class AppSvg{
  static String getPath(String name){
    switch(name){
      case "logo": {
        return "assets/svgs/logo.svg";
      }
      case "rate": {
        return "assets/svgs/rate.svg";
      }
      case "transfer": {
        return "assets/svgs/transfer.svg";
      }
      case "amount_to_send": {
        return "assets/svgs/amount_to_send.svg";
      }
      case "Amount_to_receive": {
        return "assets/svgs/Amount_to_receive.svg";
      }
      case "successful": {
        return "assets/svgs/successful.svg";
      }
      default: {
        return "assets/svgs/logo.svg";
      }
    }
  }
}

