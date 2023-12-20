import sys
import re

mask = r'^(?:(.+)(\.\w+)(\/.+))'

for line in sys.stdin:
    fields = line.strip().split('\t')
    temp = fields[2]
    temp_ = re.search(mask, temp)
    temp_change = '.com'

    fields[2] = temp_.group(1) + temp_change + temp_.group(3)

    print('\t'.join(fields))
    