function cpuhogs --description 'Find CPU hogs'
	ps wwaxr -o pid,stat,%cpu,time,command | head -10
end