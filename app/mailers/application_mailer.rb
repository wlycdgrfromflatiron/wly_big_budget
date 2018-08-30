class ApplicationMailer < ActionMailer::Base
  default from: [SMTP_FROM]
  layout 'mailer'
end
