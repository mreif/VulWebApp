'''
Created on 18.09.2013

@author: lvg
'''

if __name__ == '__main__':
    import sys
    eintrag=sys.argv[1].split()
    eintrag=[wort.lower() for wort in eintrag]
    f=open("schimpfe.txt","rb")
    content=f.read().split("\n")
    f.close()
    unerwuenscht=[]
    for wort in content:
        if wort in eintrag:
            unerwuenscht.append(wort)
    sys.stdout.write(",".join(unerwuenscht))