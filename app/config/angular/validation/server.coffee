server = (validator) ->
	() ->
		{
			restrict: 'A',
			require: '?ngModel',
			link: (scope, elm, attr, ctrl) ->
				ctrl.$validators[validator] = (modelValue, viewValue) ->
					true
  }

app = angular.module('validation.server', [])

#Generated by ClembleErrorSerializationTest.generateAngularModuleInitiation

app.directive('serverGeneralError', server('server_general_error'))
app.directive('serverCriticalError', server('server_critical_error'))
app.directive('serverSessionProcessingError', server('server_session_processing_error'))
app.directive('serverCacheError', server('server_cache_error'))
app.directive('serverLatchError', server('server_latch_error'))
app.directive('serverBadRequestPlayerIdHeaderMissing', server('server_bad_request_player_id_header_missing'))
app.directive('serverBadRequestSessionIdHeaderMissing', server('server_bad_request_session_id_header_missing'))
app.directive('serverBadRequestTableIdHeaderMissing', server('server_bad_request_table_id_header_missing'))
app.directive('serverEmailInvalid', server('server_email_invalid'))
app.directive('serverEmailMissing', server('server_email_missing'))
app.directive('serverEmailNotConfirmed', server('server_email_not_confirmed'))
app.directive('serverEmailNotRegistered', server('server_email_not_registered'))
app.directive('serverEmailAlreadyRegistered', server('server_email_already_registered'))
app.directive('serverPasswordMissing', server('server_password_missing'))
app.directive('serverPasswordTooShort', server('server_password_too_short'))
app.directive('serverPasswordTooWeak', server('server_password_too_weak'))
app.directive('serverPasswordTooLong', server('server_password_too_long'))
app.directive('serverEmailOrPasswordIncorrect', server('server_email_or_password_incorrect'))
app.directive('serverPasswordIncorrect', server('server_password_incorrect'))
app.directive('serverProfileSocialCantBeEdited', server('server_profile_social_cant_be_edited'))
app.directive('serverIdentityInvalid', server('server_identity_invalid'))
app.directive('serverNickInvalid', server('server_nick_invalid'))
app.directive('serverNickTooLong', server('server_nick_too_long'))
app.directive('serverNickTooShort', server('server_nick_too_short'))
app.directive('serverNickOccupied', server('server_nick_occupied'))
app.directive('serverNickMustNotBeNull', server('server_nick_must_not_be_null'))
app.directive('serverNickNoWhiteSpacesAllowed', server('server_nick_no_white_spaces_allowed'))
app.directive('serverFirstNameTooLong', server('server_first_name_too_long'))
app.directive('serverLastNameTooLong', server('server_last_name_too_long'))
app.directive('serverBirthDateInvalid', server('server_birth_date_invalid'))
app.directive('serverSocialConnectionProviderUserNull', server('server_social_connection_provider_user_null'))
app.directive('serverSocialConnectionProviderIdNull', server('server_social_connection_provider_id_null'))
app.directive('serverSocialConnectionInvalid', server('server_social_connection_invalid'))
app.directive('serverSocialConnectionAlreadyRegistered', server('server_social_connection_already_registered'))
app.directive('serverSocialConnectionProviderNotSupported', server('server_social_connection_provider_not_supported'))
app.directive('serverClientJsonInvalidError', server('server_client_json_invalid_error'))
app.directive('serverClientJsonFormatError', server('server_client_json_format_error'))
app.directive('serverCellOwned', server('server_cell_owned'))
app.directive('serverGameStateReCreationFailure', server('server_game_state_re_creation_failure'))
app.directive('serverPaymentTransactionInvalid', server('server_payment_transaction_invalid'))
app.directive('serverPaymentTransactionEmpty', server('server_payment_transaction_empty'))
app.directive('serverPaymentTransactionUnknownPlayers', server('server_payment_transaction_unknown_players'))
app.directive('serverPaymentTransactionAccessDenied', server('server_payment_transaction_access_denied'))
app.directive('serverPaymentTransactionNotExists', server('server_payment_transaction_not_exists'))
app.directive('serverPaymentTransactionDebitAndCreditNotMatched', server('server_payment_transaction_debit_and_credit_not_matched'))
app.directive('serverPaymentTransactionTransactionDateMissing', server('server_payment_transaction_transaction_date_missing'))
app.directive('serverPaymentTransactionProcessingDateMissing', server('server_payment_transaction_processing_date_missing'))
app.directive('serverPaymentTransactionInsufficientMoney', server('server_payment_transaction_insufficient_money'))
app.directive('serverTimeoutProcessingFailure', server('server_timeout_processing_failure'))
app.directive('serverPlayerLockAcquireFailure', server('server_player_lock_acquire_failure'))
app.directive('serverPlayerSessionTimeout', server('server_player_session_timeout'))
app.directive('serverPlayerProfileDoesNotExists', server('server_player_profile_does_not_exists'))
app.directive('serverPlayerNotProfileOwner', server('server_player_not_profile_owner'))
app.directive('serverPlayerProfileInvalid', server('server_player_profile_invalid'))
app.directive('serverPlayerNotSessionOwner', server('server_player_not_session_owner'))
app.directive('serverPlayerSessionClosed', server('server_player_session_closed'))
app.directive('serverPlayerAccountAccessDenied', server('server_player_account_access_denied'))
app.directive('serverPlayerNoInvitation', server('server_player_no_invitation'))
app.directive('serverGoalStateIncorrect', server('server_goal_state_incorrect'))
app.directive('serverGoalDueDateInPast', server('server_goal_due_date_in_past'))
app.directive('serverGoalPlayerIncorrect', server('server_goal_player_incorrect'))
app.directive('serverGoalBidInvalid', server('server_goal_bid_invalid'))
app.directive('serverGoalIsEmpty', server('server_goal_is_empty'))
app.directive('serverGoalJudgeOnlyJudgeCanReplay', server('server_goal_judge_only_judge_can_replay'))
app.directive('serverGoalNotExists', server('server_goal_not_exists'))
app.directive('serverGoalNotOwnedByPlayer', server('server_goal_not_owned_by_player'))
app.directive('serverGoalActionInvalid', server('server_goal_action_invalid'))
app.directive('serverAccountInsufficientAmount', server('server_account_insufficient_amount'))