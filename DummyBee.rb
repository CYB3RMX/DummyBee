#!/usr/bin/ruby

require 'socket'

# Getting user permissions
if Process.uid != 0
    puts "[!] You must have root privileges to use this program."
    system("exit 1")
else
  # Banner
  puts <<-'EOF'
   ____                                  ____            
  |  _ \ _   _ _ __ ___  _ __ ___  _   _| __ )  ___  ___ 
  | | | | | | |  _   _ \|  _   _ \| | | |  _ \ / _ \/ _ \
  | |_| | |_| | | | | | | | | | | | |_| | |_) |  __/  __/
  |____/ \__,_|_| |_| |_|_| |_| |_|\__, |____/ \___|\___|
                                   |___/ v1.2

    A Simple HoneyPot for Catching dummy bees :D

  EOF
  
  # Banner for server
  b0 = "\t*** Welcome to Administration Server!!! ***"
  b1 = "\t-------------------------------------------"
  b2 = "+++LOGIN+++"
  b3 = "Username: "
  b4 = "Password: "
  b5 = "Wrong Username or Password!!\n\n"

  # Handling logs
  logfile = File.new("honey.log", "a+")

  # Server side
  host = ARGV[0]
  port = ARGV[1]
  honey = TCPServer.open(host, port)
  puts "Honey Server started on #{host}:#{port}\n\n"
  loop {
    begin
      Thread.start(honey.accept) do |victim|
        # Dynamically logging time
        time1 = Time.new
        timevar = time1.inspect

        # Getting connection information and logging
        sock_domain, remote_port, remote_hostname, remote_ip = victim.peeraddr
        puts "Connection from #{remote_ip}:#{remote_port}"
        logfile.syswrite("Connection from #{remote_ip} at #{timevar}\n")
        system("sudo python3 getInfo.py #{remote_ip}")
        
        # Sending server banner
        victim.puts(b0)
        victim.puts(b1)
        victim.puts(b2)
        
        # Unlimited login area
        while 1
          victim.puts(b3)
          data = victim.gets
          puts "#{data}"
          victim.puts(b4)
          data1 = victim.gets
          puts "#{data1}"
          victim.puts(b5)
        end
        
        # Error handling
        rescue
        end
    end
  }
end
