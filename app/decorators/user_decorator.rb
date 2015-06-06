class UserDecorator < ApplicationDecorator
  delegate_all

  def win_loss
    if respond_to? :wins
      wins.to_s+' / '+losses.to_s
    else
      stat(:wins).to_s+' / '+stat(:losses).to_s
    end
  end

  def win_loss_ratio
    (ratio('win-loss',true)*100).to_s+'%'
  end

  def pfpa_ratio
    (ratio('pf-pa',true)*100).to_s+'%'
  end

  def ppg
    self[:ppg].round(2).to_s
  end

  def ppg_against
    self[:ppg_against].round(2).to_s
  end

  def gravatar(size = 30)
    h.content_tag :img, '', {src: gravatar_url(size: size), alt: ''}
  end

  def show_link
    h.link_to name, h.user_path(self)
  end

end
