class UserDecorator < ApplicationDecorator
  delegate_all

  def win_loss
    user.wins.to_s+' / '+user.losses.to_s
  end

  def gravatar
    h.content_tag :img, '', {src: user.gravatar_url, alt: ''}
  end

end
