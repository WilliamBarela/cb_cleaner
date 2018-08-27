for file in $(ls *.csv); do
  nof=$(awk 'NR == 1' $file | awk -F, '{print NF}');
  awk -v var=$nof -vFPAT='([^,]*)|("[^"]+")' -vOFS=, 'NF!=var{print FNR,NF,$0}' $file > ./bad_nof_output/"${file%.*}".csv;
  awk -v var=$nof -vFPAT='([^,]*)|("[^"]+")' -vOFS=, 'NF==var{print $0}' $file > ./clean_nof_output/"${file%.*}".csv;
done
