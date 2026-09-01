// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// ``
  String get appName {
    return Intl.message('', name: 'appName', desc: '', args: []);
  }

  /// ``
  String get companyName {
    return Intl.message('', name: 'companyName', desc: '', args: []);
  }

  /// ``
  String get appSubtitle {
    return Intl.message('', name: 'appSubtitle', desc: '', args: []);
  }

  /// ``
  String get loginToSystem {
    return Intl.message('', name: 'loginToSystem', desc: '', args: []);
  }

  /// ``
  String get enterPhoneNumber {
    return Intl.message('', name: 'enterPhoneNumber', desc: '', args: []);
  }

  /// ``
  String get phoneNumberHint {
    return Intl.message('', name: 'phoneNumberHint', desc: '', args: []);
  }

  /// ``
  String get getOtpCode {
    return Intl.message('', name: 'getOtpCode', desc: '', args: []);
  }

  /// ``
  String get enterOtpCode {
    return Intl.message('', name: 'enterOtpCode', desc: '', args: []);
  }

  /// ``
  String otpSentTo(String phoneNumber) {
    return Intl.message('', name: 'otpSentTo', desc: '', args: [phoneNumber]);
  }

  /// ``
  String get sendViaRubika {
    return Intl.message('', name: 'sendViaRubika', desc: '', args: []);
  }

  /// ``
  String get resendSms {
    return Intl.message('', name: 'resendSms', desc: '', args: []);
  }

  /// ``
  String get confirm {
    return Intl.message('', name: 'confirm', desc: '', args: []);
  }

  /// ``
  String get otpResent {
    return Intl.message('', name: 'otpResent', desc: '', args: []);
  }

  /// ``
  String get releaseFactor {
    return Intl.message('', name: 'releaseFactor', desc: '', args: []);
  }

  /// ``
  String get dashboard {
    return Intl.message('', name: 'dashboard', desc: '', args: []);
  }

  /// ``
  String get products {
    return Intl.message('', name: 'products', desc: '', args: []);
  }

  /// ``
  String get orders {
    return Intl.message('', name: 'orders', desc: '', args: []);
  }

  /// ``
  String get profile {
    return Intl.message('', name: 'profile', desc: '', args: []);
  }

  /// ``
  String get dailySalesChart {
    return Intl.message('', name: 'dailySalesChart', desc: '', args: []);
  }

  /// ``
  String get currentMonth {
    return Intl.message('', name: 'currentMonth', desc: '', args: []);
  }

  /// ``
  String get lastMonth {
    return Intl.message('', name: 'lastMonth', desc: '', args: []);
  }

  /// ``
  String get recentOrdersHeader {
    return Intl.message('', name: 'recentOrdersHeader', desc: '', args: []);
  }

  /// ``
  String get statusApproved {
    return Intl.message('', name: 'statusApproved', desc: '', args: []);
  }

  /// ``
  String get statusRejected {
    return Intl.message('', name: 'statusRejected', desc: '', args: []);
  }

  /// ``
  String get statusPending {
    return Intl.message('', name: 'statusPending', desc: '', args: []);
  }

  /// ``
  String get statusWaitingSettlement {
    return Intl.message(
      '',
      name: 'statusWaitingSettlement',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get statusExpired {
    return Intl.message('', name: 'statusExpired', desc: '', args: []);
  }

  /// ``
  String get myCustomers {
    return Intl.message('', name: 'myCustomers', desc: '', args: []);
  }

  /// ``
  String get totalBalance {
    return Intl.message('', name: 'totalBalance', desc: '', args: []);
  }

  /// ``
  String get totalCredit {
    return Intl.message('', name: 'totalCredit', desc: '', args: []);
  }

  /// ``
  String get remainingCredit {
    return Intl.message('', name: 'remainingCredit', desc: '', args: []);
  }

  /// ``
  String get brand {
    return Intl.message('', name: 'brand', desc: '', args: []);
  }

  /// ``
  String get brandFilter {
    return Intl.message('', name: 'brandFilter', desc: '', args: []);
  }

  /// ``
  String get myPockets {
    return Intl.message('', name: 'myPockets', desc: '', args: []);
  }

  /// ``
  String get wallet {
    return Intl.message('', name: 'wallet', desc: '', args: []);
  }

  /// `{count}`
  String pocketsCount(int count) {
    return Intl.message(
      '$count',
      name: 'pocketsCount',
      desc: '',
      args: [count],
    );
  }

  /// ``
  String get balance {
    return Intl.message('', name: 'balance', desc: '', args: []);
  }

  /// `{name}`
  String pocketName(String name) {
    return Intl.message('$name', name: 'pocketName', desc: '', args: [name]);
  }

  /// ``
  String get transactionType {
    return Intl.message('', name: 'transactionType', desc: '', args: []);
  }

  /// ``
  String get registrationDate {
    return Intl.message('', name: 'registrationDate', desc: '', args: []);
  }

  /// ``
  String get amount {
    return Intl.message('', name: 'amount', desc: '', args: []);
  }

  /// ``
  String get withdrawalFrom {
    return Intl.message('', name: 'withdrawalFrom', desc: '', args: []);
  }

  /// ``
  String get depositTo {
    return Intl.message('', name: 'depositTo', desc: '', args: []);
  }

  /// ``
  String get trackingNumber {
    return Intl.message('', name: 'trackingNumber', desc: '', args: []);
  }

  /// ``
  String get share {
    return Intl.message('', name: 'share', desc: '', args: []);
  }

  /// ``
  String get transactionDetails {
    return Intl.message('', name: 'transactionDetails', desc: '', args: []);
  }

  /// ``
  String get deposit {
    return Intl.message('', name: 'deposit', desc: '', args: []);
  }

  /// ``
  String get withdrawal {
    return Intl.message('', name: 'withdrawal', desc: '', args: []);
  }

  /// ``
  String get phoneNumber {
    return Intl.message('', name: 'phoneNumber', desc: '', args: []);
  }

  /// ``
  String get nationalId {
    return Intl.message('', name: 'nationalId', desc: '', args: []);
  }

  /// ``
  String get legalId {
    return Intl.message('', name: 'legalId', desc: '', args: []);
  }

  /// ``
  String get naturalAgent {
    return Intl.message('', name: 'naturalAgent', desc: '', args: []);
  }

  /// ``
  String get legalAgent {
    return Intl.message('', name: 'legalAgent', desc: '', args: []);
  }

  /// ``
  String get email {
    return Intl.message('', name: 'email', desc: '', args: []);
  }

  /// ``
  String get agencyCode {
    return Intl.message('', name: 'agencyCode', desc: '', args: []);
  }

  /// `Store Name *`
  String get storeName {
    return Intl.message('Store Name *', name: 'storeName', desc: '', args: []);
  }

  /// ``
  String get workshopCode {
    return Intl.message('', name: 'workshopCode', desc: '', args: []);
  }

  /// ``
  String get province {
    return Intl.message('', name: 'province', desc: '', args: []);
  }

  /// ``
  String get city {
    return Intl.message('', name: 'city', desc: '', args: []);
  }

  /// ``
  String get address {
    return Intl.message('', name: 'address', desc: '', args: []);
  }

  /// ``
  String get creditLimit {
    return Intl.message('', name: 'creditLimit', desc: '', args: []);
  }

  /// ``
  String get regionalManager {
    return Intl.message('', name: 'regionalManager', desc: '', args: []);
  }

  /// ``
  String get creditLimitHelper {
    return Intl.message('', name: 'creditLimitHelper', desc: '', args: []);
  }

  /// ``
  String get searchProducts {
    return Intl.message('', name: 'searchProducts', desc: '', args: []);
  }

  /// ``
  String get customerInfo {
    return Intl.message('', name: 'customerInfo', desc: '', args: []);
  }

  /// ``
  String get customerName {
    return Intl.message('', name: 'customerName', desc: '', args: []);
  }

  /// ``
  String get postalCode {
    return Intl.message('', name: 'postalCode', desc: '', args: []);
  }

  /// ``
  String get search {
    return Intl.message('', name: 'search', desc: '', args: []);
  }

  /// ``
  String get customerDetails {
    return Intl.message('', name: 'customerDetails', desc: '', args: []);
  }

  /// ``
  String get preInvoice {
    return Intl.message('', name: 'preInvoice', desc: '', args: []);
  }

  /// ``
  String get productDetail {
    return Intl.message('', name: 'productDetail', desc: '', args: []);
  }

  /// ``
  String get technicalSpecs {
    return Intl.message('', name: 'technicalSpecs', desc: '', args: []);
  }

  /// ``
  String get description {
    return Intl.message('', name: 'description', desc: '', args: []);
  }

  /// ``
  String get creditPlanTitle {
    return Intl.message('', name: 'creditPlanTitle', desc: '', args: []);
  }

  /// ``
  String get uploadedDocumentsTitle {
    return Intl.message('', name: 'uploadedDocumentsTitle', desc: '', args: []);
  }

  /// ``
  String get noPlanSelected {
    return Intl.message('', name: 'noPlanSelected', desc: '', args: []);
  }

  /// ``
  String get providerLabel {
    return Intl.message('', name: 'providerLabel', desc: '', args: []);
  }

  /// ``
  String get planNameLabel {
    return Intl.message('', name: 'planNameLabel', desc: '', args: []);
  }

  /// ``
  String get priceIncreaseLabel {
    return Intl.message('', name: 'priceIncreaseLabel', desc: '', args: []);
  }

  /// ``
  String get validityPeriodLabel {
    return Intl.message('', name: 'validityPeriodLabel', desc: '', args: []);
  }

  /// ``
  String get nameLabel {
    return Intl.message('', name: 'nameLabel', desc: '', args: []);
  }

  /// ``
  String get nameLabelWithStar {
    return Intl.message('', name: 'nameLabelWithStar', desc: '', args: []);
  }

  /// ``
  String get phoneNumberLabel {
    return Intl.message('', name: 'phoneNumberLabel', desc: '', args: []);
  }

  /// ``
  String get phoneNumberLabelWithStar {
    return Intl.message(
      '',
      name: 'phoneNumberLabelWithStar',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get searchInProducts {
    return Intl.message('', name: 'searchInProducts', desc: '', args: []);
  }

  /// ``
  String get logOutHint {
    return Intl.message('', name: 'logOutHint', desc: '', args: []);
  }

  /// ``
  String get imageLoadError {
    return Intl.message('', name: 'imageLoadError', desc: '', args: []);
  }

  /// ``
  String get orderDetail {
    return Intl.message('', name: 'orderDetail', desc: '', args: []);
  }

  /// ``
  String get orderFinancialDetail {
    return Intl.message('', name: 'orderFinancialDetail', desc: '', args: []);
  }

  /// ``
  String get history {
    return Intl.message('', name: 'history', desc: '', args: []);
  }

  /// ``
  String get historyPayment {
    return Intl.message('', name: 'historyPayment', desc: '', args: []);
  }

  /// ``
  String get nationalCodeLabel {
    return Intl.message('', name: 'nationalCodeLabel', desc: '', args: []);
  }

  /// ``
  String get postalCodeLabel {
    return Intl.message('', name: 'postalCodeLabel', desc: '', args: []);
  }

  /// ``
  String get postalCodeLabelWithStar {
    return Intl.message(
      '',
      name: 'postalCodeLabelWithStar',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get addressLabel {
    return Intl.message('', name: 'addressLabel', desc: '', args: []);
  }

  /// ``
  String get financialSummaryTitle {
    return Intl.message('', name: 'financialSummaryTitle', desc: '', args: []);
  }

  /// ``
  String get dischargeAndSettlement {
    return Intl.message('', name: 'dischargeAndSettlement', desc: '', args: []);
  }

  /// ``
  String get finalFactorAmount {
    return Intl.message('', name: 'finalFactorAmount', desc: '', args: []);
  }

  /// ``
  String get totalBasePrice {
    return Intl.message('', name: 'totalBasePrice', desc: '', args: []);
  }

  /// ``
  String get totalDiscounts {
    return Intl.message('', name: 'totalDiscounts', desc: '', args: []);
  }

  /// ``
  String get settlementMethod {
    return Intl.message('', name: 'settlementMethod', desc: '', args: []);
  }

  /// ``
  String get walletSettlement {
    return Intl.message('', name: 'walletSettlement', desc: '', args: []);
  }

  /// ``
  String get differenceAmount {
    return Intl.message('', name: 'differenceAmount', desc: '', args: []);
  }

  /// `Balance of {walletName} wallet is sufficient for payment`
  String walletBalanceSufficient(Object walletName) {
    return Intl.message(
      'Balance of $walletName wallet is sufficient for payment',
      name: 'walletBalanceSufficient',
      desc: '',
      args: [walletName],
    );
  }

  /// `Balance of {walletName} wallet is not sufficient for payment`
  String walletBalanceInsufficient(Object walletName) {
    return Intl.message(
      'Balance of $walletName wallet is not sufficient for payment',
      name: 'walletBalanceInsufficient',
      desc: '',
      args: [walletName],
    );
  }

  /// `Payment link sent to {phoneNumber}`
  String paymentLinkSentTo(Object phoneNumber) {
    return Intl.message(
      'Payment link sent to $phoneNumber',
      name: 'paymentLinkSentTo',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `Settlement Amount`
  String get settlementAmountLabel {
    return Intl.message(
      'Settlement Amount',
      name: 'settlementAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Resend payment link`
  String get resendPaymentLink {
    return Intl.message(
      'Resend payment link',
      name: 'resendPaymentLink',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get payWithWallet {
    return Intl.message('', name: 'payWithWallet', desc: '', args: []);
  }

  /// ``
  String get selectCreditPlan {
    return Intl.message('', name: 'selectCreditPlan', desc: '', args: []);
  }

  /// ``
  String get selectProducts {
    return Intl.message('', name: 'selectProducts', desc: '', args: []);
  }

  /// ``
  String get uploadDocuments {
    return Intl.message('', name: 'uploadDocuments', desc: '', args: []);
  }

  /// ``
  String get reviewAndSubmit {
    return Intl.message('', name: 'reviewAndSubmit', desc: '', args: []);
  }

  /// ``
  String get nextStep {
    return Intl.message('', name: 'nextStep', desc: '', args: []);
  }

  /// ``
  String get searchHint {
    return Intl.message('', name: 'searchHint', desc: '', args: []);
  }

  /// ``
  String get productsFound {
    return Intl.message('', name: 'productsFound', desc: '', args: []);
  }

  /// ``
  String get nationalCodeHint {
    return Intl.message('', name: 'nationalCodeHint', desc: '', args: []);
  }

  /// ``
  String get checkButton {
    return Intl.message('', name: 'checkButton', desc: '', args: []);
  }

  /// ``
  String get lastNameLabel {
    return Intl.message('', name: 'lastNameLabel', desc: '', args: []);
  }

  /// ``
  String get lastNameLabelWithStar {
    return Intl.message('', name: 'lastNameLabelWithStar', desc: '', args: []);
  }

  /// ``
  String get fullAddressLabel {
    return Intl.message('', name: 'fullAddressLabel', desc: '', args: []);
  }

  /// ``
  String get fullAddressLabelWithStar {
    return Intl.message(
      '',
      name: 'fullAddressLabelWithStar',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get sendOrderToCustomerAddress {
    return Intl.message(
      '',
      name: 'sendOrderToCustomerAddress',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get inactive {
    return Intl.message('', name: 'inactive', desc: '', args: []);
  }

  /// ``
  String get active {
    return Intl.message('', name: 'active', desc: '', args: []);
  }

  /// ``
  String get mandatoryDocument {
    return Intl.message('', name: 'mandatoryDocument', desc: '', args: []);
  }

  /// ``
  String get nationalCardFront {
    return Intl.message('', name: 'nationalCardFront', desc: '', args: []);
  }

  /// ``
  String get optionalDocuments {
    return Intl.message('', name: 'optionalDocuments', desc: '', args: []);
  }

  /// ``
  String get clickToUpload {
    return Intl.message('', name: 'clickToUpload', desc: '', args: []);
  }

  /// ``
  String get uploadFormatInfo {
    return Intl.message('', name: 'uploadFormatInfo', desc: '', args: []);
  }

  /// ``
  String get add {
    return Intl.message('', name: 'add', desc: '', args: []);
  }

  /// `{index}`
  String otherDocumentsLabel(int index) {
    return Intl.message(
      '$index',
      name: 'otherDocumentsLabel',
      desc: '',
      args: [index],
    );
  }

  /// ``
  String get submitAndClearCart {
    return Intl.message('', name: 'submitAndClearCart', desc: '', args: []);
  }

  /// ``
  String get submitPreInvoice {
    return Intl.message('', name: 'submitPreInvoice', desc: '', args: []);
  }

  /// ``
  String get cartTitle {
    return Intl.message('', name: 'cartTitle', desc: '', args: []);
  }

  /// ``
  String get customerInfoTitle {
    return Intl.message('', name: 'customerInfoTitle', desc: '', args: []);
  }

  /// ``
  String get payableAmount {
    return Intl.message('', name: 'payableAmount', desc: '', args: []);
  }

  /// ``
  String get productsTitle {
    return Intl.message('', name: 'productsTitle', desc: '', args: []);
  }

  /// ``
  String get totalAmount {
    return Intl.message('', name: 'totalAmount', desc: '', args: []);
  }

  /// ``
  String get statusDone {
    return Intl.message('', name: 'statusDone', desc: '', args: []);
  }

  /// ``
  String get statusFailed {
    return Intl.message('', name: 'statusFailed', desc: '', args: []);
  }

  /// ``
  String get failed {
    return Intl.message('', name: 'failed', desc: '', args: []);
  }

  /// ``
  String get noItemsFound {
    return Intl.message('', name: 'noItemsFound', desc: '', args: []);
  }

  /// ``
  String get walletReceiptTitle {
    return Intl.message('', name: 'walletReceiptTitle', desc: '', args: []);
  }

  /// ``
  String get selectTransactionTypeSubtitle {
    return Intl.message(
      '',
      name: 'selectTransactionTypeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get unknown {
    return Intl.message('', name: 'unknown', desc: '', args: []);
  }

  /// ``
  String itemCount(int count) {
    return Intl.message('', name: 'itemCount', desc: '', args: [count]);
  }

  /// ``
  String get dayUnit {
    return Intl.message('', name: 'dayUnit', desc: '', args: []);
  }

  /// ``
  String get hourUnit {
    return Intl.message('', name: 'hourUnit', desc: '', args: []);
  }

  /// ``
  String get minuteUnit {
    return Intl.message('', name: 'minuteUnit', desc: '', args: []);
  }

  /// ``
  String get monthUnit {
    return Intl.message('', name: 'monthUnit', desc: '', args: []);
  }

  /// ``
  String get registrationDateLabel {
    return Intl.message('', name: 'registrationDateLabel', desc: '', args: []);
  }

  /// ``
  String get clearanceDateLabelColon {
    return Intl.message(
      '',
      name: 'clearanceDateLabelColon',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get settlementDateLabel {
    return Intl.message('', name: 'settlementDateLabel', desc: '', args: []);
  }

  /// ``
  String get success {
    return Intl.message('', name: 'success', desc: '', args: []);
  }

  /// ``
  String get nationalIdFront {
    return Intl.message('', name: 'nationalIdFront', desc: '', args: []);
  }

  /// ``
  String get otherDocuments {
    return Intl.message('', name: 'otherDocuments', desc: '', args: []);
  }

  /// ``
  String get preInvoiceValidityDuration {
    return Intl.message(
      '',
      name: 'preInvoiceValidityDuration',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get nationalCodeLabelWithStar {
    return Intl.message(
      '',
      name: 'nationalCodeLabelWithStar',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get nationalIdWrong {
    return Intl.message('', name: 'nationalIdWrong', desc: '', args: []);
  }

  /// ``
  String get postalCodeWrong {
    return Intl.message('', name: 'postalCodeWrong', desc: '', args: []);
  }

  /// ``
  String get editProductsTitle {
    return Intl.message('', name: 'editProductsTitle', desc: '', args: []);
  }

  /// ``
  String get editCustomerInfoTitle {
    return Intl.message('', name: 'editCustomerInfoTitle', desc: '', args: []);
  }

  /// ``
  String get editDocumentsTitle {
    return Intl.message('', name: 'editDocumentsTitle', desc: '', args: []);
  }

  /// ``
  String get save {
    return Intl.message('', name: 'save', desc: '', args: []);
  }

  /// ``
  String get back {
    return Intl.message('', name: 'back', desc: '', args: []);
  }

  /// ``
  String get clearFilter {
    return Intl.message('', name: 'clearFilter', desc: '', args: []);
  }

  /// ``
  String get applyFilter {
    return Intl.message('', name: 'applyFilter', desc: '', args: []);
  }

  /// ``
  String get categoryFilterSubtitle {
    return Intl.message('', name: 'categoryFilterSubtitle', desc: '', args: []);
  }

  /// ``
  String get planFilterSubtitle {
    return Intl.message('', name: 'planFilterSubtitle', desc: '', args: []);
  }

  /// ``
  String get categoryTitle {
    return Intl.message('', name: 'categoryTitle', desc: '', args: []);
  }

  /// ``
  String get planTitle {
    return Intl.message('', name: 'planTitle', desc: '', args: []);
  }

  /// ``
  String get finalFactorAmountLabel {
    return Intl.message('', name: 'finalFactorAmountLabel', desc: '', args: []);
  }

  /// ``
  String get enterClearanceAmountHint {
    return Intl.message(
      '',
      name: 'enterClearanceAmountHint',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get clearanceOtpTitle {
    return Intl.message('', name: 'clearanceOtpTitle', desc: '', args: []);
  }

  /// `{phoneNumber}`
  String otpSentToPhone(String phoneNumber) {
    return Intl.message(
      '$phoneNumber',
      name: 'otpSentToPhone',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// ``
  String get confirmAndClearance {
    return Intl.message('', name: 'confirmAndClearance', desc: '', args: []);
  }

  /// ``
  String get cancel {
    return Intl.message('', name: 'cancel', desc: '', args: []);
  }

  /// ``
  String get clearanceDocumentsTitle {
    return Intl.message(
      '',
      name: 'clearanceDocumentsTitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get uploadClearanceInstruction {
    return Intl.message(
      '',
      name: 'uploadClearanceInstruction',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get paymentDocuments {
    return Intl.message('', name: 'paymentDocuments', desc: '', args: []);
  }

  /// ``
  String get confirmAndSend {
    return Intl.message('', name: 'confirmAndSend', desc: '', args: []);
  }

  /// ``
  String get clearanceAmountLabel {
    return Intl.message('', name: 'clearanceAmountLabel', desc: '', args: []);
  }

  /// ``
  String get clearanceOperations {
    return Intl.message('', name: 'clearanceOperations', desc: '', args: []);
  }

  /// ``
  String get uploadClearanceDocuments {
    return Intl.message(
      '',
      name: 'uploadClearanceDocuments',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get uploaded {
    return Intl.message('', name: 'uploaded', desc: '', args: []);
  }

  /// ``
  String get clearanceRequestInstruction {
    return Intl.message(
      '',
      name: 'clearanceRequestInstruction',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get requestCodeButton {
    return Intl.message('', name: 'requestCodeButton', desc: '', args: []);
  }

  /// ``
  String get clearanceSuccessTitle {
    return Intl.message('', name: 'clearanceSuccessTitle', desc: '', args: []);
  }

  /// ``
  String get documentsSentSuccessTitle {
    return Intl.message(
      '',
      name: 'documentsSentSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get clearancePendingSubtitle {
    return Intl.message(
      '',
      name: 'clearancePendingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get proInvoiceNumberLabel {
    return Intl.message('', name: 'proInvoiceNumberLabel', desc: '', args: []);
  }

  /// ``
  String get customerLabelWithColon {
    return Intl.message('', name: 'customerLabelWithColon', desc: '', args: []);
  }

  /// ``
  String get clearanceAmountLabelWithColon {
    return Intl.message(
      '',
      name: 'clearanceAmountLabelWithColon',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get orderAmountLabel {
    return Intl.message('', name: 'orderAmountLabel', desc: '', args: []);
  }

  /// ``
  String get gatewayLabel {
    return Intl.message('', name: 'gatewayLabel', desc: '', args: []);
  }

  /// ``
  String get trackingNumberLabel {
    return Intl.message('', name: 'trackingNumberLabel', desc: '', args: []);
  }

  /// ``
  String get documentSubmissionDateLabel {
    return Intl.message(
      '',
      name: 'documentSubmissionDateLabel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get clearanceDateLabel {
    return Intl.message('', name: 'clearanceDateLabel', desc: '', args: []);
  }

  /// ``
  String get expireDateLabel {
    return Intl.message('', name: 'expireDateLabel', desc: '', args: []);
  }

  /// ``
  String get gotItButton {
    return Intl.message('', name: 'gotItButton', desc: '', args: []);
  }

  /// ``
  String get monthlySales {
    return Intl.message('', name: 'monthlySales', desc: '', args: []);
  }

  /// ``
  String get approvedOrders {
    return Intl.message('', name: 'approvedOrders', desc: '', args: []);
  }

  /// ``
  String get walletBalance {
    return Intl.message('', name: 'walletBalance', desc: '', args: []);
  }

  /// ``
  String get cashCommission {
    return Intl.message('', name: 'cashCommission', desc: '', args: []);
  }

  /// ``
  String get orderStatusChartTitle {
    return Intl.message('', name: 'orderStatusChartTitle', desc: '', args: []);
  }

  /// ``
  String get salesByCategoryChartTitle {
    return Intl.message(
      '',
      name: 'salesByCategoryChartTitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get plansSalesChartTitle {
    return Intl.message('', name: 'plansSalesChartTitle', desc: '', args: []);
  }

  /// ``
  String get successSubmitPreInvoice {
    return Intl.message(
      '',
      name: 'successSubmitPreInvoice',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get select {
    return Intl.message('', name: 'select', desc: '', args: []);
  }

  /// ``
  String get fromDate {
    return Intl.message('', name: 'fromDate', desc: '', args: []);
  }

  /// ``
  String get toDate {
    return Intl.message('', name: 'toDate', desc: '', args: []);
  }

  /// ``
  String get selectEndDate {
    return Intl.message('', name: 'selectEndDate', desc: '', args: []);
  }

  /// ``
  String get day {
    return Intl.message('', name: 'day', desc: '', args: []);
  }

  /// ``
  String get month {
    return Intl.message('', name: 'month', desc: '', args: []);
  }

  /// ``
  String get product {
    return Intl.message('', name: 'product', desc: '', args: []);
  }

  /// ``
  String get year {
    return Intl.message('', name: 'year', desc: '', args: []);
  }

  /// ``
  String get startDate {
    return Intl.message('', name: 'startDate', desc: '', args: []);
  }

  /// ``
  String get returnPeriod {
    return Intl.message('', name: 'returnPeriod', desc: '', args: []);
  }

  /// ``
  String get endDate {
    return Intl.message('', name: 'endDate', desc: '', args: []);
  }

  /// ``
  String get selectStartDate {
    return Intl.message('', name: 'selectStartDate', desc: '', args: []);
  }

  /// ``
  String get phoneNumberWrong {
    return Intl.message('', name: 'phoneNumberWrong', desc: '', args: []);
  }

  /// ``
  String get selectDate {
    return Intl.message('', name: 'selectDate', desc: '', args: []);
  }

  /// ``
  String get documentConfirmationUpload {
    return Intl.message(
      '',
      name: 'documentConfirmationUpload',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get clearanceOperation {
    return Intl.message('', name: 'clearanceOperation', desc: '', args: []);
  }

  /// ``
  String get excessAmountOutOfTolerance {
    return Intl.message(
      '',
      name: 'excessAmountOutOfTolerance',
      desc: '',
      args: [],
    );
  }

  /// `Excess amount will be added to "{walletName}" pocket.`
  String excessAmountAddedToWallet(String walletName) {
    return Intl.message(
      'Excess amount will be added to "$walletName" pocket.',
      name: 'excessAmountAddedToWallet',
      desc: '',
      args: [walletName],
    );
  }

  /// ``
  String get cheapest {
    return Intl.message('', name: 'cheapest', desc: '', args: []);
  }

  /// ``
  String get mostExpensive {
    return Intl.message('', name: 'mostExpensive', desc: '', args: []);
  }

  /// ``
  String get newest {
    return Intl.message('', name: 'newest', desc: '', args: []);
  }

  /// ``
  String get oldest {
    return Intl.message('', name: 'oldest', desc: '', args: []);
  }

  /// ``
  String get sortTitle {
    return Intl.message('', name: 'sortTitle', desc: '', args: []);
  }

  /// ``
  String get internetError {
    return Intl.message('', name: 'internetError', desc: '', args: []);
  }

  /// ``
  String get vpnError {
    return Intl.message('', name: 'vpnError', desc: '', args: []);
  }

  /// ``
  String get retry {
    return Intl.message('', name: 'retry', desc: '', args: []);
  }

  /// ``
  String get sortSubtitle {
    return Intl.message('', name: 'sortSubtitle', desc: '', args: []);
  }

  /// ``
  String get stockLimitError {
    return Intl.message('', name: 'stockLimitError', desc: '', args: []);
  }

  /// ``
  String get outOfStockError {
    return Intl.message('', name: 'outOfStockError', desc: '', args: []);
  }

  /// ``
  String get remainingTimeLabel {
    return Intl.message('', name: 'remainingTimeLabel', desc: '', args: []);
  }

  /// ``
  String get ipgSettlementTitle {
    return Intl.message('', name: 'ipgSettlementTitle', desc: '', args: []);
  }

  /// ``
  String get linkSettlementTitle {
    return Intl.message('', name: 'linkSettlementTitle', desc: '', args: []);
  }

  /// ``
  String get cardToCardSettlementTitle {
    return Intl.message(
      '',
      name: 'cardToCardSettlementTitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get selectSettlementMethodTitle {
    return Intl.message(
      '',
      name: 'selectSettlementMethodTitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get payWithWalletButton {
    return Intl.message('', name: 'payWithWalletButton', desc: '', args: []);
  }

  /// ``
  String get goToShaparakButton {
    return Intl.message('', name: 'goToShaparakButton', desc: '', args: []);
  }

  /// ``
  String get sendPaymentLinkButton {
    return Intl.message('', name: 'sendPaymentLinkButton', desc: '', args: []);
  }

  /// ``
  String get confirmAndPayButton {
    return Intl.message('', name: 'confirmAndPayButton', desc: '', args: []);
  }

  /// ``
  String get waitingForClearanceCompletion {
    return Intl.message(
      '',
      name: 'waitingForClearanceCompletion',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get updateLabel {
    return Intl.message('', name: 'updateLabel', desc: '', args: []);
  }

  /// ``
  String get noSell {
    return Intl.message('', name: 'noSell', desc: '', args: []);
  }

  /// ``
  String get today {
    return Intl.message('', name: 'today', desc: '', args: []);
  }

  /// ``
  String get lastWeek {
    return Intl.message('', name: 'lastWeek', desc: '', args: []);
  }

  /// ``
  String get previousMonth {
    return Intl.message('', name: 'previousMonth', desc: '', args: []);
  }

  /// ``
  String get threeMonthsAgo {
    return Intl.message('', name: 'threeMonthsAgo', desc: '', args: []);
  }

  /// ``
  String get customDate {
    return Intl.message('', name: 'customDate', desc: '', args: []);
  }

  /// ``
  String get category {
    return Intl.message('', name: 'category', desc: '', args: []);
  }

  /// ``
  String get plan {
    return Intl.message('', name: 'plan', desc: '', args: []);
  }

  /// ``
  String get onlyAvailableProducts {
    return Intl.message('', name: 'onlyAvailableProducts', desc: '', args: []);
  }

  /// ``
  String get editImage {
    return Intl.message('', name: 'editImage', desc: '', args: []);
  }

  /// ``
  String get takePhoto {
    return Intl.message('', name: 'takePhoto', desc: '', args: []);
  }

  /// ``
  String get logout {
    return Intl.message('', name: 'logout', desc: '', args: []);
  }

  /// ``
  String get unitCount {
    return Intl.message('', name: 'unitCount', desc: '', args: []);
  }

  /// ``
  String get outOfStockLabel {
    return Intl.message('', name: 'outOfStockLabel', desc: '', args: []);
  }

  /// ``
  String get sku {
    return Intl.message('', name: 'sku', desc: '', args: []);
  }

  /// ``
  String get customerInfoSubmitError {
    return Intl.message(
      '',
      name: 'customerInfoSubmitError',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get documentUploadError {
    return Intl.message('', name: 'documentUploadError', desc: '', args: []);
  }

  /// ``
  String get preInvoiceSubmitError {
    return Intl.message('', name: 'preInvoiceSubmitError', desc: '', args: []);
  }

  /// ``
  String get status {
    return Intl.message('', name: 'status', desc: '', args: []);
  }

  /// ``
  String get selectOrderStatusSubtitle {
    return Intl.message(
      '',
      name: 'selectOrderStatusSubtitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get selectCreditPlanSubtitle {
    return Intl.message(
      '',
      name: 'selectCreditPlanSubtitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get settlementOperation {
    return Intl.message('', name: 'settlementOperation', desc: '', args: []);
  }

  /// ``
  String get enterTrackingCodeHint {
    return Intl.message('', name: 'enterTrackingCodeHint', desc: '', args: []);
  }

  /// ``
  String get totalCashDiscount {
    return Intl.message('', name: 'totalCashDiscount', desc: '', args: []);
  }

  /// ``
  String get onlinePaymentGateway {
    return Intl.message('', name: 'onlinePaymentGateway', desc: '', args: []);
  }

  /// ``
  String get sendPaymentLinkToCustomer {
    return Intl.message(
      '',
      name: 'sendPaymentLinkToCustomer',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get uploadDepositReceipt {
    return Intl.message('', name: 'uploadDepositReceipt', desc: '', args: []);
  }

  /// ``
  String get confirmSelectedMethod {
    return Intl.message('', name: 'confirmSelectedMethod', desc: '', args: []);
  }

  /// ``
  String get supportNameLabel {
    return Intl.message('', name: 'supportNameLabel', desc: '', args: []);
  }

  /// `Submit Request`
  String get submitRequest {
    return Intl.message(
      'Submit Request',
      name: 'submitRequest',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get financialManagerNameLabel {
    return Intl.message(
      '',
      name: 'financialManagerNameLabel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get rejectionReasonLabel {
    return Intl.message('', name: 'rejectionReasonLabel', desc: '', args: []);
  }

  /// ``
  String get fetchUserSettingsError {
    return Intl.message('', name: 'fetchUserSettingsError', desc: '', args: []);
  }

  /// ``
  String get transactionDoc {
    return Intl.message('', name: 'transactionDoc', desc: '', args: []);
  }

  /// ``
  String get fetchOrderDetailsError {
    return Intl.message('', name: 'fetchOrderDetailsError', desc: '', args: []);
  }

  /// ``
  String get initiateClearanceError {
    return Intl.message('', name: 'initiateClearanceError', desc: '', args: []);
  }

  /// ``
  String get documentUploadOrFinalizeError {
    return Intl.message(
      '',
      name: 'documentUploadOrFinalizeError',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get otpVerifyOrFinalizeError {
    return Intl.message(
      '',
      name: 'otpVerifyOrFinalizeError',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get initiateSettlementError {
    return Intl.message(
      '',
      name: 'initiateSettlementError',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get receiptUploadError {
    return Intl.message('', name: 'receiptUploadError', desc: '', args: []);
  }

  /// ``
  String get settlementConfirmError {
    return Intl.message('', name: 'settlementConfirmError', desc: '', args: []);
  }

  /// ``
  String get inventory {
    return Intl.message('', name: 'inventory', desc: '', args: []);
  }

  /// ``
  String get toleranceSettingNotFoundError {
    return Intl.message(
      '',
      name: 'toleranceSettingNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get upload {
    return Intl.message('', name: 'upload', desc: '', args: []);
  }

  /// `{label}`
  String selectOptionSubtitle(String label) {
    return Intl.message(
      '$label',
      name: 'selectOptionSubtitle',
      desc: '',
      args: [label],
    );
  }

  /// `{label}`
  String labelWithColon(String label) {
    return Intl.message(
      '$label',
      name: 'labelWithColon',
      desc: '',
      args: [label],
    );
  }

  /// ``
  String get reportSearchHint {
    return Intl.message('', name: 'reportSearchHint', desc: '', args: []);
  }

  /// ``
  String get selectPlanTitle {
    return Intl.message('', name: 'selectPlanTitle', desc: '', args: []);
  }

  /// ``
  String get parentCategoryLabel {
    return Intl.message('', name: 'parentCategoryLabel', desc: '', args: []);
  }

  /// ``
  String get categoryLabel {
    return Intl.message('', name: 'categoryLabel', desc: '', args: []);
  }

  /// `{count}`
  String resultsCountLabel(int count) {
    return Intl.message(
      '$count',
      name: 'resultsCountLabel',
      desc: '',
      args: [count],
    );
  }

  /// ``
  String get noReportFound {
    return Intl.message('', name: 'noReportFound', desc: '', args: []);
  }

  /// ``
  String get dateLabel {
    return Intl.message('', name: 'dateLabel', desc: '', args: []);
  }

  /// ``
  String get basePriceLabel {
    return Intl.message('', name: 'basePriceLabel', desc: '', args: []);
  }

  /// ``
  String get orderCountLabel {
    return Intl.message('', name: 'orderCountLabel', desc: '', args: []);
  }

  /// ``
  String get totalSalesAmountLabel {
    return Intl.message('', name: 'totalSalesAmountLabel', desc: '', args: []);
  }

  /// ``
  String get purchaseAmountLabel {
    return Intl.message('', name: 'purchaseAmountLabel', desc: '', args: []);
  }

  /// ``
  String get salesReportTitle {
    return Intl.message('', name: 'salesReportTitle', desc: '', args: []);
  }

  /// ``
  String get planReportTitle {
    return Intl.message('', name: 'planReportTitle', desc: '', args: []);
  }

  /// ``
  String get categoryReportTitle {
    return Intl.message('', name: 'categoryReportTitle', desc: '', args: []);
  }

  /// ``
  String get productReportTitle {
    return Intl.message('', name: 'productReportTitle', desc: '', args: []);
  }

  /// ``
  String get totalSalesLabel {
    return Intl.message('', name: 'totalSalesLabel', desc: '', args: []);
  }

  /// ``
  String get totalOrdersLabel {
    return Intl.message('', name: 'totalOrdersLabel', desc: '', args: []);
  }

  /// ``
  String get totalItemsLabel {
    return Intl.message('', name: 'totalItemsLabel', desc: '', args: []);
  }

  /// ``
  String get uniqueCustomersLabel {
    return Intl.message('', name: 'uniqueCustomersLabel', desc: '', args: []);
  }

  /// ``
  String get averageSalesAmountLabel {
    return Intl.message(
      '',
      name: 'averageSalesAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get averageItemsPerOrderLabel {
    return Intl.message(
      '',
      name: 'averageItemsPerOrderLabel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get totalPurchaseLabel {
    return Intl.message('', name: 'totalPurchaseLabel', desc: '', args: []);
  }

  /// ``
  String get averageSalesPerPlanLabel {
    return Intl.message(
      '',
      name: 'averageSalesPerPlanLabel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get averageSalesPerCategoryLabel {
    return Intl.message(
      '',
      name: 'averageSalesPerCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `{count}`
  String monthsCountLabel(String count) {
    return Intl.message(
      '$count',
      name: 'monthsCountLabel',
      desc: '',
      args: [count],
    );
  }

  /// `Parent Category`
  String get parentCategorySecondaryLabel {
    return Intl.message(
      'Parent Category',
      name: 'parentCategorySecondaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sub-plan Name`
  String get subPlanNameLabel {
    return Intl.message(
      'Sub-plan Name',
      name: 'subPlanNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `By selling {distance} Rials more, your commission will increase to {nextRateCash}% cash or {nextRateProduct}% goods.`
  String commissionMessage(
    String distance,
    String nextRateCash,
    String nextRateProduct,
  ) {
    return Intl.message(
      'By selling $distance Rials more, your commission will increase to $nextRateCash% cash or $nextRateProduct% goods.',
      name: 'commissionMessage',
      desc: '',
      args: [distance, nextRateCash, nextRateProduct],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
