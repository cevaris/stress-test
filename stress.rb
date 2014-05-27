require 'net/http'

urls = [
  ['festpix.herokuapp.com', '/photo_sessions/f7d7fbd53e3'],
  ['festpix.herokuapp.com', '/photo_sessions/1ddd133e3ba'],
  ['festpix.herokuapp.com', '/photo_sessions/13150c9fc1b'],
  ['festpix.herokuapp.com', '/photo_sessions/ccf6acc1f45'],
  ['festpix.herokuapp.com', '/photo_sessions/55f8e38390f'],
  ['festpix.herokuapp.com', '/photo_sessions/5edd7878177'],
  ['festpix.herokuapp.com', '/photo_sessions/f7d7fbd53e3'],
  ['festpix.herokuapp.com', '/photo_sessions/9c18b4c6401'],
  ['festpix.herokuapp.com', '/photo_sessions/8afd4b93764'],
  ['festpix.herokuapp.com', '/photo_sessions/new'],
]


times = []
tpool = []
count = 0

num_of_threads = 20
num_of_request = 10

num_of_threads.times do |i|
  tpool << Thread.new {
    Thread.current["mycount"] = count
    count += 1

    num_of_request.times do 
      url = urls.sample
      start = Time.now
      source = Net::HTTP.get(url[0], url[1])
      delta = Time.now - start
      times << delta
      puts "#{(delta)}ms"
    end
  }
end

tpool.each {|t| t.join;}

puts '-----'
average = times.inject{ |sum, el| sum + el }.to_f / times.size
puts "Average = #{average}"
