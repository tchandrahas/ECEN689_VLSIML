import csv

def conversions(a):
    out = ['0']*32
    if(a>=0):
        out[0]='0'
    else:
        out[0]='1'
    for i in range(0,15):
        if((int (a)>>i)==0):
            out[i+1] = '0'
        else:
            out[i+1] = str((int (a)>>i) % 2)

    for i in range(0,16):
        a = (a*2)
        #print(str(int(a%2)))
        out[i+15] = str(int(a%2))
    f = open("mnist_test_values.mem", "a")
    f.write(''.join(out))
    f.write('\n')
    f.close()
    print (''.join(out))


with open('mnist_test.csv', 'r') as csvFile:
    reader = csv.reader(csvFile)
    line_count = 0
    for row in reader:
        if line_count != 0:
            element_count = 0
            for each in row:
                if element_count !=0:
                    conversions(float(each)/float(255))
                element_count+=1
            break
        line_count+=1



csvFile.close()
