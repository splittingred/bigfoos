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

      :ppg => 35.0,
      :ppg_against => 20.0,

      :match_percentage_multiplier => 2,
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
      @score += self.win_ratio_adjustment
      #@score += self.inactivity_adjustment
      @score += self.ppg_adjustments
    end
    @score = @score <= 0 ? 0 : @score
    @user.score = @score
    @user.save
    puts "Setting score for #{@user.name} to #{@score.to_s}"
    @score
  end

  ##
  # Calculates score boost for w/l ratios
  #
  def win_ratio_adjustment
    adjustment = 0
    wins = @stats[:wins].to_i
    losses = @stats[:losses].to_i
    player_games = @stats[:games].to_i
    total_games = ::Game.where('status = ?','finished').count

    percentage_of_games = (player_games.to_f / total_games.to_f)

    if wins > 0 or losses > 0
      adjustment += (@user.wl_ratio * 10 * @ratios[:win_loss_ratio_multiplier])*(percentage_of_games*10*@ratios[:match_percentage_multiplier])
        # taking this out as its skewing toward most games played
        #*(percentage_of_games*100*@ratios[:match_percentage_multiplier]))
    end

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