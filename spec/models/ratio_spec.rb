require 'spec_helper'

describe Ratio do
  before do
    @user = Fabricate(:user)
  end

  context 'set_for_user' do
    it 'test for non-existent ratio' do
      Ratio.set_for_user(@user,'win-loss',0.51)

      expect(@user.ratio('win-loss',true)).to eq 0.51
    end
    it 'test for existent ratio' do
      Ratio.set_for_user(@user,'win-loss',0.51)
      Ratio.set_for_user(@user,'win-loss',0.52)

      expect(@user.ratio('win-loss',true)).to eq 0.52
    end
  end

  it 'test recalculate_for' do
    @user.set_stat(:games,10)
    @user.set_stat(:wins,9)
    @user.set_stat(:scores,20)
    @user.set_stat(:scored_against,18)

    @user.recalculate_ratios
    expect(@user.ratio('win-loss',true)).to eq 0.9
    expect(@user.ratio('pf-pa',true)).to eq 2
  end
end
