#! /usr/bin/env ruby
# coding: utf-8

require "date"

#
#
#
class UrlLogger
  #LOG_DIR = ENV["HOME"] + "/image/download/log"

  class InitializeError < Exception; end

  # dir is a directory to storage logs.
  def initialize(dir)
    raise InitializeError, "#{dir} not exist" unless File.directory?(dir)
    @dir = dir
  end

  # return true if entry is included in logdir.
  def include?(entry)
    Dir.glob(@dir + "/*.log").each do |file|
      return true if File.open(file, "r").readlines.map{|i|i.chomp}.include?(entry)
    end
    return false
  end

  def write(entry,
      filename = @dir + (DateTime.now.strftime("/%C%g%m%d.log")))
    File.open(filename, "a") { |io| io.puts entry }
  end

end

