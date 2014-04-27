require 'spec_helper'

require_relative '../lib/ally/detector/duration'

describe Ally::Detector::Duration do
  context 'detect time duration' do
    it 'simple case' do
      subject.inquiry('5 minutes').detect.should == [300]
    end

    it 'with no numbers' do
      subject.inquiry('an hr')
        .detect.should == [3600]
    end

    it 'in a sentence' do
      subject.inquiry('i\'ll see him in about a week')
        .detect.should == [604800]
    end

    it 'with number of plural unit of time' do
      subject.inquiry('America hasn\'t seen a civil war in almost 2 centuries')
        .detect.should == [6307200000]
    end

    it 'when none exists' do
      subject.inquiry('Time? no time here')
        .detect.should == nil
    end

    it 'when multiple durations are given' do
      subject.inquiry('I have a meeting in 25 minutes, can we meetup in 2 hours?')
        .detect.should == [1500, 7200]
    end  
  end
end
