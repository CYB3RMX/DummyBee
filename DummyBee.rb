#!/usr/bin/ruby

require 'socket'

# Banner
puts <<-'EOF'
 ____                                  ____            
|  _ \ _   _ _ __ ___  _ __ ___  _   _| __ )  ___  ___ 
| | | | | | |  _   _ \|  _   _ \| | | |  _ \ / _ \/ _ \
| |_| | |_| | | | | | | | | | | | |_| | |_) |  __/  __/
|____/ \__,_|_| |_| |_|_| |_| |_|\__, |____/ \___|\___|
                                 |___/ v1.0

     A Simple HoneyPot for Catching dummy bees :D

EOF

# Banner for server
b0 = "\t*** Welcome to Administration Server!!! ***"
b1 = "\t-------------------------------------------"
b2 = "+++LOGIN+++"
b3 = "Username: "
b4 = "Password: "
b5 = "Wrong Username or Password!!\n\n"

# Server side
host = ARGV[0]
port = ARGV[1]
honey = TCPServer.open(host, port)
puts "Honey Server started on #{host}:#{port}"
loop {
  begin
    Thread.start(honey.accept) do |victim|
      sock_domain, remote_port, remote_hostname, remote_ip = victim.peeraddr
      connected = "Connection from #{remote_ip}:#{remote_port}"
      system("notify-send '#{connected}'")
      victim.puts(b0)
      victim.puts(b1)
      victim.puts(b2)
      while 1
        victim.puts(b3)
        data = victim.gets
        victim.puts(b4)
        data1 = victim.gets
        victim.puts(b5)
      end
    raise 'Errno::EPIPE'
      system("notify-send 'An error occured in honey server!'")
    rescue 
      puts ""
  end
end
}