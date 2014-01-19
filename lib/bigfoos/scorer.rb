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
      :win_ratio => 5.0,
      :loss_ratio => 2.5,

      :score => 3,

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
    end
    @score = @score <= 0 ? 0 : @score
    @user.score = @score
    @user.save
    puts "Setting score for #{@user.name} to #{@score.to_s}"
    @score
  end

  def win_ratio_adjustment
    adjustment = 0
    wins = @stats[:wins].to_i
    losses = @stats[:losses].to_i
    player_games = @stats[:games].to_i
    total_games = ::Game.where('status = ?','finished').count

    percentage_of_games = (player_games.to_f / total_games.to_f)

    win_percentage = wins.to_f / player_games.to_f
    loss_percentage = (100.00 - (win_percentage*100))/100.00
    if loss_percentage > 0
      win_multiplier = (win_percentage) / (loss_percentage*@ratios[:loss])
    else
      win_multiplier = win_percentage
    end

    puts "#{@user.name}: (W: #{win_percentage.to_s}) - (L: #{loss_percentage.to_s} * #{@ratios[:loss].to_s}) == #{win_multiplier.to_s}"
    if wins > 0 or losses > 0
      win_adder = (wins * @ratios[:win_ratio]) - (losses * @ratios[:loss_ratio]) + (percentage_of_games * @ratios[:match_percentage_multiplier])
      win_adder2 = win_adder * win_multiplier
      adjustment += win_adder2

      puts "#{@user.name}:  (#{wins.to_s} * #{@ratios[:win_ratio].to_s}) - (#{losses.to_s} * #{@ratios[:loss_ratio].to_s}) + (#{percentage_of_games.to_s} * #{@ratios[:match_percentage_multiplier].to_s}) == #{win_adder.to_s} * #{win_multiplier.to_s} == #{win_adder2.to_s}"
    end

    adjustment
  end

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
end