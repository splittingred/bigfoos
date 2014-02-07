class BigFoos::Scorer
  class << self
    def score(user)
      scorer = self.new(user)
      scorer.score
    end
  end

  ##
  # @param [User] user
  #
  def initialize(user)
    @user = user
    @ratios = {
      :win_loss_ratio_multiplier => 100.0,
      :pfpa_ratio_multiplier => 20.0,

      :ppg => 35.0,
      :ppg_against => 20.0,

      :match_percentage_multiplier => 15,
      :inactive_penalty_multiplier => 25,
      :inactive_penalty_days => 5.00,
      :minimum_matches => 5
    }
  end

  def score
    return 0 unless @user
    @score = 0

    @stats = @user.stats_as_hash
    player_games = @stats[:games].to_i

    if player_games >= @ratios[:minimum_matches]
      @score += self.ratios_adjustment
      #@score += self.inactivity_adjustment
      @score += self.ppg_adjustments
      @score += self.percentage_of_games_adjustment
    end
    @score = @score <= 0 ? 0 : @score
    @user.score = @score
    @user.save
    puts "Setting score for #{@user.name} to #{@score.to_s}" if Rails.env != 'test'
    @score
  end

  ##
  # Calculates score boost for w/l ratios
  #
  def ratios_adjustment
    adjustment = 0
    adjustment += @user.ratio('win-loss',true) * 10 * @ratios[:win_loss_ratio_multiplier]
    adjustment += @user.ratio('pf-pa',true) * 10 * @ratios[:pfpa_ratio_multiplier]
  end

  ##
  # Calculates score boost for games played
  #
  def percentage_of_games_adjustment
    adjustment = 0
    player_games = @stats[:games].to_i

    average_games = UserStat.where(name: 'games').average(:value)

    # deduct points from people who have played less than average games
    # this prevents newbies from topping charts
    delta = average_games - player_games
    if delta > 0
      adjustment = -(@ratios[:match_percentage_multiplier]*delta)
    end
    #puts '-- delta for '+@user.name+': '+delta.to_s+' --- adjustment: '+adjustment.to_s
    adjustment
  end

  ##
  # Penalizes inactive players
  #
  def inactivity_adjustment
    adjustment = 0
    last_game = @user.games.where('status = ?','finished').last
    if last_game
      days_since_last_game = (Time.now - last_game.created_at) / 86400
      if days_since_last_game > @ratios[:inactive_penalty_days]
        adjustment -= (days_since_last_game * @ratios[:inactive_penalty_multiplier])
      end
    end
    adjustment
  end

  ##
  # Calculates score boost for points scored per game avg
  #
  def ppg_adjustments
    adjustment = @user.average_points_per_game.to_f * @ratios[:ppg]
    adjustment -= @user.average_points_against_per_game.to_f * @ratios[:ppg_against]
  end
end