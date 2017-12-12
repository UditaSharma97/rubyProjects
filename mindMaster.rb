
def posIn_Code(x,code,i)
	pos=i
	while(pos<code.length)
		if(x==code[pos])
			code[pos]="/"
			return pos
		end
		pos+=1
	end
	pos=0
	while(pos<=i)
		if(x==code[pos])
			return -100
		end
		pos+=1
	end
	return 100
end

def takeValidInput()
	str=""
	loop do
		puts "Enter 4 colours only "	
		str=gets.chomp
		str.upcase!
	break if (str.length==4) 
	end
	return str

end

def playerGuess(coode,opt)
	
	puts "\tEnter ur guess"
	
	testcase=1
	while testcase<=6				#takes 6 guesses from user
	
		code =coode.split("")

		str=""						#user's guess
		output=""					#result of guess
		str=takeValidInput();		#takes 4 alphabet long string
		s=str.split("")
		pos=0						
		
		s.each {  |x|				#compares the alphabets of user's guess and code and writes the result to the output string 
		
		posCode=posIn_Code(x,code,pos)			#alphabet's position in the code
		
		if(posCode==100)					#if alphabet is not in the code
			output +="!"
		elsif(pos==posCode)			#if alphabet is in code and at correct position
			output +="$"
		else 									#if alphabet is in code and at incorrect position
			output +="?"
		end	
			pos+=1
		}
		puts output				               #displays output / feedback
		if(output=="$$$$")
			return true							#returns that player won
		else
			puts "\t\t#{6-testcase} turns left !!\n"	
			testcase+=1
		end

	end
	return false								#returns that player lost
end

def generateCode(opt)
code=""
4.times do
		code+=opt[Random.rand(6)]
end
return code
end

def nextGuess(opt,str,output)
	arrC=[]
	arrP=[]
	#arrN||=""
	r=output.split("")
	i=0
	r.each{ |x|
	if(x=="!")
		$arrN +=str[i]
		arrP.push(i);
		str[i]="*"
	elsif(x=="?")
		arrP.push(i);
		arrC.push(str[i])
		#str[i]="-"
	end
	i+=1	
	}
	
	strt=0;last=arrP.length-1
	
	while(strt<last)
		str[arrP[strt]],str[arrP[last]]=str[arrP[last]],str[arrP[strt]]
		strt+=1;last-=1;	
	end
	
	puts "dont use #{$arrN}"
	
	i=0
	while(i!=str.length)
		if(str[i]=="*")
			loop do
				s=opt[Random.rand(6)]
				if(! $arrN.include? s)
					str[i]=s
					break
				end
			end
		end
		i+=1
	end
	return str
end

def computerGuess(coode,opt)
	
	testcase=1
	output=""
	$arrN=""
	while(testcase<=6)
	
	code =coode.split("")
	if(output=="")
		str=generateCode(opt)
	else
		str=nextGuess(opt,str,output)	
	end

	puts "YOUR GUESS IS :"
	puts str
	output=""
	pos=0
	s=str.split("")
	
	s.each{ |x|

	
	posCode=posIn_Code(x,code,pos)

#	puts"\n<><>AFTER<><>"
#	print code
		if(posCode==100)
			output+="!"
		elsif(pos==posCode)
			output+="$"
		else
			output+="?"
		end	
		pos+=1
	}
	puts output
	if(output=="$$$$")
		puts "**********COMPUTER WON*********"
		return
	end
	puts "#{6-testcase} turns left!!! " 
	testcase+=1
	
	end
end


opt=["R","Y","G","B","C","M"]

puts "\t\t\t!!!Welcome to MindMaster!!!"
puts "\tYour options are #{opt}\n\tguess a 4 alphabet colour code made up from them"

code= generateCode(opt)
 puts code

puts "who wants to guess ?? 0 for computer 1 for player"
 turn=gets.chomp
 
	if(turn =="0")
		computerGuess(code,opt) 
	else
		puts "\tWe made a code,its ur turn to guess, u have only 6 chances\n\tAll the Best!"
		if(playerGuess(code,opt))
			puts"********YOU WON*********"
		else
			puts"--------YOU LOST---------"
		end
	end

puts "EXIT--------------"