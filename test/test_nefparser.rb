#! /usr/bin/env ruby
# coding: utf-8

require 'helper'
require "test/unit"
require "imageutils/nefparser.rb"

class TC_NefParser < Test::Unit::TestCase
	def setup
		@np00 = NefParser.new
	end

	def test_taken_date

		data = File.open("test/001.nef", "r").read
		assert_equal(Time.mktime(2011, 8, 12, 5, 50, 33), @np00.taken_date(data))

		data = File.open("test/001.nef", "r").read(372+19)
		assert_equal(Time.mktime(2011, 8, 12, 5, 50, 33), @np00.taken_date(data))

		# String でないときに例外。
		data = File.open("test/001.nef", "r").readlines
		assert_raise(NefParserTypeError){@np00.taken_date(data)}

		# NEF と異なるときに例外のテスト
		assert_raise(NefParserNotNefError){@np00.taken_date("Not NEF data")}

	end

end

