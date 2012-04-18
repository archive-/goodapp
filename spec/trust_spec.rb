#!/usr/bin/env ruby

require 'rspec'

describe 'trust.cpp' do
  # check compiles
  before(:all) do
    `make clean; make`
    $num = 1
  end

  before(:each) do
    $infile = "data/test#{$num}.in"
    $num += 1
  end

  it 'returns 0 for 4 users w/ 0 base trust and w/o endorsements' do
    data = ['4', '0 0 0 0', 'x 0 0 0', '0 x 0 0', '0 0 x 0', '0 0 0 x']
    File.open($infile, 'w') do |input|
      input.write(data.join("\n"))
    end
    output = `bin/trust < #{$infile}`
    output.should == '0 0 0 0'
  end

  it 'returns 0 for 4 users w/ 0 base trust and w/ endorsements' do
    data = ['4', '0 0 0 0', 'x 1 0 0', '0 x 1 0', '1 0 x 0', '0 0 1 x']
    File.open($infile, 'w') do |input|
      input.write(data.join("\n"))
    end
    output = `bin/trust < #{$infile}`
    output.should == '0 0 0 0'
  end

  it '!return 0 for 3 users w/ non-0 base trust and w/o endorsements' do
    data = ['4', '1 2 1 3', 'x 1 0 0', '0 x 1 0', '1 0 x 0', '0 0 1 x']
    File.open($infile, 'w') do |input|
      input.write(data.join("\n"))
    end
    output = `bin/trust < #{$infile}`
    output.should_not == '0 0 0 0'
  end
end
