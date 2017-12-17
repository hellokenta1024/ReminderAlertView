
Pod::Spec.new do |s|
  s.name         = "ReminderAlertView"
  s.version      = "1.0.0"
  s.summary      = "A alert view that can remind regularly"
  s.description  = <<-DESC
                    ReminderAlertView is inspired by Appirater (https://github.com/arashpayan/appirater)
                    Appirater is only for app review. ReminderAlertView has high versatility.
                    You can use ReminderAlertView according to your application. For app review, push notification, and etc.
                   DESC
  s.homepage     = "https://github.com/KEN-chan/ReminderAlertView"
  s.license      = "MIT"
  s.author       = { "Kenta Hara" => "hellokenta1024@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/KEN-chan/ReminderAlertView.git", :tag => "#{s.version}" }
  s.source_files  = "ReminderAlertView/*.{swift,h,m}"
  s.exclude_files = "Classes/Exclude"
end
