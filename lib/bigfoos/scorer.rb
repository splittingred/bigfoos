class BigFoos::Scorer
  class << self
    def score(user)
      scorer = self.new(user)
      scorer.score
    end
  end
  def initialize(user)

    @user = user
    @ratios = {
      :win_loss_ratio_multiplier => 100.0,

      :score => 5,

      :match_percentage_multiplier => 10,
      :loss => 1.0,
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
      @score += self.score_adjustment
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
      adjustment += ((@user.wl_ratio * @ratios[:win_loss_ratio_multiplier])*(percentage_of_games*@ratios[:match_percentage_multiplier]))
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
  # Calculates score boost for points scored
  #
  def score_adjustment
    @stats[:scores]*@ratios[:score]
  end
end