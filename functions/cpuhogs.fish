function cpuhogs -d 'Find top 10 CPU hogs'
	ps  -axrco pid,state,%cpu,time,command | head
end
