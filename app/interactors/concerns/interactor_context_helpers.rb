module InteractorContextHelpers
  def self.included(base)
    base.alias_method_chain :fail!, :logs
  end

  ##
  # Ensure that we log an error when an Interactor fails
  #
  # @param context [Hash] The context (default: {}).
  # @return context [Hash]
  # @example
  #   context.fail!(error: 'foo') { |cont| "User id: #{cont.user.id} tried to become Admin" }
  def fail_with_logs!(context={})
    error_msg = context[:error].presence || ''
    detailed_error_msg = ''

    if block_given?
      detailed_error_msg = yield(self)
    end

    full_error_msg = error_msg.dup
    full_error_msg << " -- [Details] => #{detailed_error_msg}" unless detailed_error_msg.blank?

    Rails.logger.error full_error_msg

    fail_without_logs!(context)
  end
end
