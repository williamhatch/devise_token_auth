class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << email_invalid_message
    end
  end
  
  private
  
  def email_invalid_message
    # Try strictly set message:
    message = options[:message]
    
    if message.nil?

      # Try DeviceTokenAuth translations:
      message = I18n.t('errors.not_email', default: '')

      # Fallback to ActiveModel translations:
      message = I18n.t('errors.messages.invalid') if message.blank?
    end
    
    message
  end  
end