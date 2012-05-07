#!/usr/bin/env ruby

require 'rspec'

# TODO remake this whole test suite because
# base_trust + endorsements is dynamic

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
    data = ['4', '1:0 2:0 3:0 4:0']
    File.open($infile, 'w') do |input|
      input.write(data.join("\n"))
    end
    output = `bin/trust < #{$infile}`
    output.should == '1:0 2:0 3:0 4:0'
  end

  it 'returns 0 for 4 users w/ 0 base trust and w/ endorsements' do
    data = ['4', '1:0 2:0 3:0 4:0', '1 2', '2 3', '3 1', '4 3']
    File.open($infile, 'w') do |input|
      input.write(data.join("\n"))
    end
    output = `bin/trust < #{$infile}`
    output.should == '1:0 2:0 3:0 4:0'
  end

  it '!return 0 for 3 users w/ non-0 base trust and w/o endorsements' do
    data = ['4', '1:1 2:2 3:1 4:3', '1 2', '2 3', '3 1', '4 3']
    File.open($infile, 'w') do |input|
      input.write(data.join("\n"))
    end
    output = `bin/trust < #{$infile}`
    output.should_not == '1:0 2:0 3:0 4:0'
  end
end
