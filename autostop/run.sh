#!/bin/bash

declare -a clef2018=("CD008122" "CD008587" "CD008759" "CD008892" "CD009175" "CD009263" "CD009694" "CD010213" "CD010296" "CD010502" "CD010657"  "CD010864" "CD011053" "CD011126" "CD011420" "CD011431" "CD011515" "CD011602" "CD011686" "CD011912" "CD011926" "CD012009" "CD012010" "CD012083" "CD012165" "CD012179" "CD012216" "CD012281" "CD010680" "CD012599")

#declare -a athome1=("athome100" "athome101" "athome102" "athome103" "athome104" "athome105" "athome106" "athome107" "athome108" "athome109")
declare -a athome1=("athome105")
declare -a athome3=("athome3089" "athome3133" "athome3226" "athome3290" "athome3357" "athome3378" "athome3423" "athome3431" "athome3481" "athome3484")
declare -a athome2=("athome2052" "athome2108" "athome2129" "athome2130" "athome2134" "athome2158" "athome2225" "athome2322" "athome2333" "athome2461")
declare -a athome4=('401'  '402'  '403'  '404'  '405'  '406'  '407'  '408'  '409'  '410'  '411'  '412'  '413'  '414'  '415'  '416'  '417'  '418'  '419'  '420'  '421'  '422'  '423'  '424'  '425'  '426'  '427'  '428'  '429'  '430'  '431'  '432'  '433'  '434' )

#declare -a clef2017=("CD007431" "CD008081" "CD008760" "CD008782" "CD008803" "CD009135" "CD009185" "CD009372" "CD009519" "CD009551" "CD009579" "CD009647" "CD009786" "CD009925" "CD010023" "CD010173" "CD010276" "CD010339" "CD010386" "CD010542" "CD010633" "CD010653" "CD010705" "CD010772" "CD010775" "CD010783"
#"CD010860" "CD010896" "CD011145" "CD012019")

declare -a clef2017=('CD007431' 'CD008803' 'CD008782' 'CD009647' 'CD009135' 'CD008760' 'CD010775' 'CD009519' 'CD009372' 'CD010276' 'CD009551' 'CD012019' 'CD008081' 'CD009185' 'CD010339' 'CD010653' 'CD010542' 'CD010896' 'CD010023' 'CD010772' 'CD011145' 'CD010705' 'CD010633' 'CD010173' 'CD009786' 'CD010386' 'CD010783' 'CD010860' 'CD009579' 'CD009925' )


CD008081CD007394CD007427CD008054CD008643CD008782CD009020CD009135CD009519CD009551CD009579CD009591CD009647CD009786CD010023CD010173CD010276CD010339CD010386CD010409CD010438CD010632CD010633CD010653CD010705CD011134CD011549CD011975CD011984CD012019

declare -a clef2018short=("CD012599" "CD012281" "CD011602" "CD010864" "CD008122" "CD010213" "CD010296" "CD010657" "CD011431")

input=$1
MAXTHREADS=5
if [ "$input" == "clef2018" ] ; then    
           cat /home/guilherme/Downloads/auto-stop-tar/data/clef2018/qrels/* > /tmp/rel
           for i in "${clef2018[@]}"; do
                while [ "$(jobs | grep 'Running' | wc -l)" -ge "$MAXTHREADS" ]; do
                    sleep 2
                    #echo "sleeping"
                done 
                echo $i
                #./main -c clef2018  -s 1  -t $i -v -o --off-colors &>> out_reveal2/saida.v5.$i  &
                python3 main.py --model knee  --data_name clef2018 --topic_id $i --topic_set 3  
                
                
                
                
           done
        
    
    cat /home/guilherme/Downloads/auto-stop-tar/ret/clef2018/tar_run/knee*/3/0/* > /tmp/all.run
    
    
    pushd ../scripts/
    python3 tar_eval.py /tmp/rel /tmp/all.run &> /tmp/saida
    popd
    #done
fi


input=$1
MAXTHREADS=3

if [ "$input" == "clef2017" ] ; then    
            parente="/home/guilherme/Downloads/auto-stop-tar/data/clef2017"
            rm -r /home/guilherme/Downloads/auto-stop-tar/ret/clef2017/tar_run/knee*
            for i in "${clef2017[@]}"; do
                while [ "$(jobs | grep 'Running' | wc -l)" -ge "$MAXTHREADS" ]; do
                    sleep 2
                    #echo "sleeping"
                done 
                echo $i
                #./main -c clef2018  -s 1  -t $i -v -o --off-colors &>> out_reveal2/saida.v5.$i  &
                #python3 main.py --model knee  --data_name clef2017 --topic_id $i --topic_set 3  &
                python3 main.py --model knee  --data_name clef2017 --topic_id $i --topic_set 3 --query_file $parente/topics/$i  --qrel_file  $parente/qrels/$i --doc_id_file  $parente/docids/$i   --doc_text_file $parente/doctexts/$i  --stopping_beta 100 --rho 'dynamic'

                
                
                
           done
        
    cat /home/guilherme/Downloads/auto-stop-tar/data/clef2017/qrels/* > /tmp/rel
    cat /home/guilherme/Downloads/auto-stop-tar/ret/clef2017/tar_run/knee*/3/0/* > /tmp/out_reveal2
    pushd ../scripts/
    python3 tar_eval.py /tmp/rel /tmp/out_reveal2 &> /tmp/saida
    popd
    #done
fi



MAXTHREADS=3
if [ "$input" == "tr1" ] ; then    
            parente="/home/guilherme/Downloads/auto-stop-tar/data/tr"
            rm -r /home/guilherme/Downloads/auto-stop-tar/ret/tr/tar_run/scal*/1/0/
           for i in "${athome1[@]}"; do
           
#                 while [ "$(jobs | grep 'Running' | wc -l)" -ge "$MAXTHREADS" ]; do
#                     sleep 2
#                     
#                 done 

                for sub_percentage in 0.8; do 
                    for bound_bt in 70; do
                        for max_or_min in 'min'; do 
                            for bucket_type in 'samplerel'; do
                                for ita in 1.05; do


                                    echo $i;
                                    python3 main.py --model scal  --data_name tr --topic_id $i --topic_set 1 --query_file $parente/topics/$i  --qrel_file  $parente/qrels/$i --doc_id_file  $parente/docids/$i   --doc_text_file $parente/doctexts/$i  --sub_percentage $sub_percentage --bound_bt $bound_bt --target_recall 0.9 --ita $ita --stopping_recall 1.0 --random_state 1 
                                    
                                    cat  /home/guilherme/Downloads/auto-stop-tar//ret/tr/tar_run/scal-sp1.0-sr1.0-tr0.9-spt$sub_percentage-bnd$bound_bt-min-bktsamplerel-ita$ita/1/1/$i.run > all.run 
                                    echo "out size is `wc -l < all.run `"
                                    
                                    
                                    
                                done
                            done
                        done
                    done
                done
#                 rm /home/guilherme/Downloads/auto-stop-tar//data/tr/doctexts/$i
#                 rm /home/guilherme/Downloads/auto-stop-tar//data/tr/docids/$i
#                 ln  /home/guilherme/Downloads/auto-stop-tar//data/tr/doctexts/athome1.collection.json /home/guilherme/Downloads/auto-stop-tar//data/tr/doctexts/$i
#                 ln  /home/guilherme/Downloads/auto-stop-tar//data/tr/docids/athome1.docids.txt /home/guilherme/Downloads/auto-stop-tar//data/tr/docids/$i
                #./main -c clef2018  -s 1  -t $i -v -o --off-colors &>> out_reveal2/saida.v5.$i  &
               # python3 main.py --model knee  --data_name tr --topic_id $i --topic_set 1  & # --bound_bt 110 --sub_percentage 1.0     --ita 1.05 --stopping_recall 0.9
                 
                
                
                
           done
        
    cat /home/guilherme/Downloads/auto-stop-tar/data/tr/qrels/* > /tmp/rel
    cat /home/guilherme/Downloads/auto-stop-tar/ret/tr/tar_run/scal*/1/0/* > /tmp/all.run
    pushd ../scripts/
    python3 tar_eval.py /tmp/rel /tmp/all.run &> /tmp/saida
    popd
    #done
fi

# if [ "$input" == "clef2018check" ] ; then    
#             pushd ../scripts/
#            for i in "${clef2018[@]}"; do
#             
#           echo python tar_eval.py  "/home/guilherme/Downloads/auto-stop-tar/data/clef2017/qrels/$i"  "/home/guilherme/Downloads/auto-stop-tar/ret/clef2018/tar_run/knee-sb100-sp1.0-srNone-rhodynamic/1/0/$i.run"
#              python3 tar_eval.py  /home/guilherme/Downloads/auto-stop-tar/data/clef2018/qrels/$i  /home/guilherme/Downloads/auto-stop-tar/ret/clef2018/tar_run/knee-sb100-sp1.0-srNone-rhodynamic/1/0/$i.run
#              
#             done
#             popd
# fi
