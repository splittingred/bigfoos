##
# Abstracts out Colors into a transient object
#
class Color < Hashie::Dash
  property :key
  property :name

  COLORS = {
      Black: 'Black',
      Yellow: 'Yellow',
  }

  class << self
    ##
    # Return an array of all Color objects
    #
    # @return [Array<Color>]
    #
    def all
      COLORS.map { |key, name| Color.new(key: key, name: name) }
    end

    ##
    # Return a Color object
    #
    # @param [String] key
    # @return [Color]
    #
    def find(key)
      new(key: key, name: COLORS[key.to_sym]) if COLORS.has_key?(key.to_sym)
    end

    ##
    # Returns all Colors as a selectable array
    #
    # @return [Array]
    #
    def as_selectable_array
      all.inject([]) { |h,t| h << [t.name, t.key] }
    end

    def to_a
      all.inject([]) { |h,t| h << t.name }
    end
  end

  COLORS.each do |key, name|
    define_method :"#{key}?" do
      self.name == name
    end
  end

  ##
  # Return Color name in a human-friendly format
  #
  # @return [String]
  #
  def human_name
    name.capitalize.to_s
  end

  ##
  # Return Color in a readable string format
  #
  # @return [String]
  #
  def to_s
    human_name
  end

  def css_class
    name.downcase
  end
end
