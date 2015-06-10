module Ratios
  class Set
    include Interactor

    before do
      @user = context.user
      @name = context.name
      @value = context.value || 0.00
    end

    def call
      ratio = Ratio.for_user(@user, @name).first || Ratio.new(user: @user, name: @name)
      ratio.value = @value ? @value.to_f.round(2) : 0.0
      ratio.save!

    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(error: e.message)
    end
  end
end
