#!/usr/bin/ruby

require_relative "../lib/basket"

$stdout.puts "Hello. Lets work\n\n"
basket = Basket::Basket.new(ARGV[0])
basket.items.each do |item|
  $stdout.puts "#{item.amount}, #{item.name}, #{item.price_gross}"
end
$stdout.puts "\nSales Taxes: #{sprintf('%.2f', basket.sales_taxes)}"
$stdout.puts "Total: #{sprintf('%.2f',basket.price_sum)}"
$stdout.puts "\n\nCSV exported to #{basket.export_to_csv.path}"
$stdout.puts "\nBye"
