#! /usr/bin/env ruby
# coding: utf-8

class NefParserNotNefError < StandardError; end
class NefParserTypeError < StandardError; end

#
# Nikon NEF ファイルのなんちゃってパーサ。
#
class NefParser
	#
	def initialize
	end

	# 撮影日時を返す(つもり)。
	#
	# 頑張って解析はしてない。
	# 日付と思われる部分だけ抽出している。
	# 解析には 372+19 = 391 バイトあれば足りる。
	# サンプル NEF ファイルに撮影日時と思しき文字列は 4つあるけど、
	# 詳細が分かるまではとりあえず最初の1個のみ Time object にして返す。
	# a19 の部分が時刻の文字列。
	# 4つあるんだけど、それぞれの差異 or 冗長なのかが分からない。
	# 引数 data は File.read で読まれるような文字列
	def taken_date(data)
		unless data.is_a?(String)
			message = "Not string data. Use File#read, not File#readlines."
			raise NefParserTypeError, message
		end

		datetime_str = data.unpack("a372a19a57a19a397a19a1a19")[1]
		#p datetime_str
		#p datetime_str.split(/[ :]/)
		begin
			@date = Time.mktime( * datetime_str.split(/[ :]/) )
		rescue
			raise NefParserNotNefError, "Cannot find taken time."
		end
		return @date
	end

end

