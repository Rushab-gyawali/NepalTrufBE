class RegistrationMailer < ApplicationMailer
    default from: "mail@example.com"

    
    def registration_mail(user)
        @user = user
        mail(to: @user.email, subject: 'Welcome to Our App!')
    end
end
