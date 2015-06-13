require './registration.login.module'
require "./registration.login.service"
require "./registration.login.controller"
require "./registration.login.directive"

@App.module "RegistrationApp.Login", (Login, App, Backbone, Marionette, $, _) ->
