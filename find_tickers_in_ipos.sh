# pull select data from ipos.csv for each ticker that matches from tickers
for i in $(seq 1 $(wc -l tickers | awk '{print $1}')); do 
  key=$(sed -n $i"p" tickers);
  # need to add the check for , in the fields...that is why the vFPAT
  awk -v var=$key -vFPAT='([^,]*)|("[^"]+")' -vOFS=, '$7 ~ var{print $7,$6,var,$15,$2,$3,$4,$5,$1}' ipos.csv | grep -iwP "^\"$key\"" >> matches.csv;
done

# add header to file:
echo '"ipos_ticker","stock_echange_symbol","tickers_from_list","org_uuid","country_code","company_state_code","region","city","company_name"' > matches_final.csv

# remove duplicates
sort matches.csv | uniq >> matches_final.csv

# useful code for counting number of matches for each key: you need to change names of files.
# for i in $(seq 1 $(wc -l ticker_name | awk '{print $1}')); do key=$(sed -n $i"p" ticker_name); num_matches=$(grep -icw "$key" org_uuid.csv); echo $num_matches,$key >> num_matches.csv; done
