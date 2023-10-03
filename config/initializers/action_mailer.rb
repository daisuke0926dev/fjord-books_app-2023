class EmailDeliveryObserver
  def self.delivered_email(message)
    Rails.logger.debug(<<~TEXT)
      ==== decoded subject ====
      #{message.subject}
      ==== decoded subject ====
      ==== decoded body ====
      #{message.body.encoded}
      ==== decoded body ====
    TEXT
  end
end

Rails.application.configure do
  config.action_mailer.observers = %w[EmailDeliveryObserver]
end
