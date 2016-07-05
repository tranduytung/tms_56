class UserMailer < ApplicationMailer
  default from: Settings.mail_from
 
  def assign_to_course user, course
    @user = user
    @course = course
    mail to: @user.email, subject: t("mail.assign", content: course.content)
  end

  def delete_from_course user, course
    @user = user
    @course = course
    mail to: @user.email, subject: t("mail.delete", content: course.content)
  end

  def send_mail_before_course_finish course
    @supervisor = course.user
    @course = course
    mail to: @supervisor.email,
      subject: t("mail.before_course_finish", content: course.content,
      day: end_date)
  end
end
