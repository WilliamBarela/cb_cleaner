nof=$(awk 'NR == 1' people.csv | awk -F, '{print NF}')
awk -vFPAT='([^,]*)|("[^"]+")' -vOFS=, 'NF!=17{print FNR,NF,$0}' people.csv > ./output/not17Fpeopletest.csv
awk -v var=$nof -vFPAT='([^,]*)|("[^"]+")' -vOFS=, 'NF!=var{print FNR,NF,$0}' people.csv > ./output/not17Fpeopletest.csv
