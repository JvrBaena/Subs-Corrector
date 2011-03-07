#!/usr/bin/env ruby
# encoding: utf-8

puts "Introduce el fichero a retocar"
file=gets.chomp



puts "Introduce la cantidad de segundos que quieres añadir para sincronizar el audio."
secs=gets.chomp


File.open(file+"_corregido.srt","w") do |f|
	
	File.open(file+".srt").each.collect do|line| 
			
			if(line.include?"-->")
				
				newLine=line.split("-->").collect do |parte|
					
					oldHour = parte.split(":")[0]
					oldMin = parte.split(":")[1]
					oldSecs = parte.split(":")[2].gsub(',','.')
					
					auxSecs=(oldSecs.to_f+secs.to_f).divmod(60)
					if (auxSecs[0]>=1)
						newsecs=auxSecs[1].to_f
						
						auxMins = (oldMin.to_i+auxSecs[0]).divmod(60)
						
						if (auxMins[0]>=1)
							newmin=auxMins[1].to_i
							newHour = oldHour + auxMins[0]
						else
							newmin=oldMin.to_i+auxSecs[0]
							newhour=oldHour
						end
						
					else
						newsecs=oldSecs.to_f+secs.to_f
						newmin = oldMin
						newHour= oldHour
					end
								
					newsecs=sprintf("%.3f", newsecs)
					newsecs=newsecs.to_s.gsub('.',',')
					parte.split(":")[0]+":"+newmin.to_s+":"+newsecs.to_s
				end
				f.puts newLine.join("-->")
							
			else
				f.puts line
			end
			
		end

end