#! /usr/bin/env ruby
# coding: utf-8

require 'helper'
require "fileutils"
require "test/unit"
require "imageutils/urllogger.rb"

class TC_UrlLogger < Test::Unit::TestCase
  def setup
    @ul00 = UrlLogger.new("test/urllogger")
  end

  def test_initialize
    assert_raises(UrlLogger::InitializeError){ UrlLogger.new("") }
  end

  def test_include?
    assert_equal(true , @ul00.include?("http://a.b.c/d0.html"))
    assert_equal(true , @ul00.include?("http://a.b.c/d1.html"))
    assert_equal(true , @ul00.include?("http://a.b.c/d2.html"))
    assert_equal(true , @ul00.include?("http://a.b.c/d3.html"))
    assert_equal(false, @ul00.include?("http://a.b.c/d4.html"))
  end

  def test_write_with_filename
    log_file = "test/urllogger/dummy.log"
    FileUtils.rm log_file if File.exist? log_file

    assert_equal(false, @ul00.include?("a"))
    assert_equal(false, @ul00.include?("b"))
    @ul00.write("a", log_file)
    @ul00.write("b", log_file)
    assert_equal(true , File.exist?(log_file))
    assert_equal(true , @ul00.include?("a"))
    assert_equal(true , @ul00.include?("b"))

    FileUtils.rm log_file if File.exist? log_file
  end

  def test_write_without_filename
    log_file = DateTime.now.strftime("test/urllogger/%C%g%m%d.log")
    FileUtils.rm log_file if File.exist? log_file

    assert_equal(false, @ul00.include?("a"))
    assert_equal(false, @ul00.include?("b"))
    @ul00.write("a")
    @ul00.write("b")
    assert_equal(true , File.exist?(log_file))
    assert_equal(true , @ul00.include?("a"))
    assert_equal(true , @ul00.include?("b"))
    FileUtils.rm log_file if File.exist? log_file
  end


end

