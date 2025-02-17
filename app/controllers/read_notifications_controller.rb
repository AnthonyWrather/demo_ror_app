class ReadNotificationsController < ApplicationController
  def read_all
    current_user.notifications.mark_as_read
    redirect_to notifications_path, notice: "All Notifications marked as read."
  end
end
