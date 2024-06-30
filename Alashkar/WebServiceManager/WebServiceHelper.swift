//
//  WebServiceHelper.swift
//  Somi
//
//  Created by Paras on 24/03/21.
//

import Foundation
import UIKit



//let BASE_URL = "https://ambitious.in.net/Arun/alashkar/index.php/api/"//Local
let BASE_URL = "https://alashkarapp.de/index.php/api/"//Live


struct WsUrl{
    
    static let url_SignUp  = BASE_URL + "signup?"
    static let url_GetVehicle = BASE_URL + "get_vehicle"
    static let url_getUserProfile  = BASE_URL + "get_profile"
    static let url_Login  = BASE_URL + "login"
    static let url_ForgotPassword = BASE_URL + "forgot_password"
    static let url_ContactUs = BASE_URL + "contact_us"
    static let url_AddVehicle = BASE_URL + "add_vehicle"
    static let url_DeleteVehicle = BASE_URL + "vehicle_delete"
    static let url_Privacy = BASE_URL + "page/Privacy"
    static let url_About = BASE_URL + "page/About"
    static let url_UpdateProfile = BASE_URL + "update_profile"
    
    
//    static let url_GetCategory = BASE_URL + "get_category"
//    static let url_GetSubCategory = BASE_URL + "get_sub_category"
//    static let url_getQuestion = BASE_URL + "get_question"
//    static let url_GetEvent = BASE_URL + "get_events"
//    static let url_GetArticle = BASE_URL + "get_article"
//
//    static let url_GetLikedPost = BASE_URL + "get_liked_posts"
//    static let url_LikePost = BASE_URL + "like_post"
//    static let url_DeleteNotification = BASE_URL + "delete_notification"
//    static let url_GetNotofication = BASE_URL + "get_notification"
//    static let url_UpdateAppointment = BASE_URL + "update_appointment"
//    static let url_GetStore = BASE_URL + "get_stores"
//    static let url_GetQuizQuestions = BASE_URL + "get_quiz?category_id="
//    static let url_SubmitQuizAnswers = BASE_URL + "submit_quiz_answer"
//    static let url_GetTopic = BASE_URL + "get_topic"
//    static let url_GetQuizScore = BASE_URL + "get_quiz_score?quiz_code="
//    static let url_SaveInFavouriteSubCategory = BASE_URL + "save_in_favorite?type=sub_category"
//    static let url_SaveInFavouriteTopic = BASE_URL + "save_in_favorite?type=topic"
//    static let url_CategorySuggestion = BASE_URL + "category_suggestion"

}


//Api Header

struct WsHeader {

    //Login

    static let deviceId = "Device-Id"

    static let deviceType = "Device-Type"

    static let deviceTimeZone = "Device-Timezone"

    static let ContentType = "Content-Type"

}



//Api parameters

struct WsParam {

    

    //static let itunesSharedSecret : String = "c736cf14764344a5913c8c1"

    //Signup

    static let dialCode = "dialCode"

    static let contactNumber = "contactNumber"

    static let code = "code"

    static let deviceToken = "deviceToken"

    static let deviceType = "deviceType"

    static let firstName = "firstName"

    static let lastName = "lastName"

    static let email = "email"

    static let driverImage = "driverImage"

    static let isSignup = "isSignup"

    static let licenceImage = "licenceImage"

    static let socialId = "socialId"

    static let socialType = "socialType"

    static let imageUrl = "image_url"

    static let invitationId = "invitationId"

    static let status = "status"

    static let companyId = "companyId"

    static let vehicleId = "vehicleId"

    static let type = "type"

    static let bookingId = "bookingId"

    static let location = "location"

    static let latitude = "latitude"

    static let longitude = "longitude"

    static let currentdate_time = "current_date_time"

}



//Api check for params
struct WsParamsType {
    static let PathVariable = "Path Variable"
    static let QueryParams = "Query Params"
}
