import re 
import os 
import sys 
generated_path = '../generated/'

file = sys.argv[1] if sys.argv[1] != None else "temp"

f = open(file,'r') #prepare handle file




module_name = ''
module_start_pattern = r'^module (.+?)\('
module_end_pattern   = r'^endmodule'


wr_file = ''
wrf = None 
with open(file)  as f :
    readlines = f.readlines()
    for l in readlines :
        module_name = re.findall(module_start_pattern,l)
        module_sta_flag = True if re.match(module_start_pattern,l) != None else False 
        module_end_flag = True if re.match(module_end_pattern,l) != None else False 
        if module_sta_flag :
            wr_file = generated_path+module_name[0]+'.v'
            wrf = open(wr_file,'w')

        wrf.write(l)
        if module_end_flag :
            wrf.close()
        