##
# Abstracts out Positions into a transient object
#
class Position < Hashie::Dash
  property :key
  property :name

  TYPES = {
      front: 'front',
      back: 'back',
  }

  class << self
    ##
    # Return an array of all Position objects
    #
    # @return [Array<Position>]
    #
    def all
      TYPES.map { |key, name| Position.new(key: key, name: name) }
    end

    ##
    # Return a Position object
    #
    # @param [String] key
    # @return [Position]
    #
    def find(key)
      new(key: key, name: TYPES[key.to_sym]) if TYPES.has_key?(key.to_sym)
    end

    ##
    # Returns all Positions as a selectable array
    #
    # @return [Array]
    #
    def as_selectable_array
      all.inject([]) { |h,t| h << [t.name, t.key] }
    end
  end

  TYPES.each do |key, name|
    define_method :"#{key}?" do
      self.name == name
    end
  end

  ##
  # Return position name in a human-friendly format
  #
  # @return [String]
  #
  def human_name
    name.capitalize.to_s
  end

  ##
  # Return position in a readable string format
  #
  # @return [String]
  #
  def to_s
    human_name
  end
end
