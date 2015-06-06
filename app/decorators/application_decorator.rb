class ApplicationDecorator < Draper::Decorator
  delegate_all
  class << self
    def collection_decorator_class
      PaginatingDecorator
    end
  end

  ##
  # Translate a field based on the i18n locale AR attribute value
  #
  # @param column [String|Hash]
  # @return [String]
  def t(column)
    object.class.human_attribute_name(column.to_sym)
  end
end
