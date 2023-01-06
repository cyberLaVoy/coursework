q = True
r = False
s = False

result = (r or s) and not s or (q and (not s or r )) and q
#result = (r or s) and ((not s or q) and (not s or (not s or r))) and q 
print(result)
