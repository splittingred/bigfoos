class RailgunMailer < ActionMailer::Base
  default from: 'splittingred+bigfoos@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.railgun_mailer.achievement_gained.subject
  #
  def achievement_gained(record)
    @record = record
    mail to: record[:user].email, subject: '[BigFoos] Achievement '+record[:achievement].name+' Gained!'
  end
end
