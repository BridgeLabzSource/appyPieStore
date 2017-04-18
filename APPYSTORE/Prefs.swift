//
//  Prefs.swift
//  APPYSTORE
//
//  Created by gaurav on 14/03/17.
//  Copyright © 2017 MAUJ MOBILE PVT LTD. All rights reserved.
//

import Foundation

class Prefs: AbsPrefs {
    static let APP_INSTALLED_FOR_OPEN_REOPEN_EVENT = "APP_INSTALLED_FOR_OPEN_REOPEN_EVENT"
    
    static let USER_DEVICE_ID = "DEVICEID"
    static let USER_ID = "USERID"
    static let PCP_ID = "PCPID"
    static let CAMPAIGN_ID = "CAMPAIGNID"
    static let USER_AGENT = "USERAGENT"
    static let USER_TYPE = "USERTYPE"
    static let DEVICE_WIDTH = "DEVICEWIDTH"
    static let DEVICE_HEIGHT = "DEVICEHEIGHT"
    static let ANDROID_ID = "ANDROIDID"
    static let CHILD_AGE = "CHILD_AGE"
    static let CHILD_MONTH = "CHILD_MONTH"
    static let IGNORE_CAT_ID = "ignore_cat_id"
    static let CHILD_ID = "CHILD_ID"
    static let CONN_TYPE = "CONN_TYPE"
    static let TINFO = "TINFO"
    static let VISITOR_ID = "VISITOR_ID"
    static let OST = "OST"
    static let USV = "USV"
    static let INCL_AGE = "INCL_AGE"
    static let X_APPY_REG_KEY = "X_APPY_REG_KEY"
    static let APP_VERSION = "APP_VERSION"
    static let APP_VERSION_NAME = "APP_VERSION_NAME"
    static let SESSION_ID = "SESSION_ID"
    static let CHILD_ID_POST_DWNLD = "N_CHILD_ID"
    static let UTM_CAMPAIGN = "UTM_CAMPAIGN"
    static let UTM_SOURCE = "UTM_SOURCE"
    static let UTM_MEDIUM = "UTM_MEDIUM"
    static let UTM_TERM = "UTM_TERM"
    static let UTM_CONTENT = "UTM_CONTENT"
    static let APPY_NEW_USER = "APPY_NEW_USER"
    static let APP_RATED_ALREADY = "APP_RATED_ALREADY"
    static let APP_MSISDN = "APP_MSISDN"
    static let APPY_SUB_KEY = "APPY_SUB_KEY"
    static let FLG_GUEST_LOGIN = "FLG_GUEST_LOGIN"
    static let IS_LOGGED_OUT = "IS_LOGGED_OUT"
    static let IS_SHOW_TRIAL_SUCCESS_POPUP = "IS_SHOW_TRIAL_SUCCESS_POPUP"
    static let IS_SHOW_WEB_SUBSCRIPTION_POPUP = "IS_SHOW_WEB_SUBSCRIPTION_POPUP"
    static let IS_ELIGIBLE_FOR_TRIAL_SUBSCRIPTION = "IS_ELIGIBLE_FOR_TRIAL_SUBSCRIPTION"
    static let TRIAL_MSG_PRICE = "TRIAL_MSG_PRICE"
    static let NUM_WORKSHEET = "NUM_WORKSHEET"
    static let NUM_OF_DAYS_TRIAL = "NUM_DAYS_TRIAL"
    static let IS_VERSION_UPGRADE = "IS_VERSION_UPGRADE"
    static let IS_SHOW_TRIAL_NEW_USER = "IS_SHOW_TRIAL_NEW_USER"
    static let IS_TRIAL_EXPIRED = "IS_TRIAL_EXPIRED"
    static let EXTRACTED_MSISDN = "EXTRACTED_MSISDN"
    static let IS_START_TRIAL_DIALOG_SHOWN = "IS_START_TRIAL_DIALOG_SHOWN"
    static let IS_TRIAL_EXPIRED_DIALOG_SHOWN = "IS_TRIAL_EXPIRED_DIALOG_SHOWN"
    static let ADVERTISING_ID = "ADVERTISING_ID"
    static let LAST_SAVED_SESSION_TIME = "LAST_SAVED_TIME"
    static let ADDRESS_JSON = "ADDRESS_JSON"
    static let COUNT_FOR_ADDRESS_POPUP = "COUNT_FOR_ADDRESS_POPUP"
    static let IS_ADDRESS_UPDATED = "IS_ADDRESS_UPDATED"
    static let VIEW_PLAN_SCREEN = "VIEW_PLAN_SCREEN"
    static let IS_IMG_CACHE_DELETED = "IS_IMG_CACHE_DELETED"
    static let HISTORY_PAGE_FORCE_REFRESH = "HISTORY_PAGE_FORCE_REFRESH"
    static let USER_INFO = "USER_INFO"
    static let IS_INSTALLED = "IS_INSTALLED"
    static let IS_FIRST_APP_OPEN = "isAppInstalled"
    static let SERVER_CONFIG_JSON = "SERVER_CONFIG_JSON"
    static let SERVER_CONFIG_JSON_TIMESTAMP = "SERVER_CONFIG_JSON_TIMESTAMP"
    static let SUBSCRIPTION_VALIDITY_JSON = "SUBSCRIPTION_VALIDITY_JSON"
    static let SEARCH_TAGS = "SEARCH_TAGS"
    static let IS_BACKGROUND_MUSIC_RUNNING = "IS_BACKGROUND_MUSIC_RUNNING"
    static let SKU_SUBS_PRODUCT = "SKU_SUBS_PRODUCT"
    static let IS_APP_IN_FOREGROUND = "IS_APP_IN_FOREGROUND"
    static let IS_SESSION_FOR_OFFER_POPUP = "IS_SESSION_FOR_OFFER_POPUP"
    static let HEARTBEAT_LAST_DATE = "HART_BEAT_LAST_DATE"
    static var instance: Prefs? = nil
    
    override init(preferences: UserDefaults) {
        super.init(preferences: preferences)
    }
    
    static func getInstance() -> Prefs? {
        if Prefs.instance == nil {
            let sp = UserDefaults()
            instance = Prefs(preferences: sp)
        }
        
        return instance
    }
    
    func getUserInfo() -> String? {
        return getString(key: Prefs.USER_INFO, defaultString: nil)
    }
    
    func setUserInfo(value: String) {
        setString(key: Prefs.USER_INFO, value: value)
    }
    
    func setIsFirstAppOpen(value: Bool){
        setBoolean(key: Prefs.IS_FIRST_APP_OPEN, value: true)
    }
    
    func isFirstAppOpen() -> Bool{
        return getBoolean(key: Prefs.IS_FIRST_APP_OPEN)
    }
    
    func isHistoryPageToBeForceRefreshed() -> Bool {
        return getBoolean(key: Prefs.HISTORY_PAGE_FORCE_REFRESH)
    }
    
    func setHistoryPageToBeForceRefreshed(forceRefresh: Bool){
        setBoolean(key: Prefs.HISTORY_PAGE_FORCE_REFRESH, value: forceRefresh)
    }
    
    func setDevice_ID(value: String){
        setString(key: Prefs.USER_DEVICE_ID, value: value)
    }
    
    func getDevice_ID() -> String? {
        return getString(key: Prefs.USER_DEVICE_ID, defaultString: "")
    }
    
    func setUser_ID(value: String){
        setString(key: Prefs.USER_ID, value: value)
    }
    
    func getUser_ID() -> String? {
        return getString(key: Prefs.USER_ID, defaultString: "")
    }
    
    func setPcp_ID(value: String){
        setString(key: Prefs.PCP_ID, value: value)
    }
    
    func getPcp_ID() -> String? {
        return getString(key: Prefs.PCP_ID, defaultString: "")
    }
    
    func setCampaign_ID(value: String){
        setString(key: Prefs.CAMPAIGN_ID, value: value)
    }
    
    func getCampaign_ID() -> String? {
        return getString(key: Prefs.CAMPAIGN_ID, defaultString: "")
    }
    
    func setUser_Agent(value: String){
        setString(key: Prefs.USER_AGENT, value: value)
    }
    
    func getUser_Agent() -> String? {
        return getString(key: Prefs.USER_AGENT, defaultString: "")
    }
    
    func setU_Type(value: String){
        setString(key: Prefs.USER_TYPE, value: value)
    }
    
    func getU_Type() -> String? {
        return getString(key: Prefs.USER_TYPE, defaultString: "")
    }
    
    func setDevice_Width(value: String){
        setString(key: Prefs.DEVICE_WIDTH, value: value)
    }
    
    func getDevice_Width() -> String? {
        return getString(key: Prefs.DEVICE_WIDTH, defaultString: "")
    }
    
    func setDevice_Height(value: String){
        setString(key: Prefs.DEVICE_HEIGHT, value: value)
    }
    
    func getDevice_Height() -> String? {
        return getString(key: Prefs.DEVICE_HEIGHT, defaultString: "")
    }
    
    func setAndroid_ID(value: String){
        setString(key: Prefs.ANDROID_ID, value: value)
    }
    
    func getAndroid_ID() -> String? {
        return getString(key: Prefs.ANDROID_ID, defaultString: "")
    }
    
    func getCHILD_ID() -> String? {
        return Prefs.CHILD_AGE
    }
    
    func setChildAge(value: String){
        setString(key: Prefs.CHILD_AGE, value: value)
    }
    
    func getChildAge() -> String? {
        return getString(key: Prefs.CHILD_AGE, defaultString: "")
    }
    
    func getChildMonth() -> String? {
        return getString(key: Prefs.CHILD_MONTH, defaultString: "")
    }
    
    func setChildMonth(value: String){
        setString(key: Prefs.CHILD_MONTH, value: value)
    }
    
    func setIgnoreCatContentId(value: String){
        setString(key: Prefs.IGNORE_CAT_ID, value: value)
    }
    
    func getIgnoreCatContentId() -> String? {
        return getString(key: Prefs.IGNORE_CAT_ID, defaultString: "")
    }
    
    func setChildId(value: String){
        setString(key: Prefs.CHILD_ID, value: value)
    }
    
    func getChildId() -> String? {
        return getString(key: Prefs.CHILD_ID, defaultString: "")
    }
    
    func setConnType(value: String){
        setString(key: Prefs.CONN_TYPE, value: value)
    }
    
    func getConnType() -> String? {
        return getString(key: Prefs.CONN_TYPE, defaultString: "")
    }
    
    func setTinfo(value: String){
        setString(key: Prefs.TINFO, value: value)
    }
    
    func getTinfo() -> String? {
        return getString(key: Prefs.TINFO, defaultString: "")
    }
    
    func setVisitorId(value: String){
        setString(key: Prefs.VISITOR_ID, value: value)
    }
    
    func getVisitorId() -> String? {
        return getString(key: Prefs.VISITOR_ID, defaultString: "")
    }
    
    func setOst(value: String){
        setString(key: Prefs.OST, value: value)
    }
    
    func getOst() -> String? {
        return getString(key: Prefs.OST, defaultString: "")
    }
    
    func setUsv(value: String){
        setString(key: Prefs.USV, value: value)
    }
    
    func getUsv() -> String? {
        return getString(key: Prefs.USV, defaultString: "")
    }
    
    func setInclAge(value: String){
        setString(key: Prefs.INCL_AGE, value: value)
    }
    
    func getInclAge() -> String? {
        return getString(key: Prefs.INCL_AGE, defaultString: "")
    }
    
    func getGcmRegKey() -> String? {
        return getString(key: Prefs.X_APPY_REG_KEY, defaultString: "")
    }
    
    func setGcmRegKey(value: String){
        setString(key: Prefs.X_APPY_REG_KEY, value: value)
    }
    
    func getAppVersion() -> String? {
        return getString(key: Prefs.APP_VERSION, defaultString: "")
    }
    
    func setAppVersion(value: String){
        setString(key: Prefs.APP_VERSION, value: value)
    }
    
    func getAppVersionName() -> String? {
        return getString(key: Prefs.APP_VERSION_NAME, defaultString: "")
    }
    
    func setAppVersionName(value: String){
        setString(key: Prefs.APP_VERSION_NAME, value: value)
    }
    
    func hasVisitedDashboard() -> Bool{
        return getBoolean(key: Prefs.IS_INSTALLED, defaultBool: false)
    }
    
    func setHasVisitedDashboard(value: Bool){
        setBoolean(key: Prefs.IS_INSTALLED, value: value)
    }
    
    func getSessionId() -> String? {
        return getString(key: Prefs.SESSION_ID, defaultString: "")
    }
    
    func setSessionId(value: String){
        setString(key: Prefs.SESSION_ID, value: value)
    }
    
    func getPostDwnldChildId() -> String? {
        return getString(key: Prefs.CHILD_ID_POST_DWNLD, defaultString: "")
    }
    
    func setPostDwnldChildId(value: String){
        setString(key: Prefs.CHILD_ID_POST_DWNLD, value: value)
    }
    
    func getUtmSource() -> String? {
        return getString(key: Prefs.UTM_SOURCE, defaultString: "")
    }
    
    func setUtmSource(value: String){
        setString(key: Prefs.UTM_SOURCE, value: value)
    }
    
    func getUtmCampaign() -> String? {
        return getString(key: Prefs.UTM_CAMPAIGN, defaultString: "")
    }
    
    func setUtmCampaign(value: String){
        setString(key: Prefs.UTM_CAMPAIGN, value: value)
    }
    
    func getUtmContent() -> String? {
        return getString(key: Prefs.UTM_CONTENT, defaultString: "")
    }
    
    func setUtmContent(value: String){
        setString(key: Prefs.UTM_CONTENT, value: value)
    }
    
    func getUtmMedium() -> String? {
        return getString(key: Prefs.UTM_MEDIUM, defaultString: "")
    }
    
    func setUtmMedium(value: String){
        setString(key: Prefs.UTM_MEDIUM, value: value)
    }
    
    func getUtmTerm() -> String? {
        return getString(key: Prefs.UTM_TERM, defaultString: "")
    }
    
    func setUtmTerm(value: String){
        setString(key: Prefs.UTM_TERM, value: value)
    }
    
    func getAppyNewUser() -> String? {
        return getString(key: Prefs.APPY_NEW_USER, defaultString: "")
    }
    
    func setAppyNewUser(value: String){
        setString(key: Prefs.APPY_NEW_USER, value: value)
    }
    
    func getAppRatedAlready() -> Bool{
        return getBoolean(key: Prefs.APP_RATED_ALREADY, defaultBool: false)
    }
    
    func setAppRatedAlready(value: Bool){
        setBoolean(key: Prefs.APP_RATED_ALREADY, value: value)
    }
    
    func getAppyMsisdn() -> String? {
        return getString(key: Prefs.APP_MSISDN, defaultString: "")
    }
    
    func setAppyMsisdn(value: String){
        setString(key: Prefs.APP_MSISDN, value: value)
    }
    
    func getAppySubKey() -> String? {
        return getString(key: Prefs.APPY_SUB_KEY, defaultString: "")
    }
    
    func setAppySubKey(value: String){
        setString(key: Prefs.APPY_SUB_KEY, value: value)
    }
    
    func getFlgGuestLogin() -> String? {
        return getString(key: Prefs.FLG_GUEST_LOGIN, defaultString: "")
    }
    
    func setFlgGuestLogin(value: String){
        setString(key: Prefs.FLG_GUEST_LOGIN, value: value)
    }
    
    func isUserLoggedOut() -> Bool{
        return getBoolean(key: Prefs.IS_LOGGED_OUT, defaultBool: false)
    }
    
    func setUserLoggedOut(value: Bool){
        setBoolean(key: Prefs.IS_LOGGED_OUT, value: value)
    }
    
    func isShowTrialSuccessPopup() -> Bool{
        return getBoolean(key: Prefs.IS_SHOW_TRIAL_SUCCESS_POPUP, defaultBool: false)
    }
    
    func setIsShowTrialSuccessPopup(value: Bool){
        setBoolean(key: Prefs.IS_SHOW_TRIAL_SUCCESS_POPUP, value: value)
    }
    
    func isShowWebSubscriptionPopup() -> Bool{
        return getBoolean(key: Prefs.IS_SHOW_WEB_SUBSCRIPTION_POPUP, defaultBool: false)
    }
    
    func setShowWebSubscriptionPopup(value: Bool){
        setBoolean(key: Prefs.IS_SHOW_WEB_SUBSCRIPTION_POPUP, value: value)
    }
    
    func isEligibleForTrialSubscription() -> Bool{
        return getBoolean(key: Prefs.IS_ELIGIBLE_FOR_TRIAL_SUBSCRIPTION,defaultBool: false)
    }
    
    func setEligibleForTrialSubscription(value: Bool){
        setBoolean(key: Prefs.IS_ELIGIBLE_FOR_TRIAL_SUBSCRIPTION, value: value)
    }
    
    func getTrialMsgPrice() -> String? {
        return getString(key: Prefs.TRIAL_MSG_PRICE, defaultString: "")
    }
    
    func setTrialMsgPrice(value: String){
        setString(key: Prefs.TRIAL_MSG_PRICE, value: value)
    }
    
    func getNumWorksheet() -> String? {
        return getString(key: Prefs.NUM_WORKSHEET, defaultString: "")
    }
    
    func setNumWorksheet(value: String){
        setString(key: Prefs.NUM_WORKSHEET, value: value)
    }
    
    func isVersionUpgrade() -> Bool{
        return getBoolean(key: Prefs.IS_VERSION_UPGRADE, defaultBool: false)
    }
    
    func setVersionUpgrade(value: Bool){
        setBoolean(key: Prefs.IS_VERSION_UPGRADE, value: value)
    }
    
    func isTrialExpired() -> Bool{
        return getBoolean(key: Prefs.IS_TRIAL_EXPIRED, defaultBool: false)
    }
    
    func setTrialExpired(value: Bool){
        setBoolean(key: Prefs.IS_TRIAL_EXPIRED, value: value)
    }
    
    func isShowTrialNewUser() -> Bool{
        return getBoolean(key: Prefs.IS_SHOW_TRIAL_NEW_USER, defaultBool: false)
    }
    
    func setShowTrialNewUser(value: Bool){
        setBoolean(key: Prefs.IS_SHOW_TRIAL_NEW_USER, value: value)
    }
    
    func setExtractedMsisdn(value: String){
        setString(key: Prefs.EXTRACTED_MSISDN, value: value)
    }
    
    func getExtractedMsisdn() -> String? {
        return getString(key: Prefs.EXTRACTED_MSISDN, defaultString: "")
    }
    
    func setNumOfDaysTrial(value: String){
        setString(key: Prefs.NUM_OF_DAYS_TRIAL, value: value)
    }
    
    func getNumOfDaysTrial() -> String? {
        return getString(key: Prefs.NUM_OF_DAYS_TRIAL, defaultString: "")
    }
    
    func setStartTrialDialogShown(value: Bool){
        setBoolean(key: Prefs.IS_START_TRIAL_DIALOG_SHOWN, value: value)
    }
    
    func isStartTrialDialogShown() -> Bool{
        return getBoolean(key: Prefs.IS_START_TRIAL_DIALOG_SHOWN, defaultBool: false)
    }
    
    func setTrialExpiredDialogShownForUser(value: Bool){
        // to be done
    }
    
    func isTrialExpiredDialogShownForUser() -> Bool{
        // to be done 
        return false
    }
    
    func setRenewalPreExpiryDialogShownForUser(value: Bool){
        // to be done
    }
    
    func isRenewalPreExpiryDialogShownForUser() -> Bool{
        // to be done
        
        return false
    }
    
    func setRenewalPostExpiryDialogShownForUser(value: Bool){
        // to be done
    }
    
    func isRenewalPostExpiryDialogShownForUser() -> Bool{
        // to be donw
        return false
    }
    
    func setAdvertisingId(value: String){
        setString(key: Prefs.ADVERTISING_ID, value: value)
    }
    
    func getAdvertisingId() -> String? {
        return getString(key: Prefs.ADVERTISING_ID, defaultString: "")
    }
    
    func setPreviousDataFetchTime(key: String, value: Int){
        setInt(key: key, value: value)
    }
    
    func getPreviousDataFetchTime(key: String) -> Int {
        return getInt(key: key, defaultInt: 0)
    }
    
    func setOffsetServer(key: String, value: Int){
        setInt(key: key, value: value)
    }
    
    func getOffsetServer(key: String) -> Int{
        return getInt(key: key, defaultInt: 0)
    }
    
    func setTotalContentCount(key: String, value: Int){
        setInt(key: key, value: value)
    }
    
    func getTotalContentCount(key: String) -> Int {
        return getInt(key: key, defaultInt: 0)
    }
    
    static func getLastOpenForUserKey() -> String {
        var userMsisdn: String = "";
        if UserInfo.getInstance().msisdn != nil {
            userMsisdn = UserInfo.getInstance().msisdn!;
        }
        
        return userMsisdn + "_DATE_LAST_APP_FOR_OPEN_USER";
    }
    
    func setLastAppOpenDateForUser(key: String, value: String){
        setString(key: key, value: value)
    }
    
    func getLastAppOpenDateForUser(key: String) -> String? {
        return getString(key: key,defaultString: "2016-12-27");
    }
    
    func setPopupShownCountForOfferSubscriptionForTrialExpiredUser(key: String, value: Int){
        setInt(key: key, value: value)
    }
    
    func getPopupShownCountForOfferSubscriptionForTrialExpiredUser(key: String) -> Int{
        return getInt(key: key, defaultInt: 0)
    }
    
    func getLastSavedSessionTime() -> Int{
        return getInt(key: Prefs.LAST_SAVED_SESSION_TIME, defaultInt: 0)
    }
    
    func setLastSavedSessionTime(value: Int){
        setInt(key: Prefs.LAST_SAVED_SESSION_TIME, value: value)
    }
    
    func setAddressJSON(value: String){
        setString(key: Prefs.ADDRESS_JSON, value: value)
    }
    
    func getAddressJSON() -> String? {
        return getString(key: Prefs.ADDRESS_JSON, defaultString: "")
    }
    
    func setCountForShowingAddressPopup(value: Int){
        setInt(key: Prefs.COUNT_FOR_ADDRESS_POPUP, value: value)
    }
    
    func getCountForShowingAddressPopup() -> Int{
        return getInt(key: Prefs.COUNT_FOR_ADDRESS_POPUP, defaultInt: 0)
    }
    
    func setViewPlanScreen(value: String){
        setString(key: Prefs.VIEW_PLAN_SCREEN, value: value)
    }
    
    func getViewPlanScreen() -> String? {
        return getString(key: Prefs.VIEW_PLAN_SCREEN, defaultString: "")
    }
    
    func setIsImgCacheDeleted(value: Bool){
        setBoolean(key: Prefs.IS_IMG_CACHE_DELETED, value: value)
    }
    
    func isImgCacheDeleted() -> Bool{
        return getBoolean(key: Prefs.IS_IMG_CACHE_DELETED, defaultBool: false)
    }
    
    func setServerConfigJson(value: String){
        setString(key: Prefs.SERVER_CONFIG_JSON, value: value)
    }
    
    func getServerConfigJson() -> String? {
        return getString(key: Prefs.SERVER_CONFIG_JSON, defaultString: "")
    }
    
    func setServerConfigJsonTimestamp(value: String){
        setString(key: Prefs.SERVER_CONFIG_JSON_TIMESTAMP, value: value)
    }
    
    func getServerConfigJsonTimestamp() -> String? {
        return getString(key: Prefs.SERVER_CONFIG_JSON_TIMESTAMP, defaultString: "")
    }
    
    func setSubscriptionValidityJson(value: String){
        setString(key: Prefs.SUBSCRIPTION_VALIDITY_JSON, value: value)
    }
    
    func getSubscriptionValidityJson() -> String? {
        return getString(key: Prefs.SUBSCRIPTION_VALIDITY_JSON, defaultString: "")
    }
    
    func getSearchTags() -> [SearchTagsModel] {
        return getObject(key: Prefs.SEARCH_TAGS) as! [SearchTagsModel]
    }
    
    func setSearchTags(value: [SearchTagsModel]){
        setObject(key: Prefs.SEARCH_TAGS, value: value)
    }
    
    func shouldBgMusicRun() -> Bool{
        return getBoolean(key: Prefs.IS_BACKGROUND_MUSIC_RUNNING, defaultBool: true)
    }
    
    func setShouldBgMusicRun(value: Bool){
        setBoolean(key: Prefs.IS_BACKGROUND_MUSIC_RUNNING, value: value)
    }
    
    func isAppInForeground() -> Bool{
        return getBoolean(key: Prefs.IS_APP_IN_FOREGROUND, defaultBool: true)
    }
    
    func setIsAppInForeground(value: Bool){
        setBoolean(key: Prefs.IS_APP_IN_FOREGROUND, value: value)
    }
    
    func getSkuSubsProduct() -> String? {
        return getString(key: Prefs.SKU_SUBS_PRODUCT, defaultString: nil)
    }
    
    func setSkuSubsProduct(value: String){
        setString(key: Prefs.SKU_SUBS_PRODUCT, value: value)
    }
    
    func setSessionForOfferPopup(value: Bool){
        setBoolean(key: Prefs.IS_SESSION_FOR_OFFER_POPUP, value: value)
    }
    
    func isSessionForOfferPopup() -> Bool{
        return getBoolean(key: Prefs.IS_SESSION_FOR_OFFER_POPUP, defaultBool: false)
    }
    
    func getHeartBeatLastDate() -> Int {
        return getInt(key: Prefs.HEARTBEAT_LAST_DATE, defaultInt: 0)
    }
    
    func setHeartBeatLastDate(value: Int){
        setInt(key: Prefs.HEARTBEAT_LAST_DATE, value: value)
    }
    
    
}
