require 'metric'

describe Metric do

  before(:each) do
    @metric = Metric.new('https://gist.githubusercontent.com/diegoacuna/47740d1d76f06aa8ced9a0db448e90a5/raw/576ea6d802741c21ef600995763e69661b254fb8/coding_challenge_endpoint.json')
  end

  it 'return titles of most bookmarked projects in Chile in June' do
    expect(@metric.most_bookmarked_projects('cl',6)).to eq(['Campus Quiksilver Na Pali / Patrick Arotcharen',
                                                            'ZOOCO / ZOOCO Estudio',
                                                            'Bulleit Frontier Works bar / FAR rohn&rojas'])
  end

  it 'calculate best performant sites by pageview in June' do
    expect(@metric.best_performant_sites(6)).to eq([['cl', 39_870], ['mx', 24_403], ['co', 24_403], ['pe', 24_403],
                                                    ['us', 15_467]])
  end

end
